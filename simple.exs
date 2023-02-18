# strings
name = "tomheaton"
string_to_print = "hello #{name}"
IO.puts(string_to_print)
IO.puts(String.upcase(string_to_print))
IO.puts(String.length(string_to_print))

# atoms
apple = :apple
IO.puts(:apple == apple) # true
IO.puts(:apple == :banana) # false
IO.puts("apple is atom? #{is_atom(apple)}") # true

# anonymous functions
add = fn a, b -> a + b end
IO.puts(add.(1, 2)) # 3
IO.puts(is_function(add, 2)) #  the second parameter is the arity

double = fn a -> add.(a, a) end
IO.puts(double.(2)) # 4

# lists
list_a = [1, 2, 3]
list_b = [4, 5, 6]
list_c = list_a ++ list_b

IO.puts(hd(list_c)) # 1
IO.puts(tl(list_c)) # [2, 3, 4, 5, 6]

# tuples
my_tuple = {1, 2, 3}
IO.puts(tuple_size(my_tuple)) # 3
IO.puts(elem(my_tuple, 2)) # 3
my_tuple = put_elem(my_tuple, 2, 4) # {1, 2, 4}
IO.puts(elem(my_tuple, 2)) # 4

# case
case 4 do
  1 -> IO.puts("one")
  2 -> IO.puts("two")
  x when x == 4 -> IO.puts("four")
  _ -> IO.puts("other")
end

# files
f = File.read("test.txt")
case f do
  {:ok, contents} -> IO.puts(contents)
  {:error, reason} -> IO.puts("error: #{reason}")
end

case elem(f, 0) do
  :ok -> IO.puts("ok")
  :error -> IO.puts("error")
end

# cond (similar to else if)
cond do
    1 == 0 -> IO.puts("1 == 1")
    2 == 2 -> IO.puts("2 == 2")
    true -> IO.puts("true")
end

# if and unless
if true do
  IO.puts("true")
end

unless true do
  IO.puts("not true")
end

x = 20
x = if true do # must return value from if statement
    x = x + 1
else
    x = x - 1
end

IO.puts(x) # 21

# keyword lists
keyword_list = [name: "tom", age: 20]

# maps
map = %{name: "tom", age: 20}
IO.puts(map.name) # tom
IO.puts(map[:name]) # tom

map_two = %{:a => 1, :b => 2}
IO.puts(map_two[:a]) # 1
IO.puts(map_two.b) # 2

# advanced maps
users = [
    tom: %{name: "tom", age: 20},
    jane: %{name: "jane", age: 22}
];

IO.puts(users[:tom][:name]) # tom
IO.puts(users[:jane].name) # jane

users = put_in users[:tom].age, 21
IO.puts(users[:tom].age) # 21

users = put_in users[:gonk], %{name: "gonk", age: 20}
IO.puts(users[:gonk].name) # gonk

# modules
defmodule SimpleOld do
  def hello do
    IO.puts("hello")
  end
end

SimpleOld.hello() # hello
Simple.hello() # hello

# structs # TODO: this
# defmodule User do
#   defstruct name: "tom", age: 20
# end

# user = %User{}
# IO.puts(user.name) # tom
# IO.puts(user.age) # 20

# pattern matching named functions

defmodule Math do
    # ? means it will return a boolean
   def zero?(0), do: true
   def zero?(x) when is_integer(x), do: false
end

IO.puts(Math.zero?(0)) # true
IO.puts(Math.zero?(1)) # false

# function capturing

zero_func = &Math.zero?/1
IO.puts(zero_func.(0)) # true
IO.puts(is_function(zero_func, 1)) # true

# default arguments

defmodule Concat do
  def concat(a, b, c \\ "c") do
    a <> b <> c
  end

  # order matters with the pattern matching

  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

IO.puts(Concat.concat("a", "b")) # abc
IO.puts(Concat.concat("a", "b", "cd"))# abcd

IO.puts(Concat.join("a", "b")) # a b
IO.puts(Concat.join("a", "b", "-")) # a-b
IO.puts(Concat.join("a")) # a

# recursion

defmodule Recursion do
  # patten match when n > 0
  def print_n_times(msg, n) when n > 0 do
    IO.puts(msg)
    print_n_times(msg, n - 1)
  end

  # pattern match when n == 0
  def print_n_times(_msg, 0) do
    :ok
  end
end

Recursion.print_n_times("recursion", 4)

# reduce and map

defmodule ReduceAndMap do
  ## reduce

  # pattern match when list is not empty
  def sum_list([head | tail], acCumulativer) do
    sum_list(tail, head + acCumulativer)
  end

  # pattern match when list is empty
  def sum_list([], acCumulativer) do
    acCumulativer
  end

  ## map

  # pattern match when list is not empty
  def double_list([head | tail]) do
    [head * 2 | double_list(tail)]
  end

  # pattern match when list is empty
  def double_list([]) do
    []
  end
end

list = [1, 2, 3, 4, 5]
IO.puts(ReduceAndMap.sum_list(list, 0)) # 15
IO.puts(ReduceAndMap.double_list(list)) # [2, 4, 6, 8, 10]

# enum map and reduce

result = Enum.reduce([1, 2, 3], 0, fn(x, acc) -> x + acc end)
IO.puts(result) # 6

result = Enum.map([1, 2, 3], fn(x) -> x * 2 end)
IO.puts(result) # [2, 4, 6]

## using capture syntax

result = Enum.reduce([1, 2, 3], 0, &+/2)
IO.puts(result) # 6

result = Enum.map([1, 2, 3], &(&1 * 2))
IO.puts(result) # [2, 4, 6]

# enumerables
IO.puts(Enum.count([1, 2, 3])) # 3
# can use range inside enum
IO.puts(Enum.count(1..10)) # 10

defmodule Cumulative do
  def list_count([_ | tail]) do
    1 + list_count(tail)
  end

  def list_count([]) do
    0
  end
end

IO.puts(Cumulative.list_count([1, 2, 3, 4, 5])) # 5

# processes

spawn(fn -> IO.puts("hello from process") end)
pid = spawn(fn -> IO.puts("hello from process") end)
IO.puts(inspect(pid))
IO.puts(Process.alive?(pid)) # true

send(self(), {:hello, "world"})
receive do
  {:hello, value} -> value
  {:goodbye, _} -> "goodbye"
after
  1_000 -> "nothing here after 1 second"
end

## put all the above together
parent = self()
spawn(fn -> send(parent, {:hello, self()}) end)

receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end

# links
self()
spawn_link(fn -> raise "oops" end)

# tasks
Task.start(fn -> raise "oops" end)

# state
{:ok, pid} = KV.start_link()
send(pid, {:get, :hello, self()})
flush()

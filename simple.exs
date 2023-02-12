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

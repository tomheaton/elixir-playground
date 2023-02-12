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

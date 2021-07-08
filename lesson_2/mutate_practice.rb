def test_method
  prompt('test message')
end

test_method           # second, try invoking "test_method" here

def prompt(message)
  Kernel.puts("=> #{message}")
end

test_method           # first, try invoking "test_method" here

=begin
def print_id number
  puts "In method object id = #{number.object_id}"
end
value = 33
puts "Outside method object id = #{value.object_id}"
print_id value
=end


=begin
a = [1, [4, 5, 6], 3]
p a
p a.object_id
puts "\n"

p a[1]
p a[1].object_id
puts "\n"

p a[1][1]
p a[1][1].object_id
puts "\n"

a[1][1] = 'r'

p a
p a.object_id
puts "\n"

p a[1]
p a[1].object_id
puts "\n"

p a[1][1]
p a[1][1].object_id
puts "\n"
=end
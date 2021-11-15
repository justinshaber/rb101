
def fix(value)
  puts "initial object #{value.object_id}"
  value = value.upcase
  puts "upcased object #{value.object_id}"
  value.concat('!')
end
s = 'hello'
puts "original object #{s.object_id}"
t = fix(s)
puts "final object #{t.object_id}"

=begin
On line 8, variable `s` is initialized to point to string `hello`
On line 10, `s` is passed to `fix`. `fix` returns a new string object `HELLO!`
because on line 4 `upcase` called on `value` creates a new string object. We assign the
return value of `value.upcase` back to `value`.
=end


=begin

def fix(value)
  value.upcase!
  value.concat('!')
  value
end
s = 'hello'
t = fix(s)

On line 6 string `hello` is initialized to variable `s`. On line 7,
`s` is passed to `fix`. Within the method, both `s` and `value`
reference string `hello`. When `upcase!` and `concat` are called
on `value`, the original string object is mutated. Back to line 7, 
Variable `t` is initialized to point to the return value of fix, which
is the mutated original string `HELLO!` As a result, after the code runs, 
`s` and `t` both point to the original string object that now contains `HELLO!`.

=end
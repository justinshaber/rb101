# array = []#1, 2, 3, 4, 5]
# p array.shift

# truthy, falsey = array.partition { |elem| elem < 3 }
# p truthy
# p falsey

# p [1, 2, 3, 4, 5].partition { |elem| nil }

hash = {"a": "hello", b: "goodbye", c: "beatle", d: "Bailey" }
p hash.take_while { |pair| k, v = pair; v[0] != 'b' }



%w[bar baz bat bam].none?(/m/) # => false
%w[bar baz bat bam].none?('ba') # => true
{foo: 0, bar: 1, baz: 2}.none?(Hash) # => true
{foo: 0}.none?(Array) # => true
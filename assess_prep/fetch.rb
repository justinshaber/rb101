h = {
  'a' => :a_value,
  'b' => nil,
  'c' => false
}

# p h.fetch('a', :default_value) #=> :a_value
# p h.fetch('b', :default_value) #=> nil
# p h.fetch('c', :default_value) #=> false
# p h.fetch('d', :default_value) #=> :default_value

# p (h['a'] || :default_value) #=> :a_value
# p (h['b'] || :default_value) #=> :default_value
# p (h['c'] || :default_value) #=> :default_value
# p (h['d'] || :default_value) #=> :default_value

# p h['d'] 
# p h.fetch('d', "error")

p h.select! { |k, v| true }
p h

a = [:a_value, nil, false]

# p a.fetch(0, :default_value) #=> :a_value
# p a.fetch(1, :default_value) #=> nil
# p a.fetch(2, :default_value) #=> false
# p a.fetch(3, :default_value) #=> :default_value

# p (a[0] || :default_value) #=> :a_value
# p (a[1] || :default_value) #=> :default_value
# p (a[2] || :default_value) #=> :default_value
# p (a[3] || :default_value) #=> :default_value

# p a[0] #=> :a_value
# p a[1] #=> :default_value
# p a[2] #=> :default_value
# p a[3] #=> :default_value

# p (a.fetch(2, :default_value) || :default_value)
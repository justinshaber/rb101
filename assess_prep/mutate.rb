# a = 'name'
# b = 'name'
# c = 'name'

# # Are these three local variables pointing to the same object?

# a = c # a now points to object referenced by c
# b = a # b now points to object referenced by a, which is object ref'd by c.

# puts a.object_id
# puts b.object_id
# puts c.object_id

# # What about now?
# a = 5
# b = 5
# c = 5

# puts a.object_id
# puts b.object_id
# puts c.object_id

# a = :dog
# b = :dog
# c = :dog

# puts a.object_id
# puts b.object_id
# puts c.object_id

# What is String#[]?

def add_name(arr, name)
  arr = arr + [name]
end

names = ['bob', 'kim']
add_name(names, 'jim')
p names
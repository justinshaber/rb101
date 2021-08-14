def joinor(arr, punct = ", ", and_or = " or ")
  return arr.join if arr.size == 1
  return arr.join(and_or) if arr.size == 2
  
  str = arr.join(punct)
  str[-2] = and_or
  str
end

p joinor([1])
p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', ' and ')   # => "1, 2, and 3"
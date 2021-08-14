def joinor(arr, delimiter = ", ", and_or = "or")
  case arr.size
  when 0 then ''
  when 1 then arr.join
  when 2 then arr.join(" #{and_or} ")
  else
    str = arr.join(delimiter)
    str[-2] = " #{and_or} "
    str
  end
end

p joinor([1])
p joinor([1, 2])                   # => "1 or 2"
p joinor([1, 2, 3])                # => "1, 2, or 3"
p joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
p joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"
arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

new_arr = arr.sort_by do |sub_arr|
  sub_arr.select { |num| num.odd? }
end

p new_arr

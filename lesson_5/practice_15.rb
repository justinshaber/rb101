arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# new_arr = arr.select do |sub_hash|
#             new_sub_hash = sub_hash.select do |_, values_arr|
#               values_arr.all?(&:even?)
#             end
#             sub_hash == new_sub_hash
#           end

# p new_arr

new_arr = arr.select do |sub_hash|
  sub_hash.values.flatten.all?(&:even?)
end

p new_arr
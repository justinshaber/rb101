def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]

  a_outer_id = a_outer.object_id
  b_outer_id = b_outer.object_id
  c_outer_id = c_outer.object_id
  d_outer_id = d_outer.object_id

  puts "a_outer is #{a_outer} [42] with an id of: #{a_outer_id} [85] before the block."
  puts "b_outer is #{b_outer} ['forty two'] with an id of: #{b_outer_id} [60] before the block."
  puts "c_outer is #{c_outer} [[42]] with an id of: #{c_outer_id} [80] before the block."
  puts "d_outer is #{d_outer} [42] with an id of: #{d_outer_id} [85] before the block." # it's actually a0. Both are the number 42
  puts

  1.times do
    a_outer_inner_id = a_outer.object_id
    b_outer_inner_id = b_outer.object_id
    c_outer_inner_id = c_outer.object_id
    d_outer_inner_id = d_outer.object_id

    puts "a_outer id was #{a_outer_id} [85] before the block and is: #{a_outer_inner_id} [85] inside the block."
    puts "b_outer id was #{b_outer_id} [60] before the block and is: #{b_outer_inner_id} [60] inside the block."
    puts "c_outer id was #{c_outer_id} [80] before the block and is: #{c_outer_inner_id} [80] inside the block."
    puts "d_outer id was #{d_outer_id} [85] before the block and is: #{d_outer_inner_id} [85] inside the block."
    puts

    a_outer = 22
    b_outer = "thirty three"
    c_outer = [44]
    d_outer = c_outer[0]

    puts "a_outer inside after reassignment is #{a_outer} [22] with an id of: #{a_outer_id} [85] before and: #{a_outer.object_id} [45] after."
    puts "b_outer inside after reassignment is #{b_outer} ['thirty three'] with an id of: #{b_outer_id} [60] before and: #{b_outer.object_id} [100] after."
    puts "c_outer inside after reassignment is #{c_outer} [[44]] with an id of: #{c_outer_id} [80] before and: #{c_outer.object_id} [120] after."
    puts "d_outer inside after reassignment is #{d_outer} [44] with an id of: #{d_outer_id} [85] before and: #{d_outer.object_id} [89] after."
    puts


    a_inner = a_outer
    b_inner = b_outer
    c_inner = c_outer
    d_inner = c_inner[0]

    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id

    puts "a_inner is #{a_inner} [22] with an id of: #{a_inner_id} [45] inside the block (compared to #{a_outer.object_id} [45] for outer)."
    puts "b_inner is #{b_inner} ['thirty three'] with an id of: #{b_inner_id} [100] inside the block (compared to #{b_outer.object_id} [100] for outer)."
    puts "c_inner is #{c_inner} [[44]] with an id of: #{c_inner_id} [120] inside the block (compared to #{c_outer.object_id} [120] for outer)."
    puts "d_inner is #{d_inner} [44] with an id of: #{d_inner_id} [89] inside the block (compared to #{d_outer.object_id} [89] for outer)."
    puts
  end

  puts "a_outer is #{a_outer} [22] with an id of: #{a_outer_id} [85] BEFORE and: #{a_outer.object_id} [45] AFTER the block."
  puts "b_outer is #{b_outer} ['thirty three'] with an id of: #{b_outer_id} [60]  and: #{b_outer.object_id} [100]  the block."
  puts "c_outer is #{c_outer} [[44]] with an id of: #{c_outer_id} [80]  and: #{c_outer.object_id} [120]  the block."
  puts "d_outer is #{d_outer} [44] with an id of: #{d_outer_id} [85]  and: #{d_outer.object_id} [89]  the block."
  puts

  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end

fun_with_ids
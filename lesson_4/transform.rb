produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

def general_select(hash, criteria)
  selected_produce = []
  produce_array = hash.to_a
  counter = 0

  loop do
    if produce_array[counter].last == criteria
      selected_produce << produce_array[counter]
    end
    counter += 1
    break if counter == produce_array.size
  end
  selected_produce.to_h
end

puts general_select(produce, 'Fruit') # => {"apple"=>"Fruit", "pear"=>"Fruit"}
puts general_select(produce, 'Vegetable') # => {"carrot"=>"Vegetable", "broccoli"=>"Vegetable"}
puts general_select(produce, 'Meat')      # => {}
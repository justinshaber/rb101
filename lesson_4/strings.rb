loop do
  number = rand(1..10)   # a random number between 1 and 10
  puts 'Hello!'
  if number == 5
    puts 'Exiting...'
    break
  end
end

counter = 0

loop do
  counter += 1
  next if counter.odd?
  puts counter
  break if counter > 5
end
p ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.delete_if { |name, age| age >= 100 }

# ages.select! { |name, age| age < 100 }

p ages

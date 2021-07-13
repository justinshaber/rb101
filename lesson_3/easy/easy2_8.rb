advice = "Few things in life are as important as house training your pet dinosaur."
p advice.index('house')
#p advice.slice!(0..38)
p advice.slice!(0, advice.index('house'))
p advice
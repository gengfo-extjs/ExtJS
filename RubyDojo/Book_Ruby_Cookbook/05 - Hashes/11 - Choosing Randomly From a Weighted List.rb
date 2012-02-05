def choose_weighted(weighted)
  sum = weighted.inject(0) do |sum, item_and_weight| 
    sum += item_and_weight[1] 
  end
  target = rand(sum)
  weighted.each do |item, weight|
    return item if target <= weight
    target -= weight
  end
end
#---
marbles = { :black => 51, :white => 17 }
3.times { puts choose_weighted(marbles) }
# black
# white
# black
#---
lottery_probabilities = { "You've wasted your money!" => 1000,
  "You've won back the cost of your ticket!" => 50,
  "You've won two shiny zorkmids!" => 20,
  "You've won five zorkmids!" => 10,
  "You've won ten zorkmids!" => 5,
  "You've won a hundred zorkmids!" => 1 }

# Let's buy some lottery tickets.
5.times { puts choose_weighted(lottery_probabilities) }
# You've wasted your money!
# You've wasted your money!
# You've wasted your money!
# You've wasted your money!
# You've won five zorkmids!
#---
def normalize!(weighted)
  sum = weighted.inject(0) do |sum, item_and_weight| 
    sum += item_and_weight[1] 
  end
  sum = sum.to_f
  weighted.each { |item, weight| weighted[item] = weight/sum }
end

lottery_probabilities["You've won five hundred zorkmids!"] = 0.1
normalize!(lottery_probabilities)
# => { "You've wasted your money!" => 0.920725531718995, 
# =>   "You've won back the cost of your ticket!" => 0.0460362765859497, 
# =>   "You've won two shiny zorkmids!" => 0.0184145106343799, 
# =>   "You've won five zorkmids!" => 0.00920725531718995, 
# =>   "You've won ten zorkmids!" => 0.00460362765859497, 
# =>   "You've won a hundred zorkmids!" => 0.000920725531718995, 
# =>   "You've won five hundred zorkmids!" => 9.20725531718995e-05 }
#---
def choose_weighted_assuming_unity(weighted)
  target = rand
  weighted.each do |item, weight|
    return item if target <= weight
    target -= weight
  end
end

5.times { puts choose_weighted_assuming_unity(lottery_probabilities) }
# You've wasted your money!
# You've wasted your money!
# You've wasted your money!
# You've wasted your money!
# You've won back the cost of your ticket!
#---

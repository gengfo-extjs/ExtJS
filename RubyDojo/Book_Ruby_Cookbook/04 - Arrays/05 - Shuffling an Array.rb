[1,2,3].sort_by { rand }    # => [1, 3, 2]
#---
class Array
  def shuffle!
    each_index do |i| 
      j = rand(length-i) + i
      self[j], self[i] = self[i], self[j]
    end
  end

  def shuffle
    dup.shuffle!
  end  
end
#---
class Card
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end
  
  def to_s
    "#{@suit} of #{@rank}"
  end
end

class Deck < Array
  attr_reader :cards
  @@suits = %w{Spades Hearts Clubs Diamonds}
  @@ranks = %w{Ace 2 3 4 5 6 7 8 9 10 Jack Queen King}
  
  def initialize
    @@suits.each { |suit| @@ranks.each { |rank| self << Card.new(rank, suit) } }
  end
end

deck = Deck.new
deck.collect { |card| card.to_s } 
# => ["Ace of Spades", "2 of Spades", "3 of Spades", "4 of Spades", ... ]

deck.shuffle!
deck.collect { |card| card.to_s } 
# => ["6 of Clubs", "8 of Diamonds", "2 of Hearts", "5 of Clubs", ... ]
#---

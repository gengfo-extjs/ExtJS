survey_results = [1, 2, 7, 1, 1, 5, 2, 5, 1]
distinct_answers = survey_results.uniq           # => [1, 2, 7, 5]
survey_results.uniq!
survey_results                                   # => [1, 2, 7, 5]
#---
require 'set'
survey_results = [1, 2, 7, 1, 1, 5, 2, 5, 1]
distinct_answers = survey_results.to_set
# => #<Set: {5, 1, 7, 2}>

games = [["Alice", "Bob"], ["Carol", "Ted"], 
         ["Alice", "Mallory"], ["Ted", "Bob"]]
players = games.inject(Set.new) { |set, game| game.each { |p| set << p }; set }
# => #<Set: {"Alice", "Mallory", "Ted", "Carol", "Bob"}>

players << "Ted"
# => #<Set: {"Alice", "Mallory", "Ted", "Carol", "Bob"}>
#---
class OrderedSet < Set
  def initialize
    @hash ||= OrderedHash.new
  end
end
#---
a = [1, 2, nil, 3, 3, nil, nil, nil, 5]
a.compact                                  # => [1, 2, 3, 3, 5]

a.delete(3)
a                                          # => [1, 2, nil, nil, nil, nil, 5]
```#---

require 'date'
sunday = DateTime.new(2006, 1, 1)
sunday.year                                      # => 2006
sunday.cwyear                                    # => 2005
sunday.cweek                                     # => 52
sunday.wday                                      # => 0
sunday.cwday                                     # => 7
#---
monday = sunday + 1
monday.cwyear                                    # => 2006
monday.cweek                                     # => 1
#---
(sunday...sunday+7).each do |d|
  puts "#{d.strftime("%a")} #{d.wday} #{d.cwday}"
end
# Sun 0 7
# Mon 1 1
# Tue 2 2
# Wed 3 3
# Thu 4 4
# Fri 5 5
# Sat 6 6
#---

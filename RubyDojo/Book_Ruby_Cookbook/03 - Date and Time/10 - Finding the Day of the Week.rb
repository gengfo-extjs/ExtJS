def every_sunday(d1, d2)
  # You can use 1.day instead of 60*60*24 if you're using Rails.
  one_day = d1.is_a?(Time) ? 60*60*24 : 1
  sunday = d1 + ((7-d1.wday) % 7) * one_day
  while sunday < d2
    yield sunday
    sunday += one_day * 7
  end
end

def print_every_sunday(d1, d2)
  every_sunday(d1, d2) { |sunday| puts sunday.strftime("%x")}
end

print_every_sunday(Time.local(2006, 1, 1), Time.local(2006, 2, 4))
# 01/01/06
# 01/08/06
# 01/15/06
# 01/22/06
# 01/29/06
#---
t = Time.local(2006, 1, 1)
t.strftime("%A %A %A!")                     # => "Sunday Sunday Sunday!"
t.strftime("%a %a %a!")                     # => "Sun Sun Sun!"
#---
require 'date'
module Week
  def week
    (yday + 7 - wday) / 7
  end
end

class Date
  include Week
end

class Time
  include Week
end

saturday = DateTime.new(2005, 1, 1)
saturday.week                                    # => 0
(saturday+1).week                                # => 1   #Sunday, January 2
(saturday-1).week                                # => 52  #Friday, December 31
#---

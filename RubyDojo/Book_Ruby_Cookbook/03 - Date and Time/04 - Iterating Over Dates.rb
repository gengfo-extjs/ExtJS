require 'date'
(Date.new(1776, 7, 2)..Date.new(1776, 7, 4)).each { |x| puts x }
# 1776-07-02
# 1776-07-03
# 1776-07-04

span = DateTime.new(1776, 7, 2, 1, 30, 15)..DateTime.new(1776, 7, 4, 7, 0, 0)
span.each { |x| puts x }
# 1776-07-02T01:30:15Z
# 1776-07-03T01:30:15Z
# 1776-07-04T01:30:15Z

(Time.at(100)..Time.at(102)).each { |x| puts x }
# Wed Dec 31 19:01:40 EST 1969
# Wed Dec 31 19:01:41 EST 1969
# Wed Dec 31 19:01:42 EST 1969
#---
the_first = Date.new(2004, 1, 1)
the_fifth = Date.new(2004, 1, 5)

the_first.upto(the_fifth) { |x| puts x }
# 2004-01-01
# 2004-01-02
# 2004-01-03
# 2004-01-04
# 2004-01-05
#---
class Time
  def step(other_time, increment)
   raise ArgumentError, "step can't be 0" if increment == 0
    increasing = self < other_time
    if (increasing && increment < 0) || (!increasing && increment > 0)
      yield self
      return
    end
    d = self
    begin
      yield d 
      d += increment
    end while (increasing ? d <= other_time : d >= other_time)
  end

  def upto(other_time)
    step(other_time, 1) { |x| yield x }
  end
end

the_first = Time.local(2004, 1, 1)
the_second = Time.local(2004, 1, 2)
the_first.step(the_second, 60 * 60 * 6) { |x| puts x }
# Thu Jan 01 00:00:00 EST 2004
# Thu Jan 01 06:00:00 EST 2004
# Thu Jan 01 12:00:00 EST 2004
# Thu Jan 01 18:00:00 EST 2004
# Fri Jan 02 00:00:00 EST 2004

the_first.upto(the_first) { |x| puts x }
# Thu Jan 01 00:00:00 EST 2004
#---

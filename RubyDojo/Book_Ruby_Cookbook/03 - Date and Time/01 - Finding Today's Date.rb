now = Time.now                    # => Sat Mar 18 16:58:07 EST 2006
now.gmtime                        # => Sat Mar 18 21:58:07 UTC 2006

#The original object was affected by the time zone conversion.
now                               # => Sat Mar 18 21:58:07 UTC 2006
#---
require 'date'
now = DateTime.now                
# => #<DateTime: 70669826362347677/28800000000,-5/24,2299161>
now.to_s                          # => "2006-03-18T16:58:07-0500"
now.new_offset.to_s               # => "2006-03-18T21:58:07Z"

#The original object was not affected by the time zone conversion.
now.to_s                          # => 	"2006-03-18T16:58:07-0500"
#---
now_time = Time.new
now_datetime = DateTime.now
now_time.year                       # => 2006
now_datetime.year                   # => 2006
now_time.hour                       # => 18
now_datetime.hour                   # => 18

now_time.zone                       # => "EST"
now_datetime.zone                   # => "-0500"
now_time.isdst                      # => false
#---
now_datetime.offset                 # => Rational(-5, 24)  # -5 hours
#---
now_time.usec                        # => 247930 
# That is, 247930 microseconds
now_datetime.sec_fraction            # => Rational(62191, 21600000000) 
# That is, about 287921 microseconds
#---
class Date
  def Date.now
    return Date.jd(DateTime.now.jd)
  end
end
puts Date.now
# 2006-03-18
#---
Time.local(1999, 12, 31, 23, 21, 5, 1044)
# => Fri Dec 31 23:21:05 EST 1999

Time.gm(1999, 12, 31, 23, 21, 5, 22, 1044)
# => Fri Dec 31 23:21:05 UTC 1999

Time.local(1991, 10, 1)
# => Tue Oct 01 00:00:00 EDT 1991

Time.gm(2000)
# => Sat Jan 01 00:00:00 UTC 2000
#---
DateTime.civil(1999, 12, 31, 23, 21, Rational(51044, 100000)).to_s
# => "1999-12-31T23:21:00Z"

DateTime.civil(1991, 10, 1).to_s
# => "1991-10-01T00:00:00Z"

DateTime.civil(2000).to_s
# => "2000-01-01T00:00:00Z"
#---
my_offset = DateTime.now.offset                   # => Rational(-5, 24)

DateTime.civil(1999, 12, 31, 23, 21, Rational(51044, 100000), my_offset).to_s
# => "1999-12-31T23:21:00-0500"
#---
#In Italy, 4 Oct 1582 was immediately followed by 15 Oct 1582.
#
Date.new(1582, 10, 4).to_s
# => "1582-10-04"
Date.new(1582, 10, 5).to_s
# ArgumentError: invalid date
Date.new(1582, 10, 4).succ.to_s
# => "1582-10-15"

#In England, 2 Sep 1752 was immediately followed by 14 Sep 1752.
#
Date.new(1752, 9, 2, Date::ENGLAND).to_s  
# => "1752-09-02"
Date.new(1752, 9, 3, Date::ENGLAND).to_s 
# ArgumentError: invalid date
Date.new(1752, 9, 2, DateTime::ENGLAND).succ.to_s 
# => "1752-09-14"
Date.new(1582, 10, 5, Date::ENGLAND).to_s 
# => "1582-10-05"
#---

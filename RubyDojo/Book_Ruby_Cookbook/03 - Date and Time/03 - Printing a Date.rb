require 'date'
Time.now.to_s                               # => "Sat Mar 18 19:05:50 EST 2006"
DateTime.now.to_s                           # => "2006-03-18T19:05:50-0500"
#---
Time.gm(2006).strftime('The year is %Y!')   # => "The year is 2006!"
#---
time = Time.gm(2005, 12, 31, 13, 22, 33)
american_date = '%D'
time.strftime(american_date)               # => "12/31/05"
european_date = '%d/%m/%y'
time.strftime(european_date)               # => "31/12/05"
four_digit_year_date = '%m/%d/%Y'
time.strftime(four_digit_year_date)        # => "12/31/2005"
date_and_time = '%m-%d-%Y %H:%M:%S %Z'
time.strftime(date_and_time)               # => "12-31-2005 13:22:33 GMT"
twelve_hour_clock_time = '%m-%d-%Y %I:%M:%S %p'
time.strftime(twelve_hour_clock_time)      # => "12-31-2005 01:22:33 PM"
word_date = '%A, %B %d, %Y'
time.strftime(word_date)                   # => "Saturday, December 31, 2005"
#---
require 'time'
time.rfc822                         # => "Sat, 31 Dec 2005 13:22:33 -0000"
time.httpdate                       # => "Sat, 31 Dec 2005 13:22:33 GMT"
time.iso8601                        # => "2005-12-31T13:22:33Z"
#---
class Time
  def day_ordinal_suffix
    if day == 11 or day == 12
      return "th"
    else
      case day % 10
      when 1 then return "st"
      when 2 then return "nd"
      when 3 then return "rd"
      else return "th"
      end
    end
  end
end

time.strftime("The %e#{time.day_ordinal_suffix} of %B") # => "The 31st of December"
#---

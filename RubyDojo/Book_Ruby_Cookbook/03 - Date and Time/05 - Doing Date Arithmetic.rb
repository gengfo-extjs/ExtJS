require 'date'
y2k = Time.gm(2000, 1, 1)       # => Sat Jan 01 00:00:00 UTC 2000
y2k + 1                         # => Sat Jan 01 00:00:01 UTC 2000
y2k - 1                         # => Fri Dec 31 23:59:59 UTC 1999
y2k + (60 * 60 * 24 * 365)      # => Sun Dec 31 00:00:00 UTC 2000

y2k_dt = DateTime.new(2000, 1, 1)
(y2k_dt + 1).to_s                  # => "2000-01-02T00:00:00Z"
(y2k_dt - 1).to_s                  # => "1999-12-31T00:00:00Z"
(y2k_dt + 0.5).to_s                # => "2000-01-01T12:00:00Z"
(y2k_dt + 365).to_s                # => "2000-12-31T00:00:00Z"
#---
day_one = Time.gm(1999, 12, 31)               
day_two = Time.gm(2000, 1, 1)
day_two - day_one                           # => 86400.0
day_one - day_two                           # => -86400.0

day_one = DateTime.new(1999, 12, 31)
day_two = DateTime.new(2000, 1, 1)
day_two - day_one                           # => Rational(1, 1)
day_one - day_two                           # => Rational(-1, 1)

# Compare times from now and 10 seconds in the future.
before_time = Time.now
before_datetime = DateTime.now
sleep(10)
Time.now - before_time                      # => 10.003414
DateTime.now - before_datetime              # => Rational(5001557, 43200000000)
#---
require 'rubygems'
require 'active_support'

10.days.ago                                 # => Wed Mar 08 19:54:17 EST 2006
1.month.from_now                            # => Mon Apr 17 20:54:17 EDT 2006
2.weeks.since(Time.local(2006, 1, 1))       # => Sun Jan 15 00:00:00 EST 2006

y2k - 1.day                                 # => Fri Dec 31 00:00:00 UTC 1999
y2k + 6.3.years                             # => Thu Apr 20 01:48:00 UTC 2006
6.3.years.since y2k                         # => Thu Apr 20 01:48:00 UTC 2006
#---
(y2k_dt >> 1).to_s                          # => "2000-02-01T00:00:00Z"
(y2k_dt << 1).to_s                          # => "1999-12-01T00:00:00Z"
#---
y2k + 1.month                               # => Mon Jan 31 00:00:00 UTC 2000
y2k - 1.month                               # => Thu Dec 02 00:00:00 UTC 1999
#---
# Thirty days hath September...
halloween = Date.new(2000, 10, 31)
(halloween << 1).to_s                      # => "2000-09-30"
(halloween >> 1).to_s                      # => "2000-11-30"
(halloween >> 2).to_s                      # => "2000-12-31"

leap_year_day = Date.new(1996, 2, 29)
(leap_year_day << 1).to_s                  # => "1996-01-29"
(leap_year_day >> 1).to_s                  # => "1996-03-29"
(leap_year_day >> 12).to_s                 # => "1997-02-28"
(leap_year_day << 12 * 4).to_s             # => "1992-02-29"
#---

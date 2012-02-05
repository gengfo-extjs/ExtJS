now = Time.now                # => Sat Mar 18 20:15:58 EST 2006
now = now.gmtime              # => Sun Mar 19 01:15:58 UTC 2006
now = now.localtime           # => Sat Mar 18 20:15:58 EST 2006
#---
require 'date'
local = DateTime.now
local.to_s                   # => "2006-03-18T20:15:58-0500"
utc = local.new_offset(0)
utc.to_s                     # => "2006-03-19T01:15:58Z"
#---
local = DateTime.now
utc = local.new_offset

local.offset                  # => Rational(-5, 24)
local_from_utc = utc.new_offset(local.offset)
local_from_utc.to_s           # => "2006-03-18T20:15:58-0500"
local == local_from_utc       # => true
#---
#Convert local (Eastern) time to Pacific time
eastern = DateTime.now
eastern.to_s                           # => "2006-03-18T20:15:58-0500"

pacific_offset = Rational(-7, 24)
pacific = eastern.new_offset(pacific_offset)
pacific.to_s                           # => "2006-03-18T18:15:58-0700"
#---
class Time
  def convert_zone(to_zone)
    original_zone = ENV["TZ"]
    utc_time = dup.gmtime
    ENV["TZ"] = to_zone
    to_zone_time = utc_time.localtime
    ENV["TZ"] = original_zone
    return to_zone_time
  end
end
#---
t = Time.at(1000000000)                # => Sat Sep 08 21:46:40 EDT 2001

t.convert_zone("US/Pacific")           # => Sat Sep 08 18:46:40 PDT 2001

t.convert_zone("US/Alaska")            # => Sat Sep 08 17:46:40 AKDT 2001
t.convert_zone("UTC")                  # => Sun Sep 09 01:46:40 UTC 2001
t.convert_zone("Turkey")               # => Sun Sep 09 04:46:40 EEST 2001
#---
t.convert_zone("Asia/Calcutta")        # => Sun Sep 09 07:16:40 IST 2001
#---
ENV["TZ"] = "Africa/Lagos"
t = Time.at(1000000000)                # => Sun Sep 09 02:46:40 WAT 2001
ENV["TZ"] = nil

t.convert_zone("Singapore")            # => Sun Sep 09 09:46:40 SGT 2001

# Just to prove it's the same time as before:
t.convert_zone("US/Eastern")           # => Sat Sep 08 21:46:40 EDT 2001
#---

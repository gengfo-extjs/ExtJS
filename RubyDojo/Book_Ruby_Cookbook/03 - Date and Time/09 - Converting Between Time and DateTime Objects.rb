require 'date'
class Time
  def to_datetime
    # Convert seconds + microseconds into a fractional number of seconds
    seconds = sec + Rational(usec, 10**6)    

    # Convert a UTC offset measured in minutes to one measured in a
    # fraction of a day.
    offset = Rational(utc_offset, 60 * 60 * 24)
    DateTime.new(year, month, day, hour, min, seconds, offset)
  end
end

time = Time.gm(2000, 6, 4, 10, 30, 22, 4010)    
# => Sun Jun 04 10:30:22 UTC 2000
time.to_datetime.to_s
# => "2000-06-04T10:30:22Z"
#---
class Date
  def to_gm_time
    to_time(new_offset, :gm)
  end

  def to_local_time
    to_time(new_offset(DateTime.now.offset-offset), :local)
  end

  private
  def to_time(dest, method)
    #Convert a fraction of a day to a number of microseconds
    usec = (dest.sec_fraction * 60 * 60 * 24 * (10**6)).to_i
    Time.send(method, dest.year, dest.month, dest.day, dest.hour, dest.min,
              dest.sec, usec)   
  end
end

(datetime = DateTime.new(1990, 10, 1, 22, 16, Rational(41,2))).to_s
# => "1990-10-01T22:16:20Z"
datetime.to_gm_time
# => Mon Oct 01 22:16:20 UTC 1990
datetime.to_local_time
# => Mon Oct 01 17:16:20 EDT 1990
#---
time < datetime
# ArgumentError: comparison of Time with DateTime failed
time.to_datetime < datetime
# => false
time < datetime.to_gm_time
# => false

time - datetime
# TypeError: can't convert DateTime into Float
(time.to_datetime - datetime).to_f
# => 3533.50973962975                           # Measured in days
time - datetime.to_gm_time
# => 305295241.50401                            # Measured in seconds
#---
time                                       # => Sun Jun 04 10:30:22 UTC 2000
time.usec                                  # => 4010

time.to_datetime.to_gm_time                # => Sun Jun 04 10:30:22 UTC 2000
time.to_datetime.to_gm_time.usec           # => 4010

datetime.to_s                              # => "1990-10-01T22:16:20Z"
datetime.to_gm_time.to_datetime.to_s       # => "1990-10-01T22:16:20Z"
#---
def normalize_time_types(array)
  # Don't do anything if all the objects are already of the same type.
  first_class = array[0].class
  first_class = first_class.super if first_class == DateTime
  return unless array.detect { |x| !x.is_a?(first_class) }
  
  normalized = array.collect do |t| 
    if t.is_a?(Date)
      begin 
        t.to_local_time
      rescue ArgumentError # Time out of range; convert to DateTimes instead.
        convert_to = DateTime
        break
      end
    else
      t
    end
  end
  
  unless normalized
    normalized = array.collect { |t| t.is_a?(Time) ? t.to_datetime : t }
  end
  return normalized
end
#---
mixed_array = [Time.now, DateTime.now]
# => [Sat Mar 18 22:17:10 EST 2006, 
#     #<DateTime: 23556610914534571/9600000000,-5/24,2299161>]
normalize_time_types(mixed_array)
# => [Sat Mar 18 22:17:10 EST 2006, Sun Mar 19 03:17:10 EST 2006]
#---
mixed_array << DateTime.civil(1776, 7, 4)
normalize_time_types(mixed_array).collect { |x| x.to_s }
# => ["2006-03-18T22:17:10-0500", "2006-03-18T22:17:10-0500",
# =>  "1776-07-04T00:00:00Z"]
#---

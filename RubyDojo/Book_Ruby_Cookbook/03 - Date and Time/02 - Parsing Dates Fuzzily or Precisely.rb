require 'date'

Date.parse('2/9/2007').to_s
# => "2007-02-09"

DateTime.parse('02-09-2007 12:30:44 AM').to_s
# => "2007-09-02T00:30:44Z"

DateTime.parse('02-09-2007 12:30:44 PM EST').to_s 
# => "2007-09-02T12:30:44-0500"

Date.parse('Wednesday, January 10, 2001').to_s
# => "2001-01-10"
#---
Date.parse('2/9/07').to_s                          # => "0007-02-09"
#---
american_date = '%m/%d/%y'
Date.strptime('2/9/07', american_date).to_s       # => "2007-02-09"
DateTime.strptime('2/9/05', american_date).to_s   # => "2005-02-09T00:00:00Z"
Date.strptime('2/9/68', american_date).to_s       # => "2068-02-09"
Date.strptime('2/9/69', american_date).to_s       # => "1969-02-09"

european_date = '%d/%m/%y'
Date.strptime('2/9/07', european_date).to_s       # => "2007-09-02"
Date.strptime('02/09/68', european_date).to_s     # => "2068-09-02"
Date.strptime('2/9/69', european_date).to_s       # => "1969-09-02"

four_digit_year_date = '%m/%d/%Y'
Date.strptime('2/9/2007', four_digit_year_date).to_s   # => "2007-02-09"
Date.strptime('02/09/1968', four_digit_year_date).to_s # => "1968-02-09"
Date.strptime('2/9/69', four_digit_year_date).to_s     # => "0069-02-09"

date_and_time = '%m-%d-%Y %H:%M:%S %Z'
DateTime.strptime('02-09-2007 12:30:44 EST', date_and_time).to_s
# => "2007-02-09T12:30:44-0500"
DateTime.strptime('02-09-2007 12:30:44 PST', date_and_time).to_s
# => "2007-02-09T12:30:44-0800"
DateTime.strptime('02-09-2007 12:30:44 GMT', date_and_time).to_s
# => "2007-02-09T12:30:44Z"

twelve_hour_clock_time = '%m-%d-%Y %I:%M:%S %p'
DateTime.strptime('02-09-2007 12:30:44 AM', twelve_hour_clock_time).to_s
# => "2007-02-09T00:30:44Z"
DateTime.strptime('02-09-2007 12:30:44 PM', twelve_hour_clock_time).to_s
# => "2007-02-09T12:30:44Z"

word_date = '%A, %B %d, %Y'
Date.strptime('Wednesday, January 10, 2001', word_date).to_s
# => "2001-01-10"
#---
Date.parse('1/10/07').to_s                  # => "0007-01-10"
Date.parse('2007 1 10').to_s
# ArgumentError: 3 elements of civil date are necessary

TRY_FORMATS = ['%d/%m/%y', '%Y %m %d']
def try_to_parse(s)
  parsed = nil
  TRY_FORMATS.each do |format|
    begin
      parsed = strptime(s, format)
      break
    rescue ArgumentError        
    end      
  end
  return parsed
end

try_to_parse('1/10/07').to_s            # => "2007-10-01"
try_to_parse('2007 1 10').to_s          # => "2007-01-10"
#---
require 'time'
mail_received = 'Tue, 1 Jul 2003 10:52:37 +0200'
Time.rfc822(mail_received)
# => Tue Jul 01 04:52:37 EDT 2003
#---
last_modified = 'Tue, 05 Sep 2006 16:05:51 GMT'
Time.httpdate(last_modified)
# => Tue Sep 05 12:05:51 EDT 2006
#---
timestamp = '2001-04-17T19:23:17.201Z'
t = Time.iso8601(timestamp)    # => Tue Apr 17 19:23:17 UTC 2001
t.sec                          # => 17
t.tv_usec                      # => 201000
#---
t = Time.at(1000000000)   # => Sat Sep 08 21:46:40 EDT 2001
t.rfc822                  # => "Sat, 08 Sep 2001 21:46:40 -0400"
t.httpdate                # => "Sun, 09 Sep 2001 01:46:40 GMT"
t.iso8601                 # => "2001-09-08T21:46:40-04:00"
#---

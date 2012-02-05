require 'logger'
$LOG = Logger.new($stderr)
#---
def divide(numerator, denominator)
  $LOG.debug("Numerator: #{numerator}, denominator #{denominator}")
  begin
    result = numerator / denominator
  rescue Exception => e
    $LOG.error "Error in division!: #{e}"
    result = nil
  end
  return result
end

divide(10, 2)
# D, [2006-03-31T19:35:01.043938 #18088] DEBUG -- : Numerator: 10, denominator 2
# => 5

divide(10, 0)
# D, [2006-03-31T19:35:01.045230 #18088] DEBUG -- : Numerator: 10, denominator 0
# E, [2006-03-31T19:35:01.045495 #18088] ERROR -- : Error in division!: divided by 0
# => nil
#---
$LOG.level = Logger::ERROR
#---
divide(10, 2)
# => 5

divide(10, 0)
# E, [2006-03-31T19:35:01.047861 #18088] ERROR -- : Error in division!: divided by 0
# => nil
#---
# Keep data for the current month only
Logger.new('this_month.log', 'monthly')

# Keep data for today and the past 20 days.
Logger.new('application.log', 20, 'daily')

# Start the log over whenever the log exceeds 100 megabytes in size.
Logger.new('application.log', 20, 'daily')
#---
$LOG.datetime_format = '%Y-%m-%d %H:%M:%S'
$LOG.error('This is a little shorter.')
# E, [2006-03-31T19:35:01#17339] ERROR -- : This is a little shorter.
#---
class MyLogger < Logger::Formatter
  def initialize()
    self.datetime_format=("%Y-%m-%d %H:%M:%S")
  end
  def call(severity, time, progname, msg)
    Format % [severity, format_datetime(time), progname, msg]
  end
end

$LOG.formatter = MyLogger.new
$LOG.error('This is much shorter.')
# ERROR [2006-03-31 19:35:01]  This is much shorter.
#---

def every_n_seconds(n)
  loop do
    before = Time.now
    yield
    interval = n-(Time.now-before)
    sleep(interval) if interval > 0
  end
end

every_n_seconds(5) do
 puts "At the beep, the time will be #{Time.now.strftime("%X")}... beep!"
end
# At the beep, the time will be 12:21:28... beep!
# At the beep, the time will be 12:21:33... beep!
# At the beep, the time will be 12:21:38... beep!
# ...
#---
def every_n_seconds(n)
  loop do
    yield
    sleep(n)
  end
end
#---
def every_n_seconds(n)
  thread = Thread.new do
    while true
      before = Time.now
      yield
      interval = n-(Time.now-before)
      sleep(interval) if interval > 0
    end
  end  
  return thread
end
#---
def monitor_changes(file, resolution=1)  
  last_change = Time.now
  every_n_seconds(resolution) do
    check = File.stat(file).ctime
    if check > last_change
      yield file
      last_change = check
    elsif Time.now - last_change > 60
      puts "Nothing's happened for a minute, I'm bored."
      break
    end    
  end
end
#---
thread = monitor_changes("/tmp/foo") { |file| puts "Someone changed #{file}!" }
# "Someone changed /tmp/foo!"
# "Someone changed /tmp/foo!"
# "Nothing's happened for a minute; I'm bored."
thread.status                                          # => false
#---

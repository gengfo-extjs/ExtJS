#!/usr/bin/ruby
# lunchtime.rb

def background_run_at(time) 
  fork do
    sleep(1) until Time.now >= time
    yield
  end
end

today = Time.now
noon = Time.local(today.year, today.month, today.day, 12, 0, 0)
raise Exception, "It's already past lunchtime!" if noon < Time.now

background_run_at(noon) { puts "Lunchtime!" }
#---
#!/usr/bin/ruby
# reminder.rb
def background_every_n_seconds(n)
  fork do
    loop do
      before = Time.now
      yield
      interval = n-(Time.now-before)
      sleep(interval) if interval > 0
    end
  end
end

background_every_n_seconds(15*60) { puts 'Get back to work!' }
#---

require 'osx/cocoa'
include OSX

ZeroDate = NSDate.dateWithString('2000-01-01 00:00:00 +0000')

class Timer < NSObject
    ib_outlets :clock, :timeField, :button
    
    def initialize
        @timer = \
	NSTimer.scheduledTimerWithTimeInterval_target_selector_userInfo_repeats\
	(1.0, self, :tick, nil, true)
    end    
#---
    def start(sender)
        @running = true
       @start = NSDate.date
        @accumulated = 0 unless @accumulated
        @elapsed = 0.0
        @button.setTitle('Stop')
        @button.setAction(:stop)
    end    
#---
    def stop(sender)
        @running = false
        @accumulated += @elapsed
        @button.setTitle('Start')
        @button.setAction(:start)
    end
    
    def reset(sender)
        stop(nil)
        @accumulated, @elapsed = 0.0, 0.0
        @clock.setDateValue(ZeroDate)
        @timeField.setObjectValue(ZeroDate)
    end
    
    def tick()
     if @running
            @elapsed = NSDate.date.timeIntervalSinceDate(@start)
            d = ZeroDate.addTimeInterval(@elapsed + @accumulated)
            @clock.setDateValue(d) 
            @timeField.setObjectValue(d)
        end
    end
end
#---

require 'thread'

class CounterThread < Thread
  def initialize
    @count = 0
    @continue = true

    super do
      @count += 1 while @continue
      puts "I counted up to #{@count} before I was cruelly stopped."      
    end
  end

  def stop
    @continue = false
  end
end

counter = CounterThread.new
sleep 2
counter.stop
# I counted up to 3413544 before I was cruelly stopped.
#---
t = Thread.new { loop { puts 'I am the unstoppable thread!' } }
# I am the unstoppable thread!
# I am the unstoppable thread!
# I am the unstoppable thread!
# I am the unstoppable thread!
t.terminate
#---
class LoopingThread < Thread
  def initialize
    @stopped = false
    @paused = false
    super do 
      before_loop
      until @stopped
        yield
        Thread.stop if @paused
      end
      after_loop
    end
  end  

  def before_loop; end
  def after_loop; end

  def stop
    @stopped = true
  end

  def paused=(paused)
    @paused = paused
    run if !paused
  end
end
#---
class PausableCounter < LoopingThread
  attr_reader :count

  def before_loop
    @count = 0
  end

  def initialize
    super { @count += 1 }
  end

  def after_loop
    puts "I counted up to #{@count} before I was cruelly stopped."      
  end
end

counter = PausableCounter.new
sleep 2
counter.paused = true
counter.count                                              # => 819438
sleep 2
counter.count                                              # => 819438
counter.paused = false
sleep 2
counter.stop
# I counted up to 1644324 before I was cruelly stopped.
counter.count                                              # => 1644324
#---

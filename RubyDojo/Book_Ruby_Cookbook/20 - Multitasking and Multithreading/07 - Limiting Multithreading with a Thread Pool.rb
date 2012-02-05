require 'thread'

class ThreadPool
  def initialize(max_size)
    @pool = []
    @max_size = max_size
    @pool_mutex = Mutex.new
    @pool_cv = ConditionVariable.new  
  end
#---
  def dispatch(*args)    
    Thread.new do
      # Wait for space in the pool.
      @pool_mutex.synchronize do
        while @pool.size >= @max_size          
          print "Pool is full; waiting to run #{args.join(',')}...\n" if $DEBUG
          # Sleep until some other thread calls @pool_cv.signal.
          @pool_cv.wait(@pool_mutex)
        end
      end
#---
      @pool << Thread.current
      begin
        yield(*args)
      rescue => e
        exception(self, e, *args)
      ensure
        @pool_mutex.synchronize do
          # Remove the thread from the pool.
          @pool.delete(Thread.current)
          # Signal the next waiting thread that there's a space in the pool.
          @pool_cv.signal            
        end
      end
    end
  end

  def shutdown
    @pool_mutex.synchronize { @pool_cv.wait(@pool_mutex) until @pool.empty? }
  end

  def exception(thread, exception, *original_args)
    # Subclass this method to handle an exception within a thread.
    puts "Exception in thread #{thread}: #{exception}"
  end  
end
#---
$DEBUG = true
pool = ThreadPool.new(3)

1.upto(5) do |i| 
  pool.dispatch(i) do |i|
    print "Job #{i} started.\n"
    sleep(5-i)
    print "Job #{i} complete.\n"
  end
end
# Job 1 started.
# Job 3 started.
# Job 2 started.
# Pool is full; waiting to run 4...
# Pool is full; waiting to run 5...
# Job 3 complete.
# Job 4 started.
# Job 2 complete.
# Job 5 started.
# Job 5 complete.
# Job 4 complete.
# Job 1 complete.

pool.shutdown
#---

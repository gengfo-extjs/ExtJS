#the first example
class Waiter
  attr_accessor :names
  def initialize(names = "Mr.")
    @names = names
  end
  def greeting
    if @names.nil?
      puts "..."
    elsif @names.respond_to?("each")
       @names.each do |name|
          puts "How are you! #{name}"
       end
    else
        puts "How are you #{@names}"
    end
  end
end

if __FILE__ == $0
  w = Waiter.new
  w.greeting
  
  w.names ="Mr. John"
  w.greeting
  
  w.names =["Mr.John","Cliton Miss","Mr. Tomson"]
  w.greeting
end
  
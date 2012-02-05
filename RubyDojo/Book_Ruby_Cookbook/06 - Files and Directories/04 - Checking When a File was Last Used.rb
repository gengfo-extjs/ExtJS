open("output", "w") { |f| f << "Here's some output.\n" }
stat = File.stat("output")
stat.mtime                               # => Thu Mar 23 12:23:54 EST 2006
stat.atime                               # => Thu Mar 23 12:23:54 EST 2006

sleep(2)
open("output", "a") { |f| f << "Here's some more output.\n" }
stat = File.stat("output")
stat.mtime                               # => Thu Mar 23 12:23:56 EST 2006
stat.atime                               # => Thu Mar 23 12:23:54 EST 2006


sleep(2)
open("output") { |f| contents = f.read }
stat = File.stat("output")
stat.mtime                               # => Thu Mar 23 12:23:56 EST 2006
stat.atime                               # => Thu Mar 23 12:23:58 EST 2006
#---
def save_game(file)
  score = 1000
  open(file, "w") do |f|
    f.puts(score)
    f.puts(Time.new.to_i)
  end
end

#---
def load_game(file)
  open(file) do |f|
    score = f.readline.to_i
    time = Time.at(f.readline.to_i)
    difference = (File.stat(file).mtime - time).abs    
    raise "I suspect you of cheating." if difference > 1
    "Your saved score is #{score}."
  end  
end

#---
save_game("game.sav")

sleep(2)
load_game("game.sav")
# => "Your saved score is 1000."

# Now let's cheat by increasing our score to 9000

open("game.sav", "r+b") { |f| f.write("9") }

load_game("game.sav")
# RuntimeError: I suspect you of cheating.
#---

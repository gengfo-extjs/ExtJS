require 'rubygems'
require 'applescript'

name = AppleScript.gets("What's your name?")

AppleScript.puts("Thank you!")

choice = AppleScript.choose("So which of these is your name?", 
                            ["Leonard", "Mike", "Lucas", name])

if name == choice
  AppleScript.say "You are right!"
  picture = AppleScript.choose_file("Find a picture of yourself")

  if File.exists?(picture)
    AppleScript.say "Thanks, I will now post it on Flickr for you."
    # Exercise for the reader: upload the file to Flickr
  end
else
  AppleScript.say "But you just said your name was #{name}!"
end
#---
script = 'tell application "Finder" to display dialog "Hello World!" ' +
         'buttons {"OK"}'
AppleScript.execute(script)
#---

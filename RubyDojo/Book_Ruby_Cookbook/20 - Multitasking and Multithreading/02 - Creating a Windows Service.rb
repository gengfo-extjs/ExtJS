# rubysrvc.rb
require 'rubygems'
require 'win32/service'
include Win32

SERVICE_NAME = "RubySvc"
SERVICE_DISPLAYNAME = "A Ruby Service"

if ARGV[0] == "register"
  # Start the service.
  svc = Service.new
  svc.create_service do |s|
    s.service_name = SERVICE_NAME
    s.display_name = SERVICE_DISPLAYNAME
    s.binary_path_name = 'C:\InstantRails-1.3\ruby\bin\ruby ' + 
      File.expand_path($0)
    s.dependencies = []
  end
  svc.close
  puts "Registered Service - " + SERVICE_DISPLAYNAME
#---
elsif ARGV[0] == "delete"
  # Stop the service.
  if Service.status(SERVICE_NAME).current_state == "running"
    Service.stop(SERVICE_NAME) 
  end
  Service.delete(SERVICE_NAME)
  puts "Removed Service - " + SERVICE_DISPLAYNAME
else
#---
  if ENV["HOMEDRIVE"]!=nil
    # We are not running as a service, but the user didn't provide any 
    # command line arguments. We've got nothing to do.
    puts "Usage: ruby rubysvc.rb [option]"
    puts "   Where option is one of the following:"
    puts "       register - To register the Service so it " +
         "appears in the control panel"
    puts "       delete   - To delete the Service from the control panel"
    exit
  end
#---
  # If we got this far, we are running as a service.
  class Daemon
    def service_init
      # Give the service time to get everything initialized and running,
      # before we enter the service_main function.	
      sleep 10
    end
    
    def service_main
      fileCount = 0   # Initialize the file counter for the rename
      watchForFile = "c:\\findme.txt"
      while state == RUNNING
        sleep 5
        if File.exists? watchForFile
          fileCount += 1
          File.rename watchForFile, watchForFile + "." + fileCount.to_s
        end
      end
    end
  end
  d = Daemon.new
  d.mainloop
end
#---
$ echo "test" > findme.txt
#---
$ dir findme*
# Volume in drive C has no label.
# Volume Serial Number is 7C61-E72E
# Directory of c:\
# 04/14/2006  02:29 PM                 9 findme.txt.1
#---
s.binary_path_name = 'ruby ' + File.expand_path($0)
#---
def service_main
 begin
  while state == RUNNING
    # Do my work
  end
  # Finish my work
  rescue StandardError, Interrupt => e
    # Handle the error
  end
end
#---

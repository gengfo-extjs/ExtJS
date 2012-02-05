require 'rubygems'
require 'win32/service'
include Win32

puts 'Currently Running Services:'
Service.services do |svc|
  if svc.current_state == 'running'
    puts "#{svc.service_name}\t-\t#{svc.display_name}"
  end
end
# Currently Running Services:
# ACPI    -       Microsoft ACPI Driver
# AcrSch2Svc      -       Acronis Scheduler2 Service
# AFD     -       AFD Networking Support Environment
# agp440  -       Intel AGP Bus Filter
# ...
#---
Service.exists?('dnscache')                   # => true
#---
Service.status('dnscache')
# => #<struct Struct::Win32ServiceStatus 
#      service_type="share process", current_state="running", 
#      controls_accepted=["netbind change", "param change", "stop"], 
#      win32_exit_code=0, service_specific_exit_code=0, check_point=0,
#      wait_hint=0, :interactive?=false, pid=1144, service_flags=0>
#---
Service.stop('dnscache')
Service.status('dnscache').current_state           # => "stopped"
Service.start('dnscache')
Service.status('dnscache').current_state           # => "running"
#---
Service.getdisplayname('dnscache')                 # => "DNS Client"
Service.getservicename('DNS Client')               # => "dnscache"
#---
Service.start('foo')
Service.pause('foo')
Service.resume('foo')
Service.stop('foo')  
#---
Service.status('dnscache').controls_accepted
# => ["netbind change", "param change", "stop"]
#---

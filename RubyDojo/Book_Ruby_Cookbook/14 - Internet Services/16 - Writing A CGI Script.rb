#!/usr/bin/ruby
# ps.cgi

processes = %x{ps aux}.collect do |proc|
  '<tr><td>' + proc.split(/\s+/, 11).join('</td><td>') + '</td></tr>'
end

puts 'Content-Type: text/html'
# Output other HTTP headers here...
puts "\n"

title = %{Processes running on #{ENV['SERVER_NAME'] || `hostname`.strip}}
puts <<-end
  <HTML>
   <HEAD><TITLE>#{title}</TITLE></HEAD>
   <BODY>
   <H1>#{title}</H1>
   <TABLE>
    #{processes.join("\n")}
  </TABLE>
  </BODY>
  </HTML>
end

exit 0
#---
#!/usr/bin/ruby
# ps2.cgi

require 'cgi'

# New CGI object
cgi = CGI.new('html3')

processes = `ps aux`.collect { |proc| proc.split(/\s+/, 11) }

title = %{Processes running on #{ENV['SERVER_NAME'] || %x{hostname}.strip}}

cgi.out do
  cgi.html do
    cgi.head { cgi.title { title } } + cgi.body do
      cgi.table do
        (processes.collect do |fields|
          cgi.tr { fields.collect { |field| cgi.td { field } }.join " " }
        end).join "\n"
      end   
    end
  end
end

exit 0
#---

def between_setup_and_cleanup
  setup()
  begin
   yield
  finally
    cleanup()
  end
end
#---
def write_html(out, doctype=nil)
  doctype ||= %{<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
           "http://www.w3.org/TR/html4/loose.dtd">}
  out.puts doctype
  out.puts '<html>'
  begin
    yield out
  ensure
    out.puts '</html>'
  end
end

write_html($stdout) do |out| 
  out.puts '<h1>Sorry, the Web is closed.</h1>'
end
# <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
#     "http://www.w3.org/TR/html4/loose.dtd">
# <html>
# <h1>Sorry, the Web is closed.</h1>
# </html>
#---
open('output.txt', 'w') do |out| 
  out.puts 'Sorry, the filesystem is also closed.'
end
#---
#!/usr/bin/ruby

# closed_cgi.rb
require 'cgi'
c = CGI.new("html4")
c.out do
  c.html do
    c.h1 { 'Sorry, the Web is closed.' }    
  end
end
#---
Content-Type: text/html
Content-Length: 137

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
  "http://www.w3.org/TR/html4/strict.dtd">
<HTML><H1>Sorry, the Web is closed.</H1></HTML>
#---
require 'rubygems'
require 'builder'
xml = Builder::XmlMarkup.new.message({'type' => 'apology'}) do |b|
  b.content('Sorry, Web Services are closed.')
end
puts xml
# <message type="apology">
#  <content>Sorry, Web Services are closed.</content>
# </message>
#---

#!/usr/bin/ruby
# simple_servlet_server.rb
require 'webrick'
include WEBrick

s = HTTPServer.new(:Port => 8000)            

# Add a mime type for *.rhtml files
HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html')

# Required for CGI on Windows; unnecessary on Unix/Linux
s.config.store( :CGIInterpreter, "#{HTTPServlet::CGIHandler::Ruby}")

# Mount servlets
s.mount('/',       HTTPServlet::FileHandler, '/var/www/html')
s.mount('/bruce',  HTTPServlet::FileHandler, '/home/dibbbr/htdoc')
s.mount('/marty',  HTTPServlet::FileHandler, '/home/wisema/htdoc')

# Trap signals so as to shutdown cleanly.
['TERM', 'INT'].each do |signal|
  trap(signal){ s.shutdown }
end

# Start the server and block on input.
s.start
#---
s.config.store(:DirectoryIndex, 
       	       s.config[:DirectoryIndex] << "default.htm")
#---
#!/usr/bin/ruby
# custom_servlet_server.rb
require 'webrick'
include WEBrick

class CustomServlet < HTTPServlet::AbstractServlet
  def do_GET(request, response)  
    response.status = 200 # Success
    response.body = "Hello World"
    response['Content-Type'] = 'text/plain'
  end

  # Respond with an HTTP POST just as we do for the HTTP GET.
  alias :do_POST :do_GET
end

# Mount servlets.
s = HTTPServer.new(:Port => 8001 )
s.mount('/tricia', CustomServlet )

# Trap signals so as to shutdown cleanly.
['TERM', 'INT'].each do |signal|
  trap(signal){ s.shutdown }
end

# Start the server and block on input.
s.start
#---
#!/usr/bin/ruby 
# certificate_server.rb
require 'webrick' 
require 'thread' 
require 'cgi' 

include WEBrick

class PooledServlet < HTTPServlet::AbstractServlet

  INIT_MUTEX    = Mutex.new
  SERVLET_POOL  = []
  
  @@pool_size = 2
 
  # Create a single instance of the servlet  to avoid repeating the costly
  # initialization.
  def self.get_instance(config, *options)
    unless SERVLET_POOL.size == @@pool_size      
      INIT_MUTEX.synchronize do
        SERVLET_POOL.clear
        @@pool_size.times{ SERVLET_POOL << new( config, *options ) }
      end
    end  
    s = SERVLET_POOL.find{|s| ! s.busy?} while s.nil?
    return s
  end
  
  def self.pool_size( size )
    @@pool_size = size
  end
  
  def busy?
    @busy
  end
  
  def service(req, res)
    @busy = true
    super
    @busy = false
  end 
end
#---
require 'certificate_pdf'

class PDFCertificateServlet < PooledServlet
  
  pool_size 10   
  
  def initialize(server, *options)
    super
    @certificate = Certificate.new(options.first)
  end
#---
  def do_GET(request, response)
    if name = request.query['name']      
      filled_in = @certificate.award_to(CGI.unescape(name))

      response.body            = filled_in.render      
      response.status          = 200                      # Success    
      response['Content-Type'] = 'application/pdf'
      response['Size']         = response.body.size     
    else
      raise HTTPStatus::Forbidden.new("missing attribute: 'name'")      
   end
  end
#---
  # Respond with an HTTP POST just as we do for the HTTP GET
  alias :do_POST :do_GET          
end

# Mount servlets
s = HTTPServer.new(:Port => 8002)
s.mount('/', PDFCertificateServlet, 'Ruby Hacker')

# Trap signals so as to shutdown cleanly.
['TERM', 'INT'].each do |signal|
  trap(signal){ s.shutdown }
end

# Start the server and block on input.
s.start
#---

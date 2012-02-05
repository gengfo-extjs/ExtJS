require 'net/http'
require 'set'

class Net::HTTPResponse
  attr_accessor :final_uri
end

module Net	
  begin
    require 'net/https'	
    HTTPS_SUPPORTED = true
  rescue LoadError
    HTTPS_SUPPORTED = false
  end

  class HTTP
    # Makes an HTTP request and returns the HTTPResponse object.
    # Args: :proxy_host, :proxy_port, :action (:get, :post, etc.),
    #       :data (for :post action), :max_redirects.
    def HTTP.fetch(uri, args={}.freeze, &before_fetching)
      # Process the arguments with default values
      uri = URI.parse(uri) unless uri.is_a? URI      
      proxy_host = args[:proxy_host]
      proxy_port = args[:proxy_port] || 80
      action = args[:action] || :get
      data = args[:data]
      max_redirects = args[:max_redirects] || 10
#---
      # Use a proxy class to create the request object
      proxy_class = Proxy(proxy_host, proxy_port)
      request = proxy_class.new(uri.host, uri.port)
#---
      request.use_ssl = true if HTTPS_SUPPORTED and uri.scheme == 'https'
      yield request if block_given?
#---
      path_query = uri.path + (uri.query ? ('?' + uri.query) : '')
      response request.send(action, path_query, data)
#---
      urls_seen = args[:_urls_seen] || Set.new
      if response.is_a?(Net::HTTPRedirection)         # Redirect
        if urls_seen.size < max_redirects && response['Location']
          urls_seen << uri
          new_uri = URI.parse(response['Location'])
          break if urls_seen.member? new_uri         # Infinite redirect loop

          # Request the new location just as we did the old one.
          new_args = args.dup
          puts "Redirecting to #{new_uri}" if $DEBUG
          new_args[:_urls_seen] = urls_seen
          response = HTTP.fetch(new_uri, new_args, &before_fetching)
        end
      else                                            # No redirect
        response.final_uri = uri
      end
      return response
    end
  end  
end
#---
response = Net::HTTP.fetch("http://google.com/")
puts "#{response.final_uri} body is #{response.body.size} bytes."
# http://www.google.com/ body is 2444 bytes.
#---
response = Net::HTTP.fetch("http://google.com/", 
                           :proxy_host => "164.xxx.xxx.xxx")
puts "#{response.final_uri} body is #{response.body.size} bytes."
# http://www.google.com.sg/ body is 2853 bytes.
#---
response = Net::HTTP.fetch("https://paypal.com/",
                          :proxy_host => "209.xxx.xxx.xxx") do |request|
  request.ca_path = "/etc/ssl/certs/"
  request.verify_mode = OpenSSL::SSL::VERIFY_PEER
end
puts "#{response.final_uri} body is #{response.body.size} bytes."
# https://paypal.com/us/ body is 16978 bytes.
#---

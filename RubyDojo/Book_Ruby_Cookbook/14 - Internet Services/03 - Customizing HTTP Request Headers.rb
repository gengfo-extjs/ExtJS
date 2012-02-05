require 'net/http'
require 'uri'

#A simple wrapper method that accepts either strings or URI objects
#and performs an HTTP GET.
module Net
  class HTTP
    def HTTP.get_with_headers(uri, headers=nil)
      uri = URI.parse(uri) if uri.respond_to? :to_str
      start(uri.host, uri.port) do |http|
        path_query = uri.path + (uri.query ? ('?' + uri.query) : '')
        return http.get(path_query, headers)
      end
    end
  end
end

#Let's get a web page in German.
res = Net::HTTP.get_with_headers('http://www.google.com/',
                                 {'Accept-Language' => 'de'})

#Check a bit of the body to make sure it's really in German.
s = res.body.size
res.body[s-200..s-140]
# => "ngebote</a> - <a href=/intl/de/about.html>Alles \374ber Google</"
#---
Net::HTTP.get_with_headers(url, {'User-Agent' => 'Ruby Web Browser v1.0'})
#---
uncompressed = Net::HTTP.get_with_headers('http://www.cnn.com/')
uncompressed.body.size
# => 65150

gzipped = Net::HTTP.get_with_headers('http://www.cnn.com/',
                                     {'Accept-Encoding' => 'gzip'})
gzipped['Content-Encoding']
# => "gzip"
gzipped.body.size
# => 14600

require 'zlib'
require 'stringio'
body_io = StringIO.new(gzipped.body)
unzipped_body = Zlib::GzipReader.new(body_io).read()
unzipped_body.size
# => 65150
#---
uri = URI.parse('http://www.google.com/')

path_query = uri.path + (uri.query ? ('?' + uri.query) : '')
request = Net::HTTP::Get.new(path_query)
['en_us', 'en', 'en_gb', 'ja'].each do |language|
  request.add_field('Accept-Language', language)
end
request['Accept-Language']
# => "en_us, en, en_gb, ja"

Net::HTTP.start(uri.host, uri.port) do |http|
  response = http.request(request)
  # ... process the HTTPResponse object here
end
#---

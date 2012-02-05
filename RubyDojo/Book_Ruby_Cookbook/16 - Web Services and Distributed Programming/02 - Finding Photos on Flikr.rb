require 'open-uri'
require 'rexml/document'
require 'cgi'

FLICKR_API_KEY = 'Your API key here'
#---
def flickr_call(method_name, arg_map={}.freeze)
  args = arg_map.collect {|k,v| CGI.escape(k) + '=' + CGI.escape(v)}.join('&')
  url = "http://www.flickr.com/services/rest/?api_key=%s&method=%s&%s" %
    [FLICKR_API_KEY, method_name, args]
  doc = REXML::Document.new(open(url).read)
end
#---
def pick_a_photo(tag)
 doc = flickr_call('flickr.photos.search', 'tags' => tag, 'license' => '4',
                   'per_page' => '1')
 photo = REXML::XPath.first(doc, '//photo')
 small_photo_url(photo) if photo
end
#---
def small_photo_url(photo)
 server, id, secret = ['server', 'id', 'secret'].collect do |field|
   photo.attribute(field)
 end
 "http://static.flickr.com/#{server}/#{id}_#{secret}_m.jpg"
end
#---
pick_a_photo('elephants')
# => http://static.flickr.com/32/102580480_506d5865d0_m.jpg

pick_a_photo('what-will-happen-tomorrow')
# => nil
#---

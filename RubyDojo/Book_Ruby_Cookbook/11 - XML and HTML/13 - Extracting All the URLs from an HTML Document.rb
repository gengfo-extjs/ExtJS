require 'uri'

text = %{"My homepage is at 
<a href="http://www.example.com/">http://www.example.com/</a>, and be sure
to check out my weblog at http://www.example.com/blog/. Email me at <a
href="mailto:bob@example.com">bob@example.com</a>.}

URI.extract(text)
# => ["http://www.example.com/", "http://www.example.com/",
#     "http://www.example.com/blog/.", "mailto:bob@example.com"]

# Get HTTP(S) links only.
URI.extract(text, ['http', 'https'])
# => ["http://www.example.com/", "http://www.example.com/" 
#     "http://www.example.com/blog/."]
#---
require 'rexml/document'
require 'rexml/streamlistener'
require 'set'

class LinkGrabber
  include REXML::StreamListener
  attr_reader :links
  
 def initialize(interesting_tags = {'a' => %w{href}, 'img' => %w{src}}.freeze)
    @tags = interesting_tags
    @links = Set.new
  end

  def tag_start(name, attrs)
    @tags[name].each do |uri_attr|
      @links << attrs[uri_attr] if attrs[uri_attr]
    end if @tags[name]
  end

  def parse(text)
    REXML::Document.parse_stream(text, self)    
  end
end

grabber = LinkGrabber.new
grabber.parse(text)
grabber.links
# => #<Set: {"http://www.example.com/", "mailto:bob@example.com"}>
#---
END_CHARS = %{.,'?!:;}
URI.extract(text, ['http']).collect { |u| END_CHARS.index(u[-1]) ? u.chop : u }
# => ["http://www.example.com/", "http://www.example.com/", 
#     "http://www.example.com/blog/"]
#---
class AbsoluteLinkGrabber < LinkGrabber
  include REXML::StreamListener
  attr_reader :links
  
  def initialize(original_url = nil,
             interesting_tags = {'a' => %w{href}, 'img' => %w{src}}.freeze)
    super(interesting_tags)
    @base = original_url
  end
  
  def tag_start(name, attrs)    
    if name == 'base'
      @base = attrs['href']
    end
    super
  end

  def parse(text)
    super
    # If we know of a base URL by the end of the document, use it to
    # change all relative URLs to absolute URLs.
    @links.collect! { |l| URI.join(@base, l) } if @base
  end
end
#---
URL_LOCATIONS = { 'a' => %w{href},
  'area' => %w{href},
  'applet' => %w{classid},
  'base' => %w{href},
  'blockquote' => %w{cite},
  'body' => %w{background},   
  'codebase' => %w{classid},
  'del' => %w{cite},
  'form' => %w{action},
  'frame' => %w{src longdesc},
  'iframe' => %w{src longdesc},
  'input' => %w{src usemap},
  'img' => %w{src longdesc usemap},
  'ins' => %w{cite},
  'link' => %w{href},
  'object' => %w{usemap archive codebase data},
  'profile' => %w{head},
  'q' => %w{cite},
  'script' => %w{src}}.freeze
#---

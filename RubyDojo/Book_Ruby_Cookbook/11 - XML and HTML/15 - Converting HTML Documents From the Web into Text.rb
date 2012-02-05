require 'open-uri'

example = open('http://www.example.com/')
# => #<StringIO:0xb7bb601c>

html = example.read
#---
plain_text = html.sub(%r{<body.*?>(.*?)</body>}mi, '\1').gsub(/<.*?>/m, ' ').
	gsub(%r{(\n\s*){2}}, "\n\n")
#---
require 'cgi'
plain_text = CGI.unescapeHTML(plain_text)
#---
puts plain_text	
# Example Web Page 
# 
# You have reached this web page by typing "example.com",
# "example.net",
# or "example.org" into your web browser. 
# These domain names are reserved for use in documentation and are not available
# for registration. See  RFC 
# 2606 , Section 3.
#---
require 'open-uri'
require 'cgi'

class HTMLSanitizer
  attr_accessor :html
  
  @@ignore_tags = ['head', 'script', 'frameset' ]
  @@inline_tags = ['span', 'strong', 'i', 'u'   ]
  @@block_tags  = ['p', 'div', 'ul', 'ol'       ]
#---
  def initialize(source='')
    begin
      @html = open(source).read
    rescue Errno::ENOENT
      # If it's not a file, assume it's an HTML string
      @html = source
    end
  end
  
  def plain_text
    # remove pre-existing blank spaces between tags since we will
    # be adding spaces on our own
    @plain_text = @html.gsub(/\s*(<.*?>)/m, '\1')

    handle_ignore_tags
    handle_inline_tags
    handle_block_tags
    handle_all_other_tags
	
    return CGI.unescapeHTML(@plain_text)
  end
#---
  private
  
  def tag_regex(tag)
    %r{<#{tag}.*?>(.*?)</#{tag}>}mi
  end
  
  def handle_ignore_tags
   @@ignore_tags.each { |tag| @plain_text.gsub!(tag_regex(tag), '') }
  end
  def handle_inline_tags
    @@inline_tags.each { |tag| @plain_text.gsub!(tag_regex(tag), '\1 ') }
  end
  def handle_block_tags
    @@block_tags.each { |tag| @plain_text.gsub!(tag_regex(tag), "\n\\1\n") }
  end

  def handle_all_other_tags
    @plain_text.gsub!(/<br.*?>/mi, "\n")
    @plain_text.gsub!(/<.*?>/m, ' ')
    @plain_text.gsub!(/(\n\s*){2}/, "\n\n")
  end
end
#---
puts HTMLSanitizer.new('http://slashdot.org/').plain_text
# Stories 
# Slash Boxes 
# Comments 
# 
# Slashdot  
# 
# News for nerds, stuff that matters 
# 
# Login  
# 
# Why Login?    Why Subscribe?  
# ...
#---

require 'rubygems'
require 'rubyful_soup'

invalid_html = 'A lot of <b class=1>tags are <i class=2>never closed.'
soup = BeautifulSoup.new(invalid_html)
puts soup.prettify
# A lot of
#  <b class="1">tags are
#   <i class="2">never closed.
#   </i>
#  </b>

soup.b.i                                 # => <i class="2">never closed.</i>
soup.i                                   # => <i class="2">never closed.</i>
soup.find(nil, :attrs=>{'class' => '2'}) # => <i class="2">never closed.</i>
soup.find_all('i')                       # => [<i class="2">never closed.</i>]

soup.b['class']                          # => "1"

soup.find_text(/closed/)                 # => "never closed."
#---
require 'rubygems'
require 'html/sgml-parser'
require 'set'

html = %{<a name="anchor"><a href="http://www.oreilly.com">O'Reilly</a>
         <b>irrelevant</b><a href="http://www.ruby-lang.org/">Ruby</a>}

class LinkGrabber < HTML::SGMLParser
  attr_reader :urls

  def initialize
    @urls = Set.new
    super
  end

  def do_a(attrs)
    url = attrs.find { |attr| attr[0] == 'href' }
    @urls << url[1] if url
  end
end

extractor = LinkGrabber.new
extractor.feed(html)
extractor.urls
# => #<Set: {"http://www.ruby-lang.org/", "http://www.oreilly.com"}>
#---
require 'rubyful_soup'

urls = Set.new
BeautifulStoneSoup.new(html).find_all('a').each do |tag|
  urls << tag['href'] if tag['href']
end
#---
puts BeautifulStoneSoup.new(html, :parse_only_these => 'a')
# <a name="anchor"></a>
# <a href="http://www.oreilly.com">O'Reilly</a>
# <a href="http://www.ruby-lang.org/">Ruby</a>
#---

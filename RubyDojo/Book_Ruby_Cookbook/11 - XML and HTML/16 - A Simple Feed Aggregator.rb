require 'rss/2.0'
require 'open-uri'

url = 'http://www.oreillynet.com/pub/feed/1?format=rss2'
feed = RSS::Parser.parse(open(url).read, false)
puts "=== Channel: #{feed.channel.title} ==="
feed.items.each do |item|
  puts item.title
  puts " (#{item.link})"
  puts
  puts item.description
end
# === Channel: O'Reilly Network Articles ===
# How to Make Your Sound Sing with Vocoders
# (http://digitalmedia.oreilly.com/2006/03/29/vocoder-tutorial-and-tips.html)
# ...
#---
require 'rubygems'
require 'simple-rss'
url = 'http://www.oreillynet.com/pub/feed/1?format=rss2'
feed = RSS::Parser.parse(open(url).read, false)
puts "=== Channel: #{feed.channel.title} ==="
feed.items.each do |item|
  puts item.title
  puts " (#{item.link})"
  puts
  puts item.description
end
#---
#!/usr/bin/ruby
# rss-aggregator.rb - Simple RSS and Atom Feed Aggregator

require 'rubygems'
require 'simple-rss'
require 'open-uri'

class RSSAggregator 
  def initialize(feed_urls)
    @feed_urls = feed_urls
    @feeds = []
    read_feeds
  end
  
  protected
  def read_feeds
    @feed_urls.each { |url| @feeds.push(SimpleRSS.new(open(url).read)) }
  end

  public
  def refresh
    @feeds.clear
    read_feeds
  end

  def channel_counts
    @feeds.each_with_index do |feed, index|
      channel = "Channel(#{index.to_s}): #{feed.channel.title}" 
      articles = "Articles: #{feed.items.size.to_s}" 
      puts channel + ', ' + articles
    end
  end

  def list_articles(id)
    puts "=== Channel(#{id.to_s}): #{@feeds[id].channel.title} ==="
    @feeds[id].items.each { |item| puts ' ' + item.title }
  end
      
  def list_all
    @feeds.each_with_index { |f, i| list_articles(i) }
  end 
end
#---
test = RSSAggregator.new(ARGV)
test.channel_counts
puts "\n"
test.list_all
#---
$ ruby rss-aggregator.rb http://www.rubyriver.org/rss.xml \
  http://rss.slashdot.org/Slashdot/slashdot \
  http://www.oreillynet.com/pub/feed/1 \
  http://safari.oreilly.com/rss/
Channel(0): RubyRiver, Articles: 20
Channel(1): Slashdot, Articles: 10
Channel(2): O'Reilly Network Articles, Articles: 15
Channel(3): O'Reilly Network Safari Bookshelf, Articles: 10
=== Channel(0): RubyRiver ===
 Mantis style isn't eas...
 It's wonderful when tw...
 Red tailed hawk
 37signals
 ...
#---

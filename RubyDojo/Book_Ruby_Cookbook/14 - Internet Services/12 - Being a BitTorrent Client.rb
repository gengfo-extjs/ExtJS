require 'rubytorrent'
file = 'http://publicdomaintorrents.com/bt/btdownload.php?type=torrent' +
        '&file=Night_of_the_Living_Dead.avi.torrent'
client = RubyTorrent::BitTorrent.new(file)
#---
client.num_active_peers                     # => 9
# That is, 9 other people are downloading this file along with me.

client.ulrate                               # => 517.638825414351
client.dlrate                               # => 17532.608916979
# That is, about 3 kb/sec uploading and 17 kb/sec downloading.

client.percent_completed                    # => 0.25
#---
#!/usr/bin/ruby
# btclient.rb
require 'rubytorrent'

def download(torrent, destination=nil, local_port=6881, max_ul=40)
  client = RubyTorrent::BitTorrent.new(torrent, destination,
                                       :port => local_port, 
                                       :ulratelim => max_ul * 1024)  

  thread = Thread.new do       
    until client.complete?
      if client.tracker
        puts '%s: %dk of %dk (%.2f%% complete)' % [Time.now,
          client.bytes_completed / 1024, client.total_bytes / 1024,
          client.percent_completed]
        sleep(60)
      else
        sleep(5)
      end
    end
  end

  client.on_event(self, :tracker_connected) do |src, url| 
    puts "[Connected to tracker at #{url}]"
  end
  client.on_event(self, :added_peer) do |src, peer| 
    puts "[Connected to #{peer}.]"
  end
  client.on_event(self, :removed_peer) do |src, peer| 
    puts "[Lost connection to #{peer.name}.]"
  end
  client.on_event(self, :complete) do
    puts 'Download complete.'
    thread.kill
    client.shutdown
  end  

  thread.join
end

download(*ARGV)
#---

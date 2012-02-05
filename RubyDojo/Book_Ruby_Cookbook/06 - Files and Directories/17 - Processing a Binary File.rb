open('binary', 'wb') do |f|
  (0..100).step(10) { |b| f << b.chr }
end

s = open('binary', 'rb') { |f| f.read } 
# => "\000\n\024\036(2<FPZd"
#---
open('binary', 'rb') { |f| f.each_byte { |b| puts b } }
# 0
# 10
# 20
# ...
# 90
# 100
#---
f = open('binary')
f.pos                                                  # => 0
f.read(1)                                              # => "\000"
f.pos                                                  # => 1
#---
f.pos = 4                                              # => 4
f.read(2)                                              # => "(2"
f.pos                                                  # => 6
#---
f.seek(8)                                    
f.pos                                                  # => 8

f.seek(-4, File::SEEK_CUR)
f.pos                                                  # => 4
f.seek(2, File::SEEK_CUR)
f.pos                                                  # => 6

# Move to the second-to-last byte of the file.
f.seek(-2, File::SEEK_END)                                    
f.pos                                                  # => 9
#---
f.read(500)                                            # => "Zd"
f.pos                                                  # => 11
f.eof?                                                 # => true
f.close
#---
f = open('binary', 'rb+')
f.read                                    # => "\000\n\024\036(2<FPZd"          
f.pos = 2
f.write('Hello.')
f.rewind
f.read                                    # => "\000\nHello.PZd"
f << 'Goodbye.'
f.rewind
f.read                                    # => "\000\nHello.PZdGoodbye."

f.close
#---
def parse_id3(mp3_file)
  fields_and_sizes = [[:track_name, 30], [:artist_name, 30], 
                      [:album_name, 30], [:year, 4], [:comment, 30], 
                      [:genre, 1]]
  tag = {}
  open(mp3_file) do |f|
    f.seek(-128, File::SEEK_END)
    if f.read(3) == 'TAG' # An ID3 tag is present
      fields_and_sizes.each do |field, size|
        # Read the field and strip off anything after the first null 
        # character.
        data = f.read(size).gsub(/\000.*/, '')
        # Convert the genre string to a number.
        data = data[0] if field == :genre
        tag[field] = data
      end
    end
  end
  return tag
end

parse_id3('ID3.mp3')
# => {:year=>"2005", :artist_name=>"The ID Three", 
#     :album_name=>"Binary Brain Death", 
#     :comment=>"http://www.example.com/id3/", :genre=>22, 
#     :track_name=>"ID 3"}

parse_id3('Too Indie For ID3 Tags.mp3')         # => {}
#---
#Returns [track, artist, album, year, comment, genre]
def parse_id3(mp3_file)
  format = 'Z30Z30Z30Z4Z30C'
  open(mp3_file) do |f|
    f.seek(-128, File::SEEK_END)
    if f.read(3) == "TAG" # An ID3 tag is present
      return f.read(125).unpack(format)
    end
  end
  return nil
end

parse_id3('ID3.mp3')
# => ["ID 3", "The ID Three", "Binary Brain Death", "2005", "http://www.example.com/id3/", 22]
#---
id3 = ["ID 3", "The ID Three", "Binary Brain Death", "2005", 
       "http://www.example.com/id3/", 22]
id3.pack 'Z30Z30Z30Z4Z30C'
# => "ID 3\000\000\000\000\000...http://www.example.com/id3/\000\000\000\026"
#---

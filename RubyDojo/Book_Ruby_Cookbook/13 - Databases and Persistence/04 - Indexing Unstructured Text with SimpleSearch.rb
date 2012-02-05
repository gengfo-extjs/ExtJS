require 'rubygems'
require 'search/simple'

contents = Search::Simple::Contents.new
contents << Search::Simple::Content.
              new('In the beginning God created the heavens...',
                  'Genesis.txt', Time.now)
contents << Search::Simple::Content.new('Call me Ishmael...',
	                                'MobyDick.txt', Time.now)
contents << Search::Simple::Content.new('Marley was dead to begin with...',
	                                'AChristmasCarol.txt', Time.now)

searcher = Search::Simple::Searcher.load(contents, 'index_file')
#---
require 'rubygems'
require 'search/simple'

searcher = nil
open('index_file') do |f|
  searcher = Search::Simple::Searcher.new(Marshal.load(f), Marshal.load(f),
	                                  'index_file')
end

searcher.find_words(['begin']).results.collect { |result| result.name }
# => ["AChristmasCarol.txt", "Genesis.txt"]

#---
class Search::Simple::Searcher
  def add_contents(contents)
     Search::Simple::Searcher.create_indices(contents, @dict, 
                                             @document_vectors)
     dump                             # Re-serializes the file
  end
end

contents = Search::Simple::Contents.new
contents << Search::Simple::Content.new('A spectre is haunting Europe...',
	     	                        'TheCommunistManifesto.txt', Time.now)
searcher.add_contents(contents)
searcher.find_words(['spectre']).results[0].name
# => "TheCommunistManifesto.txt"
#---

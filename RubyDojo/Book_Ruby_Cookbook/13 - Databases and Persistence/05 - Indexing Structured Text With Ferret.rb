require 'rubygems'
require 'ferret'

PACKAGE_INDEX_DIR = 'ruby_packages/'
Dir.mkdir(PACKAGE_INDEX_DIR) unless File.directory? PACKAGE_INDEX_DIR
index = Ferret::Index::Index.new(:path => PACKAGE_INDEX_DIR,
                                 :default_search_field => 'name|description')
index << { :name => 'SimpleSearch', 
	   :description => 'A simple indexing library.',
           :supports_structured_data => false,
           :complexity => 2 }
index << { :name => 'Ferret',
           :description => 'A Ruby port of the Lucene library. 
                            More powerful than SimpleSearch',
           :supports_structured_data => true,
           :complexity => 5 }
#---
index.search_each('library') do |doc_id, score| 
  puts index.doc(doc_id).field('name').data
end
# SimpleSearch
# Ferret

index.search_each('description:powerful AND supports_structured_data:true') do
|doc_id, score| 
  puts index.doc(doc_id).field("name").data
end
# Ferret

index.search_each("complexity:<5") do |doc_id, score| 
  puts index.doc(doc_id).field("name").data
end
# SimpleSearch
#---
# This include will cut down on the length of the Field:: constants below.
include Ferret::Document

def index_story(index, db_id, headline, story)
  doc = Document.new
  doc << Field.new("db_id", db_id, Field::Store::YES, Field::Index::NO)
  doc << Field.new("headline", headline, Field::Store::YES, Field::Index::TOKENIZED)
  doc << Field.new("story", story, Field::Store::NO, Field::Index::TOKENIZED)
  index << doc   
end

STORY_INDEX_DIR = 'news_stories/'
Dir.mkdir(STORY_INDEX_DIR) unless File.directory? STORY_INDEX_DIR
index = Ferret::Index::Index.new(:path => STORY_INDEX_DIR)

index_story(index, 1, "Lizardoids Control the Media, Sources Say",
            "Don't count on reading this story in your local paper anytime 
             soon, because ...")

index_story(index, 2, "Where Are My Pants? An Editorial",
            "This is an outrage. The lizardoids have gone too far! ...")
#---
def search_news(index, query)
  results = index.search(query)
  puts "#{results.size} article(s) matched:"
  results.each do |doc_id, score|
    story = index.doc(doc_id)
    puts " #{story.field("headline").data} (score: #{score})"
    puts " http://www.example.com/news/#{story.field("db_id").data}"
    puts
  end
end

search_news(index, "pants editorial")
# 1 article(s) matched:
#  Where Are My Pants? An Editorial (score: 0.0908329636861293)
# http://www.example.com/news/2
#---
search_news(index, "headline:lizardoids^1 OR story:lizardoids^0.5")
# 2 article(s) matched:
#  Lizardoids Control the Media, Sources Say (score: 0.195655948031232)
#  http://www.example.com/news/1
# 
#  Where Are My Pants? An Editorial (score: 0.0838525491562421)
#  http://www.example.com/news/2
#---
def weighted_query(term)
  query = Ferret::Search::BooleanQuery.new
  query << term_clause("headline", term, 1)
  query << term_clause("story", term, 0.5)
end

def term_clause(field, term, weight)
  t = Ferret::Search::TermQuery.new(Ferret::Index::Term.new(field, term))
  t.boost = weight
  return Ferret::Search::BooleanClause.new(t)
end
#---

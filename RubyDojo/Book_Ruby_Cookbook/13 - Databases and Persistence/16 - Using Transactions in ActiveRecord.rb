require 'cookbook_dbconnect'
activerecord_connect # See chapter introduction

class User < ActiveRecord::Base
  has_and_belongs_to_many :blog_posts
end

class BlogPost < ActiveRecord::Base
  has_and_belongs_to_many :authors, :class_name => 'User'
end
#---
require 'active_record/transactions'

class BlogPost
  def BlogPost.create_from_new_author(author_name, title, content)
    transaction do
      author = User.create(:name => author_name)
      raise 'Random failure!' if rand(2) == 0
      create(:authors => [author], :title => title, :content => content)
    end
  end
end
#---
BlogPost.create_from_new_author('Carol', 'The End Is Near', 
                                'A few more facts of doom...')
# => #<BlogPost:0xb78b7c7c ... >

# The method succeeded; Carol's in the database:
User.find(:first, :conditions=>"name='Carol'")
# => #<User:0xb7888ae4 @attributes={"name"=>"Carol", ... }>

# Let's do another one...
BlogPost.create_from_new_author('David', 'The End: A Rebuttal', 
                                'The end is actually quite far away...')
# RuntimeError: Random failure!

# The method failed; David's not in the database:
User.find(:first, :conditions=>"name='David'")
# => nil
#---

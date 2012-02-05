require 'cookbook_dbconnect'
require 'og'
require 'glue/aspects'

class BlogPost
  property :title, :content, String
  after :on => :og_insert do |post|
    puts %{Sending email notification of new post "#{post.title}"}
    # Actually send the email here...
  end
end

og_connect

post = BlogPost.new
post.title = 'Robots are taking over'
post.content = 'Think about it! When was the last time you saw another human?'
post.save!
# Sending email notification of new post "Robots are taking over"
#---
require 'cookbook_dbconnect'
activerecord_connect

class BlogPost < ActiveRecord::Base
  def after_create
    puts %{Sending email notification of new blog post "#{title}"}
    # Actually send the email here...
  end
end

post = BlogPost.create(:title => 'Robots: Gentle Yet Misunderstood',
                       :content => 'Popular misconceptions about robERROR 40')
# Sending email notification of new blog post "Robots: Gentle Yet Misunderstood
#---
require 'cookbook_dbconnect'
activerecord_connect

class BlogPost < ActiveRecord::Base
end

class MailObserver < ActiveRecord::Observer
 observe BlogPost
  def after_create(post)
    puts %{Sending email notification of new blog post "#{post.title}"}
    # Actually send the email here.
  end
end
ActiveRecord::Base.observers = MailObserver

post = BlogPost.new(:title => "ERROR 40",
                    :content => "ERROR ERROR ERROR ERROR ERROR")
post.save
# Sending email notification of new blog post "ERROR 40"
#---
# environment.rb
config.active_record.observers = MailObserver
#---

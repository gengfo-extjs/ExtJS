use cookbook;

DROP TABLE IF EXISTS blog_posts;
CREATE TABLE blog_posts (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(200),
  content TEXT,
  PRIMARY KEY (id)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
  id INT(11) NOT NULL AUTO_INCREMENT,
  blog_post_id INT(11),
  author VARCHAR(200),
  content TEXT,
  PRIMARY KEY (id)
) ENGINE=InnoDB;
#---
require 'cookbook_dbconnect'
activerecord_connect               # See chapter introduction

class BlogPost < ActiveRecord::Base
  has_many :comments
end

class Comment < ActiveRecord::Base
  belongs_to :blog_post
end
#---
post = BlogPost.create(:title => 'First post', 
                       :content => "Here are some pictures of our iguana.")

comment = Comment.create(:blog_post => post, :author => 'Alice',
                         :content => "That's one cute iguana!")

post.comments.create(:author => 'Bob', :content => 'Thank you, Alice!')
#---
blog_post = BlogPost.find(:first)

puts %{#{blog_post.comments.size} comments for "#{blog_post.title}"}
# 2 comments for "First post"

blog_post.comments.each do |comment|
  puts "Comment author: #{comment.author}"
  puts "Comment: #{comment.content}"
end
# Comment author: Alice
# Comment: That's one cute iguana!
# Comment author: Bob
# Comment: Thank you, Alice!

first_comment = Comment.find(:first)
puts %{The first comment was made on "#{first_comment.blog_post.title}"}
# The first comment was made on "First post"
#---
use cookbook;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(200),
  PRIMARY KEY (id)
) ENGINE=InnoDB;
#---
use cookbook;

DROP TABLE IF EXISTS blog_posts_users;
CREATE TABLE blog_posts_users (
  blog_post_id INT(11),
  user_id INT(11)
) ENGINE=InnoDB;
#---
class User < ActiveRecord::Base
  has_and_belongs_to_many :blog_posts
end

class BlogPost < ActiveRecord::Base
  aardvark*has_and_belongs_to_many :authors*aardvark, :class_name => 'User'
  has_many :comments, :dependent => true
end
#---
# Retroactively make Bob and Carol the collaborative authors of our
# first blog post.
User.create(:name => 'Bob', :blog_posts => [post])
User.create(:name => 'Carol', :blog_posts => [post])

author = User.find(:first)
puts "#{author.name} has made #{author.blog_posts.size} blog post(s)."
# Bob has made 1 blog post(s).

puts %{The blog post "#{post.title}" has #{post.authors.size} author(s).}
# The blog post "First post" has 2 author(s).
#---
author.blog_posts.create(:title => 'Second post', 
                         :content => 'We have some cats as well.')
#---
author.blog_posts.each do |post|
  puts %{#{author.name}'s blog post "#{post.title}" } +
       "has #{post.comments.size} comments."
end
# Bob's blog post "First post" has 2 comments.
# Bob's blog post "Second post" has 0 comments.
#---
BlogPost.find(:first).destroy
#---
class BlogPost < ActiveRecord::Base
  has_many :comments, :aardvark*dependent => true*aardvark
end
#---

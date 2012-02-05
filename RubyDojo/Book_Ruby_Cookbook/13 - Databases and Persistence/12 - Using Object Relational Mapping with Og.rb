require 'cookbook_dbconnect'
require 'og'

class BlogPost
  property :title, :content, String
end

class Comment
  property :author, :content, String
  belongs_to :blog_post, BlogPost
end

# Now that Comment's been defined, add a reference to it in BlogPost.
class BlogPost
  has_many :comments, Comment
end
#---
og_connect
# Og uses the Mysql store.
# Created table 'ogcomment'.
# Created table 'ogblogpost'.
#---
post = BlogPost.new
post.title = "First post"
post.content = "Here are some pictures of our iguana."
post.save!

[["Alice", "That's one cute iguana!"], 
 ["Bob", "Thank you, Alice!"]].each do |author, content|
  comment = Comment.new
  comment.blog_post = post
  comment.author = author
  comment.content = content
  comment.save!
end
#---
post = BlogPost.first
puts %{#{post.comments.size} comments for "#{post.title}"}
# 2 comments for "First post"

post.comments.each do |comment|
  puts "Comment author: #{comment.author}"
  puts "Comment: #{comment.content}"
end
# Comment author: Alice
# Comment: That's one cute iguana!
# Comment author: Bob
# Comment: Thank you, Alice!

puts %{The first comment was made on "#{Comment.first.blog_post.title}"}
# The first comment was made on "First post"
#---
class Person
  property :name, String
  many_to_many :posts, BlogPost
end
#---
class BlogPost
  many_to_many :authors, Person
end
#---
og_connect

# Retroactively make Bob and Carol the collaborative authors of our
# first blog post.
['Bob', 'Carol'].each do |name|
  p = Person.new
  p.name = name
  p.save
end
Person.find_by_name('Bob').add_post(post)
Person.find_by_name('Carol').add_post(post)

author = Person.first
puts "#{author.name} has made #{author.posts.size} blog post(s)."
# Bob has made 1 blog post(s).

puts %{The blog post "#{post.title}" has #{post.authors.size} author(s).}
# The blog post "First post" has 2 author(s).
#---
author.add_post(BlogPost.create_with({
    :title => 'Second post',
    :content => 'We have some cats as well.'
  } ))
#---
author.posts.each do |post|
  puts %{#{author.name}'s blog post "#{post.title}" has #{post.comments.size} comments.}
end
# Bob's blog post "First post" has 2 comments.
# Bob's blog post "Second post" has 0 comments.
#---
BlogPost.first.delete
#---
BlogPost.first.delete(false)
#---

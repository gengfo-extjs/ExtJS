require 'rubygems'
require 'action_mailer'

class SimpleMailer < ActionMailer::Base
  def simple_message(recipient)
     from 'leonardr@example.org'
     recipients recipient
     subject 'A single-part message for you'
     body 'This message has a plain text body.'
  end
end
#---
puts SimpleMailer.create_simple_message('lucas@example.com')
# From: leonardr@example.org
# To: lucas@example.com
# Subject: A single-part message for you
# Content-Type: text/plain; charset=utf-8
# 
# This message has a plain text body.
#---
ActionMailer::Base.server_settings = { :address  => 'localhost',
                                       :port  => 25, # 25 is the default
                                       :domain  => 'example.org' } 

SimpleMailer.deliver_simple_message('lucas@example.com')
#---
ActionMailer::Base.server_settings = { :address  => 'smtp.example.org',
                                       :port  => 25, 
                                       :domain  => 'example.org',
                                       :user_name => 'leonardr@example.org',
	                               :password => 'my_password',
                                       :authentication => :login } 

SimpleMailer.deliver_simple_message('lucas@example.com')
#---
class SimpleMailer
  def headerful_message
     @headers['A custom header'] = 'Its value'
     body 'Body'
  end
end

puts SimpleMailer.create_headerful_message
# Content-Type: text/plain; charset=utf-8
# A custom header: Its value
# 
# Body
#---
require 'mime/types'

class SimpleMailer
  def directory_dump_message(recipient, directory)
    from 'directory-dump@example.org'
    recipients recipient
    subject "Dump of #{directory}"
    body %{Here are the files currently in "#{directory}":}
    
    Dir.new(directory).each do |f|
      path = File.join(directory, f)
      if File.file? path
        mime_type = MIME::Types.of(f).first
        content_type = (mime_type ? mime_type.content_type :
                        'application/binary')
        attachment(content_type) do |a| 
          a.body = File.read(path)
          a.filename = f
          a.transfer_encoding = 'quoted-printable' if content_type =~ /^text\//
        end
      end
    end
  end
end

SimpleMailer.create_directory_dump_message('lucas@example.com',
                                                'email_test')
#---
Dir.mkdir('email_test')
open('email_test/image.jpg', 'wb') { |f| f << "\377\330\377\340\000\020JFIF" }
open('email_test/text.txt', 'w') { |f| f << "Here's some text." }

puts SimpleMailer.create_directory_dump_message('lucas@example.com',
                                                'email_test')
# From: directory-dump@example.org
# To: lucas@example.com
# Subject: Dump of email_test
# Mime-Version: 1.0
# Content-Type: multipart/mixed; boundary=mimepart_443d73ecc651_3ae1..fdbeb1ba4328
# 
# 
# --mimepart_443d73ecc651_3ae1..fdbeb1ba4328
# Content-Type: text/plain; charset=utf-8
# Content-Disposition: inline
# 
# Here are the files currently in "email_test":
# --mimepart_443d73ecc651_3ae1..fdbeb1ba4328
# Content-Type: image/jpeg; name=image.jpg
# Content-Transfer-Encoding: Base64
# Content-Disposition: attachment; filename=image.jpg
# 
# /9j/4AAQSkZJRg==
# 
# --mimepart_443d73ecc651_3ae1..fdbeb1ba4328
# Content-Type: text/plain; name=text.txt
# Content-Transfer-Encoding: Quoted-printable
# Content-Disposition: attachment; filename=text.txt
# 
# Here's some text.=
# 
# --mimepart_443d73ecc651_3ae1..fdbeb1ba4328--
#---
require 'net/smtp'
Net::SMTP.start('smtp.example.org', 25, 'example.org',
         	'leonardr@example.org', 'my_password', :login) do |smtp|
  smtp.send_message(message_string, from_address, to_address)
end
#---

./script/generate mailer Notification welcome
      exists  app/models/
      create  app/views/notification
      exists  test/unit/
      create  test/fixtures/notification
      create  app/models/notification.rb
      create  test/unit/notification_test.rb
      create  app/views/notification/welcome.rhtml
      create  test/fixtures/notification/welcome
#---
class Notification < ActionMailer::Base
  def welcome(user, sent_at=Time.now)
    @subject =  'A Friendly Welcome'
    @recipients = user.email
    @from =  'admin@mysite.com'
    @sent_on =    sent_at
    @body = {
      :user => user,
      :sent_on => sent_at
    }
    
    attachment 'text/plain' do |a|
      a.body = File.read('rules.txt')
    end
  end
end
#---
<!-- app/views/notification/welcome.rhtml -->

Hello, <%= @user.name %>, and thanks for signing up at <%= @sent_on
%>. Please print out the attached set of rules and keep them in a
prominent place; they help keep our community running smoothly. Be
sure to pay special attention to sections II.4 ("Assignment of
Intellectual Property Rights") and XIV.21.a ("Dispute Resolution
Through Ritual Combat").
#---
Notification.deliver_welcome(user)
#---
content_type 'text/html'
#---
Rails::Initializer.run do |config|
  config.action_mailer.server_settings = {
    :address => 'someserver.com',
    :user_name => 'uname',
    :password => 'passwd',
    :authentication => 'cram_md5'
  }
end
#---

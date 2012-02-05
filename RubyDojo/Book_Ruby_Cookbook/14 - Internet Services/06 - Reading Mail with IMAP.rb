require 'net/imap'

conn = Net::IMAP.new('mail.myhost.com', 143)
conn.login('username', 'password')
#---
conn.examine('INBOX')
# Use Net::IMAP#select for read-only access
#---
conn.search(['FROM', 'jabba@huttfoundation.org']).each do |sequence|
    fetch_result = conn.fetch(sequence, 'ENVELOPE')
    envelope = fetch_result[0].attr['ENVELOPE']
    printf("%s - From: %s - To: %s - Subject: %s\n", envelope.date, 
  	   envelope.from[0].name, envelope.to[0].name, envelope.subject)
end
# Wed Feb 08 14:07:21 EST 2006 - From: The Hutt Foundation - To: You - Subject: Bwah!
# Wed Feb 08 11:21:19 EST 2006 - From: The Hutt Foundation - To: You - Subject: Go to do wa IMAP

#---
puts "#{conn.responses["RECENT"]} new messages, #{conn.responses["EXISTS"]} total"
# 10 new messages, 1022 total
#---
uids = conn.search(["FROM", "jabba@huttfoundation.org"]).collect do |sequence|
  fetch_result = conn.fetch(sequence, "UID")
  puts "UID: #{fetch_result[0].attr["UID"]}"
end
# UID: 203
# UID: 206
#---
puts conn.uid_fetch(203, 'BODY[TEXT]')[0].attr['BODY[TEXT]']
#---
class Net::IMAP
  def get_msg_info(msg_sequence_num)
    # code we used above
    fetch_result = fetch(msg_sequence_num, '(UID ENVELOPE)')
    envelope = fetch_result[0].attr['ENVELOPE']
    uid = fetch_result[0].attr['UID']
    info = {'UID'     => uid,
            'Date'    => envelope.date,
            'From'    => envelope.from[0].name,
            'To'      => envelope.to[0].name,
            'Subject' => envelope.subject}
  end
end
#---
conn.search(['BEFORE', '01-Jan-2006', 
             'SINCE', '01-Jan-2000']).each do |sequence|
    conn.get_msg_info(sequence).each {|key, val| puts "#{key}: #{val}" }
end
#---
#!/usr/bin/ruby -w
# forward_important_messages.rb

require 'net/imap'
require 'net/smtp'

address = 'huttfoundation.org'
from = 'myhomeemail@my.mailhost.com'
to = '5555555555@mycellphoneprovider.com'
smtp_server = 'my.mailhost.com'
imap_server = 'my.mailhost.com'
username = 'username'
password = 'password'

while true do
  conn = imap = Net::IMAP.new(imap_server, 143)
  conn.login(username, password)
  conn.select('INBOX')
  uids = conn.search(['FROM', address, 'UNSEEN']).each do |sequence|
  	fetch_result = conn.fetch(sequence, 'BODY[TEXT]')
    text = fetch_result[0].attr['BODY[TEXT]']
		count = 1
    while(text.size > 0) do
    	# SMS messages limited to 160 characters
      msg = text.slice!(0, 159)
      full_msg = "From: #{from}\n"
      full_msg += "To: #{to}\n"
      full_msg += "Subject: Found message from #{address} (#{count})!\n"
      full_msg += "Date: #{Time.now}\n"
      full_msg += msg + "\n"
      Net::SMTP.start(smtp_server, 25) do |smtp|
      	smtp.send_message full_msg, from, to
      end
      count += 1
    end
    # set Seen flag, so our search won't find the message again
    conn.store(sequence, '+FLAGS', [:Seen])
  end
  conn.disconnect
  # Sleep for 5 minutes.
  sleep (60*60*5)
end
#---

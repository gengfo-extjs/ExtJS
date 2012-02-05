require 'rubygems'
require 'payment/authorize_net'

transaction = Payment::AuthorizeNet.new(
  :login           => 'username',
  :transaction_key => 'my_key',
  :amount          => '49.95',
  :card_number     => '4012888818888',
  :expiration      => '0310',
  :first_name      => 'John',
  :last_name       => 'Doe'
)
#---
begin
  transaction.submit
  puts "Card processed successfully: #{transaction.authorization}"
rescue Payment::PaymentError
  puts "Card was rejected: #{transaction.error_message}"
end
# Card was rejected: The merchant login ID or password is invalid 
# or the account is inactive.
#---
login: username
transaction_key: my_key
#---
payment = Payment::AuthorizeNet
	.new(:prefs => "#{RAILS_ROOT}/config/payment.yml")
payment.amount = 20
payment.card_number = 'bogus'
payment.submit rescue "That didn't work"
#---

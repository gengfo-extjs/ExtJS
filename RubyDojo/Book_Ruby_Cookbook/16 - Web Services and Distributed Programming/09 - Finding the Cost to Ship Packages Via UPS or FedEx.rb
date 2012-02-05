require 'rubygems'
require 'shipping'

ship = Shipping::Base.new(
  :fedex_url => 'https://gatewaybeta.fedex.com/GatewayDC',
  :fedex_account => '123456789',
  :fedex_meter => '387878',

  :ups_account => '7B4F74E3075AEEFF',
  :ups_user => 'username',
  :ups_password => 'password',

  :sender_zip => 10001                 # It's shipped from Manhattan.
)

ship.weight = 2                        # It weighs two pounds.
ship.city = 'Portland'
ship.state = 'OR'
ship.zip = 97202

ship.ups.price                         # => 8.77
ship.fedex.price                       # => 5.49
ship.ups.valid_address?                # => true
#---
fedex_url: https://gatewaybeta.fedex.com/GatewayDC
fedex_account: 1234556
fedex_meter: 387878

ups_account: 7B4F74E3075AEEFF
ups_user: username
ups_password: password
#---
ship = Shipping::FedEx.new(:prefs => "#{RAILS_ROOT}/config/shipping.yml")

ship.sender_zip = 10001
ship.zip = 97202
ship.state = 'OR'
ship.weight = 2

ship.price > ship.discount_price                             # => true
#---

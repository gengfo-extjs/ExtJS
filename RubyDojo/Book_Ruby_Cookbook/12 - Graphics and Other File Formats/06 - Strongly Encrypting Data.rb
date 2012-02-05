require 'rubygems'
require 'ezcrypto'

plaintext = '24.9195N 17.821E'

ezcrypto_key = EzCrypto::Key.with_password 'My secret key', 'salt string'
ezcrypto_ciphertext = ezcrypto_key.encrypt(plaintext)
# => "F\262\260\273\217\tR\351\362-\021-a\336\324Qc..."

ezcrypto_key.decrypt(ezcrypto_ciphertext)
# => "24.9195N 17.821E"
#---
require 'crypt/rijndael'

aes_key = Crypt::Rijndael.new('My secret key')
aes_cyphertext = aes_key.encrypt_string(plaintext)
# => "\e\003\203\030]\203\t\346..."

aes_key.decrypt_string(aes_cyphertext)
# => "24.9195N 17.821E"
#---
# EzCrypto example
blowfish_key = EzCrypto::Key.with_password('My secret password', 'salt string',
                                           :algorithm=>'blowfish')
# Crypt example
require 'crypt/blowfish'
blowfish_key = Crypt::Blowfish.new('My secret password')
#---

require 'resolv'
Resolv::DNS.new.each_address("oreilly.com") { |addr| puts addr }
# 208.201.239.36
# 208.201.239.37
#---
dns = Resolv::DNS.new
domain = "oreilly.com"
dns.each_resource(domain, Resolv::DNS::Resource::IN::MX) do |mail_server|
  puts mail_server.exchange
end
# smtp1.oreilly.com
# smtp2.oreilly.com

dns.each_resource(domain, Resolv::DNS::Resource::IN::NS) do |nameserver|
  puts nameserver.name
end
# a.auth-ns.sonic.net
# b.auth-ns.sonic.net
# c.auth-ns.sonic.net
# ns.oreilly.com
#---
require 'resolv-replace'
def multiple_lookup(*names)
  dns = Resolv::DNS.new
  results = {} 
  threads = []
  names.each do |name|
    threads << Thread.new(name) do |name|
      begin
        dns.each_address(name) { |a| (results[name] ||= []) << a }
      rescue Resolv::ResolvError
        results[name] = nil
      end
    end
  end
  threads.each { |t| t.join }
  return results
end

domains = ("a".."z").collect { |l| l + '.com' }
multiple_lookup(*domains).each do |name, addresses|
  if addresses
    puts "#{name}: #{addresses.size} address#{addresses.size == 1 ? "" : "es"}"
  end
end
# x.com: 4 addresses
# z.com: 1 address
# q.com: 1 address
#---

#!/usr/bin/ruby

require 'net/http'
require 'curb'

#url = URI.parse('http://127.0.0.1:9000/haproxy_stats')
#url = URI('http://127.0.0.1:9000/haproxy_stats;csv')
#req = Net::HTTP::Get(url)
#req.basic_auth 'admin', 'passwordhere'
#puts url.host
#puts url.port
#res = Net::HTTP.start(url.host, url.port) {|http|
#  http.request(req)
#}
#puts res.body

#http://localhost:9000/haproxy_stats;csv

#c = Curl::Easy.new("http://store.apple.com/us/retailStore/availability?parts.0=MGAP2LL%2FA&store=R#{storenumber}") do |curl|
#                        curl.headers["User-Agent"] = "myapp-0.1"
                        #curl.verbose = true
#                end
c = Curl::Easy.new("http://localhost:9000/haproxy_stats;csv")
c.http_auth_types = :basic
c.username = 'admin'
c.password = 'passwordhere'
c.perform
puts c.body

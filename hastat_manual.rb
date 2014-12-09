#!/usr/bin/ruby

require 'rubygems'
require 'forever'
require 'open-uri'
require 'mail'
require 'csv'
require 'socket'

calltype = ARGV[0]

if calltype == "http"
	puts "web"
	def read(url)
		v = ""
                CSV.new(open(url, http_basic_authentication: ["admin", "passwordhere"]), :headers => :first_row).each do |line|
          		v = v + line
                end
        end

        read("http://localhost:9000/haproxy_stats;csv")

else
	puts "socket"
        socket = UNIXSocket.new("/tmp/haproxy")
        socket.puts("show stat")

        v = ""
        while(line = socket.gets) do
          #puts line
          #puts "BREAK"
          v = v + line
        end
        #puts v
end
        csv_text = v
        csv = CSV.parse(csv_text, :headers => true)
	puts csv.headers
	puts csv.headers.count
        csv.each do |row|
                pxname = row["# pxname"]
                svname = row["svname"]
                scur = row["scur"]
                puts "#{pxname} #{svname} #{scur}"
        end


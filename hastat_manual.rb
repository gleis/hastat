#!/usr/bin/ruby

require 'rubygems'
require 'forever'
require 'open-uri'
require 'mail'
require 'csv'
require 'socket'

	#def read(url)
        #        CSV.new(open(url), :headers => :first_row).each do |line|
        #          puts line
        #          puts line[0]
        #          puts line['FEB11']
        #        end
        #end

        #read("http://localhost:9000/haproxy_stats;csv")

        socket = UNIXSocket.new("/tmp/haproxy")
        socket.puts("show stat")

        v = ""
        while(line = socket.gets) do
          #puts line
          #puts "BREAK"
          v = v + line
        end
        #puts v
        csv_text = v
        csv = CSV.parse(csv_text, :headers => true)
        csv.each do |row|
                pxname = row["# pxname"]
                svname = row["svname"]
                scur = row["scur"]
                puts "#{pxname} #{svname} #{scur}"
        end


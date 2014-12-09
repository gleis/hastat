#!/usr/bin/ruby
require 'rubygems'
require 'forever'
require 'open-uri'
require 'mail'
require 'csv'
require 'socket'

Forever.run do
  dir File.expand_path('../', __FILE__) # Default is ../../__FILE__

  before :all do
    #puts "All jobs will wait me for 1 second"; sleep 1
    #read conf file
    #start the CMD listener
  end

  every 10.seconds, :at => "#{Time.now.hour}:00" do
    #puts "Every 10 seconds but first call at #{Time.now.hour}:00"
    #make sure the listener is up
  end

  every 1.seconds, :at => "#{Time.now.hour}:#{Time.now.min+1}" do
    #puts "Every one second but first call at #{Time.now.hour}:#{Time.now.min}"
  end

  every 10.seconds do
    puts "Every 10 second"
	
	#def read(url)
	#	 CSV.new(open(url), :headers => :first_row).each do |line|
	#	   puts line
	#	   puts line[0]
	#	   puts line['FEB11']
	#	 end
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
  end

  every 20.seconds do
    #puts "Every 20 second"
  end

  every 15.seconds do
    #puts "Every 15 seconds, but my task require 10 seconds"; sleep 10
    # This doesn't block other jobs and your queue !!!!!!!
  end

  every 10.seconds, :at => [":#{Time.now.min+1}", ":#{Time.now.min+2}"] do
    #puts "Every 10 seconds but first call at xx:#{Time.now.min}"
  end

  on_error do |e|
    puts "Boom raised: #{e.message}"
  end

  on_exit do
    puts "Bye bye"
  end
end

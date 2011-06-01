#!/usr/bin/env ruby

require 'rubygems'
require 'twitter'
require 'optparse'

#Initialize Twitter configuration to connect to API
Twitter.configure do |config|
  config.consumer_key = "bWpBd9rtXVOf8WkeOF6ihg"
  config.consumer_secret = "SDx4r8EQtY0PELy3aYkRUEpJ9GW9fsGldeimFgUdDOI"
  config.oauth_token = "280107559-fYJuMwS0cAvcgtrT7um0v72gApXDkBurc1bfldd6"
  config.oauth_token_secret = "1QcQDjaxqnSBLdqUhpCYKMWsroIgKT7k97NSijcSeg"
end

def main()
  #Initialize Twitter Client
  client = Twitter::Client.new
  last_id = 1

  #Run loop every hour to check for status updates
  while true do
    timeline = client.home_timeline( :since_id => last_id )
 
    unless timeline.empty?
      last_id = timeline[0].id
 
      timeline.reverse.each do |st|
        puts %x{notify-send -t 120000 -i /usr/share/icons/twitter.png "#{st.user.name} said #{st.text}"}
      end
 
      sleep 3600
    end
  end
end

def tweeter(message)
  #Initialize Twitter Client
  client = Twitter::Client.new

  #Send status update
  client.update(message)
end

opts = OptionParser.new do |opts|
      opts.banner = "Usage: twitter-client.rb [options]"

      opts.on("-l", "--listen", "Listen for new tweets") do |run|
         main
      end

      opts.on("-t", "--tweet UPDATE", "Tweet UPDATE to twitter") do |tweet|
        tweeter(tweet)
      end

      opts.on_tail("-h", "--help", "Show this message") do
         puts opts
         exit
      end
   end

opts.parse!

# You'll need to require these if you
# want to develop while running with ruby.
# The config/rackup.ru requires these as well
# for it's own reasons.
#
# $ ruby heroku-sinatra-app.rb
#
require 'rubygems'
require 'sinatra'
require 'xmpp4r-simple'

configure :production do
  # Configure stuff here you'll want to
  # only be run at Heroku at boot

  # TIP:  You can get you database information
  #       from ENV['DATABASE_URI'] (see /env route below)
end

# Quick test
get '/' do
  "Congradulations!
   You're running a Sinatra application on Heroku!"
end

post '/notifications' do
  
  msg = params[:msg]

  to = "gabe@avantbard.com"
  # 
  # #send the message
  jabber = Jabber::Simple.new('webgrowl@gmail.com', 'growller')
  jabber.deliver(to, msg)

  "#Message: {msg} <br/>
  Sent to #{to}"
  
end

# Test at <appname>.heroku.com

# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information

# get '/env' do
#   ENV.inspect
# end

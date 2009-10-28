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

helpers do
  def invalid_token?(token)
    token != "g"
  end
end


# Quick test
get '/' do
  "Home"
end

post '/notifications' do
  
  msg = params[:msg]
  token = params[:token]
  
  return "Unauthorized" if token.nil? or invalid_token?(params[:token])


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

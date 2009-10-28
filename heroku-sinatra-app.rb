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

  def is_online?(email)
    node,domain = email.split('@')
    puts "jabber.roster #{jabber.roster}"
    puts "jabber.roster.items #{jabber.roster.items}"
    roster_item = jabber.roster.items[Jabber::JID.new(node, domain)] 
    
    roster_item and roster_item.online?
  end
  
  def jabber
    @jabber ||= Jabber::Simple.new('webgrowl@gmail.com', 'growller')
  end
  
end


# Quick test
get '/' do
  "Home"
end

post '/notifications' do
  
  msg = params[:msg]
  token = params[:token]
  
  #look up xmpp id to send to
  to = "gabe@avantbard.com"
  
  #are you authorzed?
  return "Unauthorized" if token.nil? or invalid_token?(params[:token])

  # #send the message if you're online
  if is_online?(to)
    jabber.deliver(to, msg) 

    "#Message: {msg} <br/>
    Sent to #{to}"
  else
    "You're not online."
  end
  
end

# Test at <appname>.heroku.com

# You can see all your app specific information this way.
# IMPORTANT! This is a very bad thing to do for a production
# application with sensitive information

# get '/env' do
#   ENV.inspect
# end

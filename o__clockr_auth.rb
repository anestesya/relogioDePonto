#esta classe é responsável por fazer o tweet com oauth.
#autor: tadeu luis
#email: anestesya@gmail.com

require 'rubygems'
require 'twitter'

#class O_clockRAuth
 
 oclock_oauth = { #configurações usadas para conecção
    'consumer_key' => "UT84Cc0OsmOVdQaJ8zNtPA", 
    'consumer_secret' => "Z50TpDOHXXNhdhSv1m18DQ54zqoNtgE1c3ouWynv8",
    'callback_url' => "http://webbdesign.com.br/ant-dev/o_clockr/",
    'request_token' => "http://twitter.com/oauth/request_token",
    'access_token' => "http://twitter.com/oauth/access_token",
    'authorize_url' => "http://twitter.com/oauth/authorize"
  }
  
  # NOT SHOWN: granting access to twitter on website
  # and using request token to generate access token
  oauth = Twitter::OAuth.new(oclock_oauth['consumer_token'], oclock_oauth['consumer_secret'])
  # oauth.authorize_from_access(oclock_oauth['access_token'], oclock_oauth['access_secret'])
  oauth.authorize_from_request(oclock_oauth['consumer_token'], oclock_oauth['consumer_secret'], oclock_oauth['authorize_url'])
  
  
   client = Twitter::Base.new(oauth)
   client.friends_timeline.each  { |tweet| puts tweet.inspect } 
   client.user_timeline.each     { |tweet| puts tweet.inspect }
   client.replies.each           { |tweet| puts tweet.inspect }
   
   #envia umam mensagem direta para o meu twiiter.
   puts "Digite um tweet: #{msg_140 = gets.chomp}"
   client.update(msg)
#end
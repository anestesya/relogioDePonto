require 'rubygems'
require 'sinatra'
require 'twitter'
require 'oclockrtwit'

get '/' do
  erb :index
end

get '/o_clockr' do 
  erb :index
end

enable :sessions
post '/tweetar' do
   httpauth = Twitter::HTTPAuth.new('o_clockr', '1n0d3_50t')
   client = Twitter::Base.new(httpauth)
   oauth = OClockrTwit.new
   if oauth.consumer
     oauth.twitter_oauth_login
     oauth.twitter_oauth_access
     client = Twitter::Base.new(oauth.Auth)
   end  
   
   user = session["user"]
   
   data = Time.now
   hora = data.strftime("%I:%M%p")
   msg = "#{data.strftime("%a/%b/%y")} - Nesta #{params[:periodo]}, @#{user} #{params[:ponto]} às #{hora}"
   if client.update(msg)
     @update_msg = msg     
     erb :index, :layout=>!request.xhr?
     @update_msg
   end
end

enable :sessions
post '/oauth' do 
  session["user"] = params[:usuario]
  httpoauth = Twitter::HTTPAuth.new(session["user"], params[:senha])
  if Twitter::Base.new(httpoauth) 
     session["user"]
  end
end

helpers do 
  def file_link(file)
    filename = Pathname.new(file).basename
    "<li><a href='#{file}' target='_self'>#{filename}</a></li>"
  end
end


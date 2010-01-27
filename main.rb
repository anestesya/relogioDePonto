#relogio de ponto usado para medir e guardar as horas trabalhadas

require 'rubygems'
require 'sinatra'
require 'twitter'

get '/' do
  erb :index
end

enable :sessions
post '/tweetar' do
   httpauth = Twitter::HTTPAuth.new('o_clockr', '#')
   client = Twitter::Base.new(httpauth)
   
   user = session["user"]
   data = Time.now
   hora = data.strftime("%I:%M%p")
   msg = "#{data.strftime("%a/%b/%y")} - Nesta #{params[:periodo]}, @#{user} #{params[:ponto]} às #{hora}"
   client.update(msg)
end

enable :sessions
post '/oauth' do 
  httpoauth = Twitter::HTTPAuth.new(params[:usuario], params[:senha])
  if Twitter::Base.new(httpoauth) 
     session["user"] = params[:usuario]
  end
end

helpers do 
  def file_link(file)
    filename = Pathname.new(file).basename
    "<li><a href='#{file}' target='_self'>#{filename}</a></li>"
  end
end

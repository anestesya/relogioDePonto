require 'rubygems'
require 'sinatra'
require 'twitter'
require 'oclockrtwit'

#set :environment, :development 

get '/' do
  erb :index
end

get '/o_clockr' do 
  erb :index
end

enable :sessions

get '/tabelar' do
  base = logar_o_clockr
  nome = base.client.username # => 'o_clockr'
  
  # metodo de conveniencia de cache, remover
  if session['users_clock']
    @users = session['users_clock']
  else
  # http://rdoc.info/projects/jnunemaker/twitter
  # vamos buscar todas entradas!
  # esse metodo ta muito bruto, 
  #   o certo eh armazenar os twit localmente e só roda uns update de tempo em tempo, nao todo carregamento de pagina :P
  twits = base.home_timeline( :count => 100000 )
  
  # TODO Logica inline feia, devia ser abstraida pra classe
  @users = {}
  twits.each do |t|
    # Twit valido? Exp bem tosca sim :)
    if t.text.include?( "Nesta") && t.text.include?( "@") && (t.text.include?( "saiu") || t.text.include?( "entrou")) # FAIL =~ / - Nesta .* @.* [entrou|saiu] /
      # TODO verificar se essa regexp faz match em todos possiveis names do Twitter
      user = t.text.match( /@([a-z0-9_]*) /)[1]
      # o 1o vetor eh entrou, o 2o vetor eh saiu 
      @users[user] = [[],[]] unless @users[user]
      if t.text =~ / (entrou) /
        @users[user][0].push Time.parse(t.created_at).strftime "%d/%m/%Y %X"
      else
        @users[user][1].push Time.parse(t.created_at).strftime "%d/%m/%Y %X"
      end
    end
  end
  
  session['users_clock'] = @users; p "fiz cache!"
  end
  #puts @users.inspect  #puts "-----------------------------------------------------"  #puts twits.inspect
  erb :tabela
end

post '/tweetar' do
   # LOGIN
   client = logar_o_clockr
   
   # OAUTH
   #oauth = OClockrTwit.new
   #if oauth.consumer
   #  oauth.twitter_oauth_login
   #  oauth.twitter_oauth_access
   #  client = Twitter::Base.new(oauth.Auth)
   #end  
   
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
  tentativa_login = Twitter::Base.new(httpoauth)
  if tentativa_login
     session["user"] = tentativa_login
  end
end

helpers do 
  def file_link(file)
    filename = Pathname.new(file).basename
    "<li><a href='#{file}' target='_self'>#{filename}</a></li>"
  end
end


def logar_o_clockr
  httpauth = Twitter::HTTPAuth.new('o_clockr', '1n0d3_50t')
  Twitter::Base.new(httpauth)
end



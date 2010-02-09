require 'oauth'

class OAuthoClockr
   #
   # inicializa a autenticação por oauth.
   #
   
 @oclockr_oauth = { #configurações usadas para conecção
    'consumer_key' => "UT84Cc0OsmOVdQaJ8zNtPA", 
    'consumer_secret' => "Z50TpDOHXXNhdhSv1m18DQ54zqoNtgE1c3ouWynv8",
    'request_token' => "http://twitter.com/oauth/request_token",  
    'access_token' => "http://twitter.com/oauth/access_token",
    'authorize_url' => "http://twitter.com/oauth/authorize"
    }
    
    session = {
     :request_token => nil,
     :request_token_secret => nil
    }
    
    #a chave e o seu segredo vem do twitter.
    oauth = OAuth::Consumer.new(@oclockr_oauth['consumer_key'],                       
                                @oclockr_oauth['consumer_secret'], 
                              {:site=>"https://twitter.com"})
  
    #peça para um token fazer um pedido.
    url = "http://localhost:3000/"
    request_token = oauth.get_request_token(:oauth_callback => url)
  
    #anote o request_token eo seu segredo. Será utilizado adiante.
    session[:request_token] = request_token.token
    session[:request_token_secret] = request_token.secret
  
    #Agora sua URL irá pegar uma requisição que contém um oauth_verifier.
    #Use este para construir um access_token
    request_token = OAuth::RequestToken.new(oauth, session[:request_token], session[:request_token_secret])
    access_token = request_token.get_access_token(oauth_verifier => params[:oauth_verifier])
 end

end
 
 
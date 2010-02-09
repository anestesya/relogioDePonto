class OClockrTwit
require 'oauth'
   #
   # inicializa a autenticação por oauth.
   #
   
   def initialize
     @oclockr_oauth = { #configurações usadas para conecção
       'consumer_key' => "UT84Cc0OsmOVdQaJ8zNtPA", 
       'consumer_secret' => "Z50TpDOHXXNhdhSv1m18DQ54zqoNtgE1c3ouWynv8",
       'consumer_token' => nil,
       'request_token' => nil,
       'request_token_secret' => nil,
       'access_token' => nil,
       'access_token_scret' => nil,
       'authorize_url' => nil
     }
   end
    
   def consumer 
      OAuth::Consumer.new(
        @oclockr_oauth['consumer_key'],                       
        @oclockr_oauth['consumer_secret'], 
        {:site=>"https://twitter.com"}
      )
   end
    
   def SetAccessToken(strToken, strSecret)
     @oclockr_oauth['access_token'] = strToken
     @oclockr_oauth['access_token_secret'] = strSecret
   end
   
   def Auth
     oAuth = Twitter::OAuth.new(@oclockr_oauth['consumer_token'], @oclockr_oauth['consumer_secret'])
     oAuth.autorize_from_access(@oclockr_oauth['access_token'], @oclockr_oauth['access_secret'])
     oAuth
   end  
   
   def twitter_oauth_login 
     url = "http://localhost:3000/"
     request_token = consumer.get_request_token(:oauth_callback => url)
     @oclockr_oauth['request_token'] = request_token.token
     @oclockr_oauth['request_token_secret'] = request_token.secret
     @oclockr_oauth['authorize_url'] = request_token.authorize_url
   end
   
   def twitter_oauth_access 
     request_token = OAuth::RequestToken.new(
        consumer, @oclockr_oauth['request_token'],
        @oclockr_oauth['request_token_secret']
     )
     
     access_token = request_token.get_access_token(:oauth_verifier => @oclockr_oauth['authorize_url'])
     SetAccessToken(access_token.token, access_token.secret)
   end
   
   def getTimeline
     resposta = consumer.request(:get, 'account/verify_credentials.json', 
                                  twitter_oauth_access, {:scheme => :query_string})
   end
 end
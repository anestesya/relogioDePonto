#relogio de ponto usado para medir e guardar as horas trabalhadas

require 'rubygems'
require 'sinatra'
require 'pathname'
require 'twitter'

get '/' do
  dir = './files/'
  @links = Dir[dir+"*"].map { |file|
    file_link(file)
  }.join
  erb :index
end

post '/tweetar' do
   httpauth = Twitter::HTTPAuth.new('o_clockr', '1n0d3_50t')
   client = Twitter::Base.new(httpauth)
   
   data = Time.now
   hora = data.strftime("%I:%M%p")
   msg = "#{data.strftime("%a/%b/%y")} - #{params[:usuario]} - #{params[:periodo]} está #{params[:ponto]} às #{hora}"
   client.update(msg)
end

helpers do 
  def file_link(file)
    filename = Pathname.new(file).basename
    "<li><a href='#{file}' target='_self'>#{filename}</a></li>"
  end
end

use_in_file_templates!

__END__

@@ index

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>iUI Time O'Clock Results</title>
    
    <meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
    
    <style type="text/css" media="screen">@import "/stylesheets/iui.css";</style>
    <style type="text/css" media="screen">@import "/stylesheets/custom.css";</style>
    
    <script type="application/x-javascript" src="/javascripts/iui.js"></script>
    <script type="text/javascript" src="/javascripts/jquery.js"></script>
    <script type="text/javascript" src="/javascripts/jutils.js"></script>
  </head>
 
  <body>
     <div class="toolbar">
       <h1 id="pageTitle">O'Clock Results</h1>
       <a id="backButton" class="button" href="#">voltar</a>
       <a class="button" href="#opcoes">Op&ccedil;&otilde;es</a>
     </div>
     
    <form id="home" class="panel" selected="true" title="O ClockR" method="post" action="/tweetar">
        <h2>Calcule e envie</h2>
 
        <fieldset>
          <div class="row">
            <label for="periodo">Per&iacute;odo</label>
            <div class="toggle" toggled="true" id="periodos"><span class="thumb"></span><span class="toggleOn" >Manh&atilde;</span><span class="toggleOff">Tarde</span></div>
            <input type="hidden" id="periodo" name="periodo" value="manh&atilde;"/>
          </div>
        
          <div class="row">
            <label for="ponto">Marcar</label>
            <div class="toggle" toggled="true" id="pontos"><span class="thumb"></span><span class="toggleOn" >Entrada</span><span class="toggleOff">Sa&iacute;da</span></div>
            <input type="hidden" id="ponto" name="ponto" value="Entrada"/>
         </div>
        </fieldset>
        
        <fieldset>
          <div class="row">
            <span class="hora"></span>
            <input type="hidden" id="horas" name="horas" value="" />
         </div>
            
        </fieldset>
        <a class="whiteButton" type="submit" href="#" name="tweetit" id="tweetit">Tweet It!</a>
	</form>
    </div>
  
    <div id="opcoes" title="Op&ccedil;&otilde;es" class="panel">
      <h2>Enviar mensages via o_clockR</h2>
    <fieldset>
        <div class="row">
            <label>Usar o_clockR user</label>
            <div class="toggle" onclick=""><span class="thumb"></span><span class="toggleOn">ON</span><span class="toggleOff">OFF</span></div>
        </div>
    </fieldset>
    
    <h2>Use seu usu&aacute;rio notwitter</h2>
    <fieldset>
        <div class="row">
            <label>Usu&aacute;rio</label>
            <input type="text" name="usuario" id="usuario" value="anestesya"/>
        </div>
        <div class="row">
            <label>Senha</label>
            <input type="password" name="post[senha]" value="123456"/>
        </div>
    </fieldset>
        <a class="whiteButton" type="submit" href="#" name="post[gravar]">Gravar</a>
    </div>
      
  </body>
 
</html>


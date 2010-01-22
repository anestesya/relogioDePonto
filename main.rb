#relogio de ponto usado para medir e guardar as horas trabalhadas

require 'rubygems'
require 'sinatra'
require 'pathname'

get '/' do
  dir = './files/'
  @links = Dir[dir+"*"].map { |file|
    file_link(file)
  }.join
  erb :index
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
    <meta name="viewport" content="device-width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;"/>
    <style type="text/css" media="screen">@import "/stylesheets/iui.css";</style>
    <script type="application/x-javascript" src="/javascripts/iui.js"></script>
  </head>
 
  <body>
     <div class="toolbar">
       <h1 id="pageTitle">O'Clock Results</h1>
       <a id="backButton" class="button" href="#">voltar</a>
       <a class="button" href="#opcoes">Op&ccedil;&otilde;es</a>
     </div>
     
    <div id="home" class="panel" selected="true" title="Enviar">
        <h2>Calcule e envie</h2>
        
        <fieldset>
          <div class="row">
            <label>Per&iacute;odo</label>
            <div class="toggle" onclick=""><span class="thumb"></span><span class="toggleOn">Manh&atilde;</span><span class="toggleOff">Tarde</span></div>
        </div>
        
          <div class="row">
            <label>Horas</label>
            <input type="text" name="hora" />
         </div>
            
          <div class="row">
            <label>Minutos</label>
            <input type="text" name="minutos" />
          </div>
        </fieldset>
        <a class="whiteButton" type="submit" href="#">Tweet It!</a>
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
            <input type="text" name="userName" value="anestesya"/>
        </div>
        <div class="row">
            <label>Senha</label>
            <input type="password" name="password" value="123456"/>
        </div>
    </fieldset>
        <a class="whiteButton" type="submit" href="#">Gardar</a>
    </div>
      
  </body>
 
</html>


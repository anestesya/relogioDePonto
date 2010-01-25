jQuery(function($){
	//mostra a hora que o tweeet vai ser enviado.
	data = new Date();
	data = data.getHours()+":"+data.getMinutes()
	$(".hora").html(data);	
	
	//pega o valor do campo periodos e coloca no input escondido
	//para que o sinatra possa pegar.
	$('#periodos, #pontos').click(function(){
    	var $p = $('#periodo, #ponto');
		var $this = $(this);
		
		if( $this.is('periodo') && $this.attr('toggled') == 'true'){
			$p.attr({
 			  id: 'periodo',
              value: 'manh&atilde;'
		    });
		} else if( $this.is('periodo') && $this.attr('toggled') == 'false' ){
			$p.attr({
 			  id: 'periodo',
              value: 'tarde'			
		    });			
		} 
        
		if( $this.is('pontos') && $this.attr('toggled') == 'true'){
			$p.attr({
 			  id: 'ponto',
              value: 'entrou'
		    });
		} else if( $this.is('pontos') && $this.attr('toggled') == 'false' ){
			$p.attr({
 			  id: 'ponto',
              value: 'saiu'				
		    });			
		} 
	});
	
});

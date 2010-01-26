jQuery(function($){
	//mostra a hora que o tweeet vai ser enviado.
	data = new Date();
	data = data.getHours()+":"+data.getMinutes()
	$(".hora").html(data);	
	
	
	$('#periodos').click(function(){
		var $this = $(this);
		
		if ($this.attr('toggled') == "true") {
			$('#periodo').val('manh&atilde;');
		}
		else if ($this.attr('toggled') == "false") {
			$('#periodo').val('tarde');
		}
	});	
	
	$('#pontos').click(function(){
		var $this = $(this);
		
		if ($this.attr('toggled') == 'true') {
		    $('#ponto').val('entrou');
		}else if ($this.attr('toggled') == 'false'){
		    $('#ponto').val('saiu');
	    }	
	});	
});

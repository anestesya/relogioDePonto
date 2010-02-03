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
	
	
	
	  //BD: HTML5
	  function saveUser(){
	  		try {		
	  		  if (window.openDatabase){
			  db = window.openDatabase("o_clockr", "1.0", "HTML 5 Storage: Usuários", 1024);
	    	
			  if (!db) {
			  	$('#tweetit').after('Erro ao carregar banco.');
			  } else {
			  	 db.transaction(function (tx) {
            		tx.executeSql("INSERT INTO o_clockr (id, user)");
        		 }); 
			  }
				
				
		    } else 
		        $('#tweetit').after('Erro ao carregar banco. Navegador não suporta.');
		    } catch (e) {
			     $('#tweetit').after("BD: "+e)
	        }//fim do try.	
	  }//fim saveUser()
	
});

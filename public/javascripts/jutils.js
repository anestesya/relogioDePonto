jQuery(function($){
	//mostra a hora que o tweeet vai ser enviado.
		data = new Date();
		hora = data.getHours()+":"+data.getMinutes();
		data = data.getDay()+"-"+data.getMonth()+"-"+data.getFullYear();	

     //seta a hora na mensagem inicial
	 $('.data').html(data);
	//altera as horas.
	setInterval( function(){
		$(".hora, .horas").html(hora);
	}, 1000);	
	
    //pegaUser.
	$('.user').html($('#usuario').val());

	//pega valores dos periodos.		
	$('#periodos').click(function(){
		var $this = $(this);
		
		if ($this.attr('toggled') == "true") {
			manha= 'manh&atilde;';
			$('#periodo').val(manha);
			$('.periodo_atual').html(manha);
			$(".hora, .horas").html(hora);
		}
		else if ($this.attr('toggled') == "false") {
			tarde = "tarde";
			$('#periodo').val(tarde);
			$('.periodo_atual').html(tarde);
			$(".hora, .horas").html(hora);
		}
	});	
	
	//pega valores do ponto.
	$('#pontos').click(function(){
		var $this = $(this);
		
		if ($this.attr('toggled') == 'true') {
		    $('#ponto').val('entrou');
			$('.ponto').html('entrou');
		}else if ($this.attr('toggled') == 'false'){
		    $('#ponto').val('saiu');
			$('.ponto').html('saiu');
	    }
	});	
	
	//envia mensagem para o sinatra via AJAX.
	$('#tweetit').click( function(){
		$.ajax({
			type: 'post',
			url: '/tweetar',
			data: 'periodo='+$('#periodo').val()+'&ponto='+$('#ponto').val(),
			beforeSend: function(){
				$('.resposta')
				  .empty()
				  .addClass('carregando');
			},			
			success: function(data){
				$('.resposta')
				 .empty()
				 .removeClass('carregando')
				 .append(data).fadeIn('slow');
			},
			error: function(xhr, ajaxOptions, throwError){
				console.log(xhr.status);
				console.log(throwError);
			}
		});
	});
	
	
	//grava o nome do usuário dentro do SQLITE.
	$('#gravar').click(function(){
		var banco = abreBanco();
		if( banco ){
			saveUser($('#usuario', banco).val());
			$('body').append('<p>usuário gravado.</p>');
		}
	});
	
	  //BD: HTML5
	  function abreBanco(){
	  	try {
			var db;
			if(window.openDatabase){
			  db = window.OpenDatabase("o_clockr", "1.0", "HTML 5 Storage: Usuários", 1024);
			} else { alert('não abriu o banco.');}
		} catch(e){ 
			alert(e); 
			return false;
	    }
		
		return db;		
	  }//fim abreBanco
	  
	  
	  function criaBanco(){
	  	try{
			if( abreBanco() ){
				bc = abreBanco();
				bc.executeSql("CREATE TABLE o_clockr(id text, usuario text");
			} else {
				$('body').append('<p>erro ao tentar abrir ao abrir o banco.</p>');
			}
		 } catch(e){
			console.log(e);
		 }
		 
		 return bc;	
	  }
	  
	  function saveUser(user, db){
	  		try {		
	  		  		banco = db;
			  		if (!db) {
			  			$('#tweetit').after('Erro ao carregar banco.');
			  		} else {
			  	 		banco.transaction(function (tx) {
            			tx.executeSql("INSERT INTO o_clockr values(null, "+user+")");
        		       });
			        }
				 } catch (e) {
			     		$('#tweetit').after("BD: "+e);
	             }//fim do try.	
	  }//fim saveUser()
	
});

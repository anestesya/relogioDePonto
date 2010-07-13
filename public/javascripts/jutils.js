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
		console.log('sex');
		var banco = abreBanco();
		if( banco ){
			$.ajax({
				type: 'post',
				url: '/oauth',
				//data: 'usurario='+$('#usuario').val()+'&senha='+$('#senha').val(),
				success: function(){
					saveUser($('#usuario').val(), $('#senha').val(), banco);
				}
			});
		}
	});//fim do insere usuário.
	
	  //BD: HTML5
	  function abreBanco(){
	  	
		//configurações do banco de dados
		var bdOptions = {
			fileName: 'funcionario',
			version: '1.0',
			displayName: 'Base de usuários do twitter',
			maxSize: 1024
		};
		
	  	try {
			//tenta abrir o banco no sqlite
			var db = openDatabase(
				bdOptions.fileName, 
				bdOptions.version,
				bdOptions.displayName,
				bdOptions.maxSize				
			);
			
			//cria tabela no banco de dados caso não exista.
			db.transaction( 
				function(transaction){
					transaction.executeSql(
						"CREATE TABLE IF NOT EXISTS users (" +
									"id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,"+
									"username TEXT NOT NULL,"+
									"password TEXT NOT NULL" +
								 ");"			
					);
				}//fim cria tabela
			);//fim da transação.
		} catch(e){ 
			alert(e); 
			return false;
	    }
		
		return db;		
	  }//fim abreBanco
	  
	  //grava usuário no banco de dados.	 
	  function saveUser(user, senha, db){
		  	this.banco = db;
	  		
			if (this.banco) {
				try{
		  	 		this.banco.transaction(function (tx) {
        				tx.executeSql("INSERT INTO users values(null, "+user+", "+senha+");");
    		       });
				   return false;
				} catch (e) {
			     		alert(e);
	             }//fim do try.	
	  		} else {aler('Banco não aberto para salvar usuário.')}
			return;
	  }//fim saveUser()
	
});

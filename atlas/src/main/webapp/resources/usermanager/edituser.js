var selectedRoles = []; 
var globalUserPasswordScore = 0;
var userValidationElement = null;
var userExists = false;
var cpfExists = false;
var cpfValid = false;
var passwordValid = false;




function confirmCreateUser( ) {
	  
	  $('#modal-warning').on('show.bs.modal', function(e) {
	  
	  $(this).find('.btn-ok').click( function() {
		  $('#modal-warning').modal('hide');
	  	  $("#formSubmit").prop("disabled",true);
	      $("#theForm").submit();
		  });
		  
	  });  
	  
	  $('#modal-warning').modal('show');
	  
}


function checkPassword( password ){
	/*
	if( $("#password").val() === "" ){
		$("#symbolPassword").removeClass("bg-red");
		return;
	}	
	
	$.ajax({
		url: '/checkpassword?password=' + password,
		success: function ( result, textstatus ) {
			if ( result === "NO" ){
				passwordValid = false;
				$("#symbolPassword").addClass("bg-red");
			} else {
				$("#symbolPassword").removeClass("bg-red");
				passwordValid = true;
			}
		}
	});	
	*/
}


function checkUserName( userName ){
	userExists = false;
}

function checkCpf( cpf ){
	cpfExists = false;
	cpfValid = true;
}


function setCorrectPhoneMask(element){
	if (element.inputmask('unmaskedvalue').length > 10 ){
		element.inputmask('remove');
		element.inputmask('(99) 9999[9]-9999')
	} else {
		element.inputmask('remove');
		element.inputmask({mask: '(99) 9999-9999[9]', greedy: false})
	}
}

function getUserLogActivities( userId ){
	var fotoServer = "/photos/";
      	
	$.ajax({
		url: '/logs/'+userId+'/20',
		dataType: 'json',
		success: function (obj, textstatus) {
			$("#logListContainer").empty();
			
			var data = "";
			
			for(var x = 0; x < obj.list.length; x++  ) {
				var log = obj.list[x];
				if ( log.data !== data ) {
					$("#logListContainer").append( getLogDate( log ) );
				}
				data = log.data;	
				
				// Sem foto por enquanto!
					log.profileImage = "nophoto.png";
					fotoServer = "/userimg/";
				// *************************
				$("#logListContainer").append( getLogItem( log, fotoServer ) );
			}
			
			$("#logListContainer").append( getLogListFooter( log ) );
		}
	
	});	
          
}


function prepareUserSubmitForm(){

	
	$( "#formSubmit" ).click(function() {
      	var password = $("#password").val();
      	var password2 = $("#password2").val();
      	var username = $("#name").val();
      	var fullName = $("#fullName").val();
      	var organizacao = $("#origem").val();
      	var email = $("#email").val();
      	var telefone = $("#telefone").inputmask('unmaskedvalue');
      	var cpf = $("#cpf").inputmask('unmaskedvalue');

      	if( userExists ){
  	  		$("#modalBody").text('O nome de usuário escolhido já existe.');
  	  	    userValidationElement = $("#username");
  	  		$('#modal-danger').modal('show');
  	  		return;
  	  	}      	

      	if( username === "" ) {
      		$("#modalBody").text('O nome de usuário não pode ser deixado em branco.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#username");
      		return false;
      	}		

      	if( username.length < 8 ) {
  	  		$("#modalBody").text('O nome de usuário escolhido é muito curto.');
  	  	    userValidationElement = $("#username");
  	  		$('#modal-danger').modal('show');
  	  		return;
      	}
      	

      	if( fullName === "" ) {
      		$("#modalBody").text('O nome completo não pode ser deixado em branco.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#fullName");
      		return false;
      	}

      	if( fullName.length < 10 ) {
  	  		$("#modalBody").text('O nome completo é muito curto.');
  	  	    userValidationElement = $("#fullName");
  	  		$('#modal-danger').modal('show');
  	  		return;
      	}

      	if( organizacao === "" ) {
      		$("#modalBody").text('A Organização não pode ser deixada em branco.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#origem");
      		return false;
      	}		
      	if( organizacao.length < 5 ) {
  	  		$("#modalBody").text('A Organização precisa ter ao menos 5 caracteres.');
  	  	    userValidationElement = $("#origem");
  	  		$('#modal-danger').modal('show');
  	  		return;
      	}

      	
      	if( email === "" ) {
      		$("#modalBody").text('O email não pode ser deixado em branco.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#email");
      		return false;
      	}		
      	if ( !validacaoEmail( email ) ){
      		$("#modalBody").text('O email informado é inválido.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#email");
      		return false;
      	}
      	
      	
      	if( cpf === "" ) {
      		$("#modalBody").text('O CPF não pode ser deixado em branco.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#cpf");
      		return false;
      	}		
      	if( !cpfValid ) {
      		$("#modalBody").text('O CPF digitado está incorreto.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#cpf");
      		return false;
      	}		
      	if( cpfExists ) {
      		$("#modalBody").text('O CPF informado já existe.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#cpf");
      		return false;
      	}		
      	
      	if( telefone === "" ) {
      		$("#modalBody").text('O número telefone não pode ser deixado em branco.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#telefone");
      		return false;
      	}		
      	
      	/*
      	if( password === "" ) {
  	  		$("#modalBody").text('A senha não pode ser em branco.');
  	  		$('#modal-danger').modal('show');
  	  		userValidationElement = $("#password");
  			return;
      	}
      	*/

      	if( (password != "") && ( password.length < 8 ) ) {
  	  		$("#modalBody").text('A senha informada é muito curta.');
  	  		$('#modal-danger').modal('show');
  	  	    userValidationElement = $("#password");
  	  		return;
      	}

      	if( password !== password2 ) {
      		$("#modalBody").text('As senhas são diferentes. Verifique se digitou corretamente.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#password");
      		return false;
      	}

      	if( (password != "") && ( globalUserPasswordScore < 2 ) ) {
  	  		$("#modalBody").text('A senha informada é considerada fraca.');
  	  		$('#modal-danger').modal('show');
  	  		userValidationElement = $("#password");
  			return;
      	}
      	
      	if( $('#userRoles').val() === null ) {
      		$("#modalBody").text('Ao menos um perfil deverá ser selecionado.');
      		$('#modal-danger').modal('show');
      		userValidationElement = $("#userRoles");
      		return false;
      	}

      	
      	confirmCreateUser();
      	
      	
	});
 	
}

function testaCPF( strCPF ) {
	var soma;
	var resto;
	soma = 0;
	if ( strCPF == "00000000000") return false;
     
	for ( i=1; i<=9; i++ ) soma = soma + parseInt( strCPF.substring( i-1, i ) ) * ( 11 - i );
	resto = ( soma * 10 ) % 11;
   
    if ( ( resto == 10 ) || ( resto == 11 ) ) resto = 0;
    if ( resto != parseInt( strCPF.substring( 9, 10 ) ) ) return false;
   
	soma = 0;
    for ( i = 1; i <= 10; i++ ) soma = soma + parseInt( strCPF.substring( i-1, i ) ) * ( 12 - i );
    resto = ( soma * 10 ) % 11;
   
    if ( ( resto == 10 ) || ( resto == 11 ) ) resto = 0;
    if ( resto != parseInt( strCPF.substring( 10, 11 ) ) ) return false;
    return true;
}



function validacaoEmail(field) {
	usuario = field.substring(0, field.indexOf("@"));
	dominio = field.substring(field.indexOf("@")+ 1, field.length);
	 
	if ((usuario.length >=1) &&
	    (dominio.length >=3) && 
	    (usuario.search("@")==-1) && 
	    (dominio.search("@")==-1) &&
	    (usuario.search(" ")==-1) && 
	    (dominio.search(" ")==-1) &&
	    (dominio.search(".")!=-1) &&      
	    (dominio.indexOf(".") >=1)&& 
	    (dominio.lastIndexOf(".") < dominio.length - 1)) return true;
	
	return false;
}


function preparePasswordValidation(){
	
	$( "#password" ).keyup(function() {
		var password = $( this ).val();
		
		if( password != "" ) {
		
			$("#passwordBar").css('display','block');
	
	  	  	var url="/getPasswordScore?password=" + password;
		  	$.ajax({
		        url      : url,
		        method   : 'GET',
		        success : function (obj, textstatus) {
		  			var value = parseInt(obj.score);
		  			globalUserPasswordScore = value;
		  			var barSize = 0;
		  			var barColor = 'progress-bar-red';
		  			
		  			
		  			$("#passwordBarVal").removeClass('progress-bar-blue');
	  				$("#passwordBarVal").removeClass('progress-bar-green');
	  				$("#passwordBarVal").removeClass('progress-bar-yellow');
	  				$("#passwordBarVal").removeClass('progress-bar-red');
	  				
	  				
		  			if( value === 1 ) {
			  			barSize = 10;
			  			barColor = 'progress-bar-red';
		  			}
		  			
		  			if( value === 2 ) {
			  			barSize = 30;
			  			barColor = 'progress-bar-yellow';
		  			}

		  			if( value === 3 ) {
			  			barSize = 60;
			  			barColor = 'progress-bar-blue';
		  			}

		  			if( value === 4 ) {
			  			barSize = 100;
			  			barColor = 'progress-bar-green';
		  			}
		  			
	  				$("#passwordBarVal").css('width', barSize + '%');
	  				$("#passwordBarVal").addClass( barColor );
		  			
		  			
		        }
		  	});
		  	
		  	
		} else {
			$("#passwordBar").css('display','none');
		}
		
	});   
   	  
	
}



function readURL(input) {

	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function (e) {
			$('#img-upload').attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}


function initUpload() {


	$(document).on('change', '.btn-file :file', function() {
		var input = $(this),
		label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
		input.trigger('fileselect', [label]);
	});

	
	$('.btn-file :file').on('fileselect', function(event, label) {
		var input = $(this).parents('.input-group').find(':text'),
		log = label;
		if( input.length ) {
			input.val(log);
		} else {
			//if( log ) alert(log);
		}
	});

	
	$("#profileImageFile").change(function(){
		readURL(this);
	}); 		

}

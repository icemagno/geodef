<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html manifest="">
   <jsp:include page="head.jsp" />
   <body class="hold-transition" style="margin:0px; padding:0px">
   
      <div  class="page-wrap">
      
         <header class="navbar fixed-top navbar-empty">
            <div class="container">
               <div class="mx-auto">
                  <div style="margin:0 auto; width:50px;height:50px">
                     <!-- <img style="width:40px;height:40px" src="/resources/img/logo.png"> -->
                  </div>
               </div>
            </div>
         </header>
         
			<div style="min-height: calc(100vh - 150px);">
			    
			    <div style="position:absolute; width:100%; height:80%" id="particles-js"></div>
			         
		         <div class="container navless-container" style="padding: 65px 15px;max-width: 960px;">
					      
		            <section class="content">
		               <div class="row">
		                  <div class="col-sm-7 brand-holder">
		                     <h1 style="padding-left: 150px;">
		                        <img style="width: 150px;position: absolute;top: 2px;left: 0px;" src="/resources/img/defesa-novo-hor.png"> | Geoportal ATLAS
		                     </h1>
		                     <h3>Sistema de Geoinformação de Defesa</h3>
		                     <p class="text-justify">
								Este formulário servirá para você solicitar uma nova senha por e-mail. Preencha os campos com seu nome de usuário e CPF e uma nova senha será gerada e enviada para seu e-mail.
		                     </p>
		                  </div>
		                  <div class="col-sm-5">
		                     <div class="box box-primary">
		                     
								<div class="box-header with-border">
					              <i class="fa fa-key"></i><h3 class="box-title">Solicitar Nova Senha</h3>
					            </div>		                     
		                     
                                 <form action="resetpwd" role="form" method="post">
	                              <div class="box-body">
                                    <div class="form-group">
                                       <label for="user_login">Usuário</label>
                                       <input placeholder="Username" class="form-control" autocomplete="off" autofocus="autofocus" autocapitalize="off" autocorrect="off" required="required" name="username" id="username" type="text">
                                    </div>
                                    <div class="form-group">
                                       <label for="user_password">CPF</label>
                                       <input autocomplete="off" autofocus="autofocus" autocapitalize="off" autocorrect="off" placeholder="CPF" class="form-control" required="required" name="cpf" id="cpf" type="text">
                                    </div>
                                    
                                    <div class="box-footer">
                                       	<table style="width:100%">
                                       		<tr>
                                       			<td style="width:50%;padding:3px"><input id="submitBtn" name="commit" value="Solicitar" class="btn btn-block btn-primary btn-sm disabled" type="submit"></td>
                                       			<td style="width:50%;padding:3px"><input id="backbtn" value="Cancelar" class="btn btn-block btn-primary btn-sm" type="button"></td>
                                       		</tr>	                                 
                                       </table>
                                       
                                       
                                    </div>
                                    
                                   </div> 
                                 </form>
		                     </div>
		                  </div>
		               </div>
		            </section>
            
            
            	</div>
            
            
         </div>
         
         
         <hr class="footer-fixed">
         <div class="container footer-container">
   <div class="pull-right hidden-xs">
     Ministério da Defesa
   </div>
   <!-- Default to the left -->
   <strong>Sistema de Geoinformação de Defesa</strong> 
         </div>
         
         
      </div>
      <jsp:include page="requiredscripts.jsp" />
      
      <script>
			
	    $( "#backbtn" ).click(function() {
	    	window.location.href = "/";
	    });


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


     
     		particlesJS.load('particles-js', '/resources/particles/particles-config.json', function() {
    		 //
    	});

		function checaTudo(){

			var cpf = $("#cpf").inputmask('unmaskedvalue');
			var username = $("#username").val();
			
			if ( testaCPF( cpf ) ){
				
				if( username === "" ){
					$("#submitBtn").addClass("disabled");
				} else {
					$("#submitBtn").removeClass("disabled");
				}

			} else {
				$("#submitBtn").addClass("disabled");
			}

		}

     		
		$( document ).ready(function() {
			$('#cpf').inputmask({"mask": "999.999.999-99"});


			$("#username").keyup( function() {
				checaTudo();
			});
			
			$("#cpf").keyup( function() {
				checaTudo();
			});

			
		});
		
      </script>
      
      
   </body>
   
   
   
</html>


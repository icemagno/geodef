<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<html manifest="">
   <jsp:include page="head.jsp" />
   <body class="hold-transition skin-blue layout-top-nav">
   
   
   
<div class="modal modal-warning fade" id="modal-warning" tabindex="-1" role="dialog" aria-labelledby="modal-warning-label" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="modal-warning-label">Confirmar Apagar?</h4>
            </div>
            <div class="modal-body" id="modalBody">
            	 <p>Você irá retirar a autorização de <span style="font-weight:bold" id="userName"></span> para acessar o sistema '<span style="font-weight:bold" id="clientName"></span>'.</p>
                 <p>Quer mesmo continuar?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a class="btn btn-danger btn-ok">Remover</a>
            </div>
        </div>
    </div>
</div>     
   
   
   
   
   
      <div class="modal modal-danger fade" id="modal-danger">
         <div class="modal-dialog">
            <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                  <h4 class="modal-title">Erro</h4>
               </div>
               <div class="modal-body">
                  <p id="modalBody">${error}</p>
               </div>
               <div class="modal-footer">
                  <button type="button" class="btn btn-outline" data-dismiss="modal">Fechar</button>
               </div>
            </div>
         </div>
      </div>
      <div class="wrapper">
      
         <header class="main-header">
            <nav class="navbar navbar-static-top" role="navigation">
               <jsp:include page="pagelogo.jsp" />
            </nav>
         </header>
         
         <div class="content-wrapper">
            <!-- Main content -->
            <section class="content container-fluid">
               <div class="row">
                  <div class="col-md-6">
                     <div class="box box-primary">
                        <div class="box-header with-border">
                           <i class="fa fa-user"></i>
                           <h3 class="box-title">Cadastrar Usuário</h3>
                        </div>
                        <div class="box-body box-profile">
                           <div class="box-header with-border" style="background: url('/resources/img/testeback.jpg') center center;">
                              <img id="img-upload" class="profile-user-img img-responsive img-circle" style="width:100px;height:100px" src="${pageContext.servletContext.contextPath}/photos/${referenceUser.profileImage}" alt="User profile picture">
                              <h3 class="profile-username text-center">${referenceUser.name}</h3>
                              <p class="text-muted text-center">${referenceUser.fullName}</p>
                           </div>
                           <form:form enctype="multipart/form-data" style="margin-top: 50px;" modelAttribute="referenceUser" id="theForm" action="${pageContext.servletContext.contextPath}/useranonimous" method="POST" role="form">
                              <div class="box-body">
                                 <div clas="row">
                                    <div class="col-xs-6">
                                       <form:input type="hidden" path="id" name="id" />
                                       <form:input type="hidden" path="profileImage" name="profileImage" />
                                       <input type="hidden" value="create" name="method" />
                                       <div class="form-group">
                                          <label for="userId">Nome de Login</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                             <form:input type="text" class="form-control" autocomplete="nope" id="name" name="name" path="name" placeholder="Usuário" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="fullName">Nome Completo</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-male"></i></span>		                                      
                                             <form:input type="text" class="form-control" name="fullName" id="fullName" path="fullName" placeholder="Nome Completo" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="origem">Organização</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-home"></i></span>
                                             <form:input type="text" class="form-control" id="origem" name="origem" path="origem" placeholder="Organização" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="email">E-Mail</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-envelope"></i></span>		                                      
                                             <form:input type="text" class="form-control" id="email" path="email" name="email" placeholder="E-Mail" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="cpf">CPF</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-credit-card"></i></span>		                                      
                                             <form:input type="text"  class="form-control" id="cpf"  name="cpf" path="cpf" placeholder="CPF" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="setor">Setor</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-map-marker"></i></span>		                                      
                                             <form:input type="text" class="form-control" id="setor" path="setor" name="setor" placeholder="Setor" />
                                          </div>
                                       </div>
                                    </div>
                                    <div class="col-xs-6">
                                       <div class="form-group">
                                          <label for="telefone">Telefone</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-phone"></i></span>		                                      
                                             <form:input type="text" class="form-control" id="telefone" name="telefone" path="telefone" placeholder="Telefone" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="funcao">Função</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-cog"></i></span>		                                             
                                             <form:input type="text" class="form-control" id="funcao" name="funcao" path="funcao" placeholder="Função" />
                                          </div>
                                       </div>
                                       <div class="form-group" style="position:relative">

                                       	  
                                       	  <div id="passwordBar" class="progress progress-sm" style="display:none;width:100px;border:1px solid #d2d6de;position: absolute;right: 0px;top:5px;">
	                                       	<div id="passwordBarVal" class="progress-bar progress-bar-red" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%"></div>
                                       	  </div>	
                                          
                                          
                                          <label for="password">Senha</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-lock"></i></span>	                                             
                                             <input type="password" class="form-control" id="password" autocomplete="new-password" name="password"  placeholder="Senha" >
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="password2">Confirme a Senha</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-lock"></i></span>	                                             
                                             <input type="password" class="form-control" id="password2" autocomplete="new-password" name="password2" placeholder="Confirme Senha">
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="userRoles">Perfil de Acesso no Guardião</label>
                                          <select name="userRoles" id="userRoles" class="form-control" data-placeholder="Selecione os perfis" style="width: 100%;">
                                             <option value="ROLE_USER">Usuário Comum</option>
                                          </select>
                                       </div>
                                       <div class="form-group">
                                          <label>Imagem de Perfil</label>
                                          <div class="input-group">
                                             <span class="input-group-btn">
                                             <span class="btn btn-default btn-file">
                                             Procurar… <input type="file" id="profileImageFile" name="profileImageFile">
                                             </span>
                                             </span>
                                             <input type="text" class="form-control" readonly>
                                          </div>
                                       </div>
                                       <!-- 
                                          <div class="checkbox">
                                             <form:checkbox name="enabled" path="enabled" class="flat-red" />
                                             Habilitado
                                          </div>
                                          -->
                                    </div>
                                 </div>
                              </div>
                              <div class="box-footer">
                                 <button type="button" id="formSubmit" class="btn btn-primary pull-right">Enviar</button>
                              </div>
                           </form:form>
                        </div>
                     </div>
                  </div>
                  
                  <div class="col-md-6">
                     
                     <div class="box box-primary">
                        <div class="box-header with-border">
                            <i class="fa fa-gear"></i>
                            <h3 class="box-title">Sistemas Permitidos</h3>
							<div class="box-tools pull-right">
							     <div class="has-feedback" style="position:relative">
							       <input type="text" disabled="" class="form-control input-sm" id="addClient" placeholder="Adicionar Sistema">
							       <span class="glyphicon glyphicon-search form-control-feedback"></span>
							       <div id="searchResult" class="box-body" style="display:none;position: absolute; top: 35px; bottom: -55px; right: 0px; width: 400px; z-index: 999;"></div>
							     </div>
							</div>                            
                        </div>
                        
                        <div class="box-body">
                        
						    <c:forEach var="client" items="${referenceUser.clients}">
						        <div class="box box-primary">
						        
									<div class="box-header with-border">
										<h3 class="box-title">&nbsp; </h3>
										<div class="box-tools pull-right">
											<c:if test="${client.sysadmin}"><button type="button" clientId="${client.clientId}" changeto="off" class="btn btn-danger btn-sm changeAdm"><i class="fa fa-user"></i></button></c:if>
											<c:if test="${not client.sysadmin}"><button type="button" clientId="${client.clientId}" changeto="on" class="btn btn-default btn-sm changeAdm"><i class="fa fa-user"></i></button></c:if>
											<button type="button" id="deleteClient_${client.clientId}" class="btn btn-default btn-sm"><i class="fa fa-trash-o"></i></button>									  
											<button type="button" id="reservation_${client.clientId}" class="btn btn-default btn-sm"><i class="fa fa-pencil"></i></button>	
										</div>
									</div>
						        
						         	<div class="box-body">
										<div class="box box-widget widget-user-2">
											<div class="widget-user-header bg-light-blue">
											  <div class="widget-user-image">
												<img class="img-circle" src="${client.clientImage}" alt="User Avatar">
											  </div>
											  <h3 class="widget-user-username">${client.clientFullName}</h3>
											  <h5 class="widget-user-desc">Acessível de <span id="reservation_txt_${client.clientId}">${client.dtInicial} até ${client.dtFinal}</span></h5>
											  <h5 class="widget-user-desc" style="font-family: Consolas;font-size: 11px;color: #cacaca;">Alterado em ${client.dtAlteracao} por ${client.respAlteracao}: ${client.tipoAlteracao}</h5>
											</div>
										</div>
									</div>
								</div>						         
						    </c:forEach>
                           
                           
                        </div>
                     </div>
                     
                     
                  </div>
                  
               </div>
            </section>
         </div>
         <jsp:include page="footer.jsp" />
         <div class="control-sidebar-bg"></div>
      </div>
      <jsp:include page="requiredscripts.jsp" />
   </body>
   <script>
   
   		function getClientPanel( client ) {
   			var panel = '<li onclick="addClient( \''+ client.clientId +'\' )" class="item" style="cursor:pointer;border:1px solid #cacaca;"><div class="product-img"><img src="' + client.clientImage + '">' +
					'</div><div class="product-info"><span class="product-title">' + client.clientFullName + 
					//'<span class="label label-warning pull-right">$1800</span>' +
					'</span><span class="product-description">' + client.webServerRedirectUri +
					'</span></div></li>';
					
			return panel;		
   		};
   		
   		function addClient( clientId ) {
   			
	  	  	var url="/client/"+clientId+"/add/${referenceUser.id}";
		  	$.ajax({
		        url      : url,
		        method   : 'GET',
		        success : function (obj, textstatus) {
		  			location.reload(true);
		        }
		        
		  	});     			
   			
   		};
   
   
		$('#cpf').inputmask({"mask": "999.999.999-99"});
   
		
		$(".changeAdm").click( function() {
			var clientId = $( this ).attr('clientId');
			var changeTo = $( this ).attr('changeTo');
			
			var me = $( this );
	  	  	var url="/client/"+clientId+"/setAdm/${referenceUser.id}/?value=" + changeTo;
		  	$.ajax({
		        url      : url,
		        method   : 'GET',
		        success : function (obj, textstatus) {
		        	if( obj === "Ok" ) {
		        		if ( changeTo === "off") {
							me.removeClass('btn-danger');		        		
							me.addClass('btn-default');
							me.attr('changeto','on');
		        		} else {
							me.addClass('btn-danger');		        		
							me.removeClass('btn-default');
							me.attr('changeto','off');
		        		}
		        	}
		        }
		        
		  	});   			
			
		});
		
		
		$( "#addClient" ).keyup(function() {
			var clientName = $( this ).val();
			
			if ( clientName === "" ) {
				$("#searchResult").css('display','none');
				return true;
			}
			
	  	  	var url="/searchClient?name=" + clientName;
		  	$.ajax({
		        url      : url,
		        method   : 'GET',
		        success : function (obj, textstatus) {
					if ( obj.clients.length === 0 ) {
						$("#searchResult").css('display','none');
						return true;
					} 		  		
					$("#searchResult").css('display','block');
		  			var result = '<ul class="products-list product-list-in-box">';
		  			for( x=0; x < obj.clients.length; x++  ) {
		  				var client = obj.clients[x];
		  				// clientImage clientId webServerRedirectUri
		  				result = result + getClientPanel( client );
		  			}
		  			
		  			result = result + "</ul>";
		  			
		  			$("#searchResult").html( result );
		  			
		        }
		  	});   		  
		});
		
        
		
		$( "#password" ).keyup(function() {
			var password = $( this ).val();

			if( password != "" ) {
			
				$("#passwordBar").css('display','block');

		  	  	var url="/getPasswordScore?password=" + password;
			  	$.ajax({
			        url      : url,
			        method   : 'GET',
			        success : function (obj, textstatus) {
			  			console.log( obj );
			  			var value = parseInt(obj) * 10;
			  			$("#passwordBarVal").css('width', value + '%');
			  			
		  				$("#passwordBarVal").removeClass('progress-bar-green');
		  				$("#passwordBarVal").removeClass('progress-bar-yellow');
		  				$("#passwordBarVal").removeClass('progress-bar-red');
			  			if( value <= 30 ) {
			  				$("#passwordBarVal").addClass('progress-bar-red');
			  			}
			  			if( (value > 30) && ( value <= 60 ) ) {
			  				$("#passwordBarVal").addClass('progress-bar-yellow');
			  			}
			  			if( value > 60 ) {
			  				$("#passwordBarVal").addClass('progress-bar-green');
			  			}
			  			
			  			
			  			
			        }
			  	});
			  	
			  	
			} else {
				$("#passwordBar").css('display','none');

			}
			
		});   
   	  
   
   	  function deleteClientFromUser( clientId, clientFullName ) {
   		confirmDelete(clientId, clientFullName, '${referenceUser.fullName}');
   	  };	
   
   
      var selectedRoles = [];
      <c:forEach var="role" items="${referenceUser.roles}">
         selectedRoles.push('${role.roleName}');
      </c:forEach>
      $('#userRoles').val( selectedRoles );
      $('#userRoles').trigger('change');
      
      var element = null;
      
      $("#modal-danger").on("hidden.bs.modal", function () {
          element.focus();
      });	
      
      
      $( "#formSubmit" ).click(function() {
      	var password = $("#password").val();
      	var password2 = $("#password2").val();
      	var username = $("#username").val();
      	var fullName = $("#fullName").val();
      	
      	/*  So para o caso de criar novo usuario. Senha em branco aqui
      	// significa que nao sera modificada no banco
      	if( password === null || password ==="" ) {
      		$("#modalBody").text('A senha não pode ser em branco.');
      		$('#modal-danger').modal('show');
      		return false;
      	}
      	*/
      	
      	if( password !== password2 ) {
      		$("#modalBody").text('As senhas são diferentes. Verifique se digitou corretamente.');
      		$('#modal-danger').modal('show');
      		element = $("#password");
      		return false;
      	}
      
      	if( username === "" ) {
      		$("#modalBody").text('O nome de login não pode ser deixado em branco.');
      		$('#modal-danger').modal('show');
      		element = $("#username");
      		return false;
      	}		
      
      	if( fullName === "" ) {
      		$("#modalBody").text('O nome completo não pode ser deixado em branco.');
      		$('#modal-danger').modal('show');
      		element = $("#fullName");
      		return false;
      	}
      	
      	if( $('#userRoles').val().length === 0) {
      		$("#modalBody").text('Ao menos um perfil deverá ser selecionado.');
      		$('#modal-danger').modal('show');
      		element = $("#userRoles");
      		return false;
      	}
      	
      	$("#formSubmit").prop("disabled",true);
      	$("#theForm").submit();
      	
      });
      
      
      
      
      	fotoServer = "${pageContext.servletContext.contextPath}/photos/";
      	
          initUpload();
      
          <c:if test="${not empty error}">$('#modal-danger').modal('show');</c:if>
          
          <c:forEach var="client" items="${referenceUser.clients}">
          
          	  $('#deleteClient_${client.clientId}').click(function(  ) {
          		 deleteClientFromUser('${client.clientId}', '${client.clientFullName}');
          	  });
          
          
	          $('#reservation_${client.clientId}').daterangepicker({
					opens: 'left',
					startDate: '${client.dtInicial}',
					endDate: '${client.dtFinal}',
				    locale: {
				      format: 'DD/MM/YYYY',
				        "applyLabel": "Aceitar",
				        "cancelLabel": "Cancelar",
				        "fromLabel": "De",
				        "toLabel": "Até",
				        "daysOfWeek": [
				            "Dom",
				            "Seg",
				            "Ter",
				            "Qua",
				            "Qui",
				            "Sex",
				            "Sab"
				        ],
				        "monthNames": [
				            "Janeiro",
				            "Fevereiro",
				            "Março",
				            "Abril",
				            "Maio",
				            "Junho",
				            "Julho",
				            "Agosto",
				            "Setembro",
				            "Outubro",
				            "Novembro",
				            "Dezembro"
				        ],				        
				    },
				    showDropdowns: true,
	          }, function(start, end, label) {
	        	  var fromDate = start.format('DD/MM/YYYY');
	        	  var toDate   = end.format('DD/MM/YYYY');
	        	  	$('#reservation_txt_${client.clientId}').html( fromDate + ' até ' + toDate );
	        	  	
	        	  	var url="/client/${client.clientId}/setDate/${referenceUser.id}?start=" + fromDate + "&end=" + toDate;
	        	  	$.ajax({
				        url      : url,
				        method   : 'GET',
				        success : function (obj, textstatus) {
	        	  			console.log( obj );
				        }
				        
	        	  	});
	        	  	
	        	  	
	          });
          
          </c:forEach>
       
          
          
          
          function confirmDelete( clientId, clientFullName, userName ) {
        	  
        	  $('#modal-warning').on('show.bs.modal', function(e) {
        		  $(this).find('.btn-ok').click( function() {
        			  $('#modal-warning').modal('hide');

        		  	  	var url="/client/"+clientId+"/remove/${referenceUser.id}";
        			  	$.ajax({
        			        url      : url,
        			        method   : 'GET',
        			        success : function (obj, textstatus) {
        			  			location.reload(true);
        			        }
        			        
        			  	});        			  
        			  
        		  });
        	  });  
        	  
        	  $('#modal-warning').modal('show');
        	  $("#userName").text( userName );
        	  $("#clientName").text( clientFullName );
        	  
          }          
          
          
          
   </script>
</html>


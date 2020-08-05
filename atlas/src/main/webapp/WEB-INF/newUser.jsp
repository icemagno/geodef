<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<html manifest="">
   <jsp:include page="head.jsp" />
   <body class="skin-blue layout-top-nav">
   
   
	<div class="modal modal-warning fade" id="modal-warning" tabindex="-1"
		role="dialog" aria-labelledby="modal-warning-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modal-warning-label">Confirmar Criar Usuário?</h4>
				</div>
				<div class="modal-body" id="modalWarningBody">
					<p>Deseja realmente criar este usuário?</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
					<a class="btn btn-danger btn-ok">Criar Usuário</a>
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
         <!-- Main Header -->
		<header class="main-header">
			<!-- Header Navbar -->
			<nav class="navbar navbar-static-top" role="navigation">
				<div class="container-fluid">

					<div class="navbar-header">
						<img src="/resources/img/logo-md-2.png"
							style="height: 45px; float: left; margin-top: 3px;"> <img
							src="/resources/img/logo-md-1.png"
							style="height: 43px; float: left; margin-right: 15px; margin-top: 7px;">
						<a style="font-size: 25px;" href="/" class="navbar-brand"><b>Atlas</b>|Geoportal</a>
					</div>

					<!-- Navbar Right Menu -->
					<div class="navbar-custom-menu">
						<ul class="nav navbar-nav">
							<jsp:include page="userdropdown.jsp" />
						</ul>
					</div>

				</div>
			</nav>
		</header>
		<!-- Content Wrapper. Contains page content -->
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
                        	<i>Os campos marcados com asterisco (*) são obrigatórios</i>
                           <form:form enctype="multipart/form-data" style="margin-top: 10px;" modelAttribute="referenceUser" id="theForm" action="/edituser" method="POST" role="form">
                              <div class="box-body">
                                 <div class="row">
                                    <div class="col-xs-6">
                                       <form:input type="hidden" path="id" name="id" />
                                       <form:input type="hidden" path="profileImage" name="profileImage" />
                                       <input type="hidden" value="create" name="method" />
                                       <div class="form-group">
                                          <label for="userId">Nome de Login *</label>
                                          <div class="input-group">
                                             <span id="symbolUserName" class="input-group-addon"><i class="fa fa-user"></i></span>
                                             <form:input type="text" class="form-control" autocomplete="nope" id="name" name="name" path="name" placeholder="Usuário" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="fullName">Nome Completo *</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-male"></i></span>		                                      
                                             <form:input type="text" class="form-control" name="fullName" id="fullName" path="fullName" placeholder="Nome Completo" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="origem">Organização *</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-home"></i></span>
                                             <form:input type="text" class="form-control" id="origem" name="origem" path="origem" placeholder="Organização" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="email">E-Mail *</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-envelope"></i></span>		                                      
                                             <form:input type="text" class="form-control" id="email" path="email" name="email" placeholder="E-Mail" />
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="cpf">CPF *</label>
                                          <div class="input-group">
                                             <span id="symbolCpf" class="input-group-addon"><i class="fa fa-credit-card"></i></span>		                                      
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
                                          <label for="telefone">Telefone *</label>
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
                                          
                                          
                                          <label for="password">Senha *</label>
                                          <div class="input-group">
                                             <span id="symbolPassword" class="input-group-addon"><i class="fa fa-lock"></i></span>	                                             
                                             <input type="password" class="form-control" id="password" autocomplete="new-password" name="password"  placeholder="Senha" >
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="password2">Confirme a Senha *</label>
                                          <div class="input-group">
                                             <span class="input-group-addon"><i class="fa fa-lock"></i></span>	                                             
                                             <input type="password" class="form-control" id="password2" autocomplete="new-password" name="password2" placeholder="Confirme Senha">
                                          </div>
                                       </div>
                                       <div class="form-group">
                                          <label for="userRoles">Perfil de Acesso *</label>
                                          <select name="userRoles" id="userRoles" class="form-control" data-placeholder="Selecione os perfis" style="width: 100%;">
                                             <option value="ROLE_USER">Usuário Comum</option>
                                             <option value="ROLE_ADMIN">Administrador Geral</option>
                                          </select>
                                       </div>
                                       
                                       <!-- 
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
                                        -->
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
                           <i class="fa fa-user"></i>
                           <h3 class="box-title">Regras de Preenchimento</h3>
                        </div>                  
							<ul class="timeline">
							                         	
					            <li>
					              <i class="fa fa-user bg-red"></i>
					              <div class="timeline-item">
					                <h3 class="timeline-header no-border">O nome de login precisa ter ao menos 8 caracteres.</h3>
					              </div>
					            </li>
	
	
					            <li>
					              <i class="fa fa-male bg-red"></i>
					              <div class="timeline-item">
					                <h3 class="timeline-header no-border">O nome completo precisa ter ao menos 10 caracteres.</h3>
					              </div>
					            </li>
	                            
					            <li>
					              <i class="fa fa-lock bg-red"></i>
					              <div class="timeline-item">
					                <h3 class="timeline-header no-border">A senha precisa conter letras em maiúsculas e minúsculas, números e caracteres especiais e não pode ser menor que 8 caracteres.</h3>
					              </div>
					            </li>
	
					            <li>
					              <i class="fa fa-home bg-red"></i>
					              <div class="timeline-item">
					                <h3 class="timeline-header no-border">A Organização precisa ter ao menos 5 caracteres.</h3>
					              </div>
					            </li>
	
					                                    	
							</ul>                        	
					</div>                  
                  
                  </div>
                  
               </div>
            </section>
         </div>
         <jsp:include page="footer.jsp" />
         <div class="control-sidebar-bg"></div>
      </div>
      <jsp:include page="requiredscripts.jsp" />

	<script src="/resources/usermanager/newuser.js" type="text/javascript"></script>
	<script src="/resources/usermanager/log-generator.js" type="text/javascript"></script>

	<script>

		$( document ).ready(function() {

			$("#name").keyup( function() {
				var nome = $("#name").val();
				checkUserName( nome );
			});
			$("#cpf").keyup( function() {
				var cpf = $("#cpf").inputmask().val();
				checkCpf( cpf );
			});

			
			$('#cpf').inputmask({"mask": "999.999.999-99"});


			var inputElement = $('#telefone');
			setCorrectPhoneMask(inputElement);
			inputElement.on('input, keyup', function(){
				setCorrectPhoneMask(inputElement);
			});

			
			<c:forEach var="role" items="${referenceUser.roles}">
				selectedRoles.push('${role.roleName}');
			</c:forEach>

			<c:if test="${not empty error}">
				$('#modal-danger').modal('show');
			</c:if>

		    $('#userRoles').val( selectedRoles );
		    $('#userRoles').trigger('change');

			$("#modal-danger").on("hidden.bs.modal", function () {
				userValidationElement.focus();
			});	

			preparePasswordValidation();
			prepareUserSubmitForm();
			initUpload();
			
		});	

	</script>


   </body>
</html>


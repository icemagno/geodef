<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html manifest="">
   <jsp:include page="head.jsp" />
   <body class="hold-transition" style="margin:0px; padding:0px">
   
      <div class="page-wrap">
      
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
			         
		         <div class="container navless-container" style="padding: 65px 15px;max-width: 960px;">
					      
		            <section class="content">
		               <div class="row">
		                  <div class="col-sm-7 brand-holder">
		                     <h1>
		                        <img style="width:50px;" src="/resources/img/defesa-novo.png"> Bem-vindo ao Guardião
		                     </h1>
		                     <h3>Gerenciador de Credenciais</h3>
		                     <p class="text-justify">
		                        Guardião é o Servidor de Autenticação Single Sign-On / OAuth 2.0 
		                        da Chefia de Logística e Mobilização.
		                        Aplicativos podem compartilhar o sistema de login centralizado do Guardião
		                        para autenticar os seus usuários usando a especificação OAuth 2.0. Os usuários
		                        autenticados no Guardião podem utilizar quaisquer aplicativos cadastrados sem a 
		                        necessidade de autenticar-se novamente.
		                     </p>
		                  </div>
		                  <div class="col-sm-5">
		                     <div class="box box-primary">
                                 <form action="login" role="form" method="post">
	                              <div class="box-body">
                                    <div class="form-group">
                                       <label for="user_login">Nome de Login</label>
                                       <input placeholder="Usuário" class="form-control" autocomplete="off" autofocus="autofocus" autocapitalize="off" autocorrect="off" required="required" name="username" id="user_login" type="text">
                                    </div>
                                    <div class="form-group">
                                       <label for="user_password">Senha</label>
                                       <input autocomplete="off" placeholder="Senha" class="form-control" required="required" name="password" id="user_password" type="password">
                                    </div>
                                    
                                    <div class="box-footer">
                                       <input name="commit" value="Entrar" class="btn btn-block btn-success btn-lg" type="submit">
                                       <input type="hidden" class="form-control" name="error" value="">
                                    </div>
                                    
                                    <div style="float:left"><a href="#">[ Esqueci minha Senha ]</a></div>
                                    <div style="float:right"><a href="/newUserAnonimous">[ Registre-se ]</a></div>
                                    
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
     Chefia de Logística e Mobilização
   </div>
   <!-- Default to the left -->
   <strong>Ministério da Defesa</strong> 
         </div>
         
         
      </div>
      <jsp:include page="requiredscripts.jsp" />
   </body>
</html>


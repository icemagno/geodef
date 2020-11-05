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

			        <div class="alert alert-danger alert-dismissible">
			          <h4><i class="icon fa fa-ban"></i>Dados Inválidos</h4>
			          Não foi possível entrar no sistema com as credenciais fornecidas.	</br>
			          Verifique se o usuário e senha estão corretos ou se este usuário está habilitado.		          
			        </div>
					      
		            <section class="content">
		               <div class="row">
		                  <div class="col-sm-7 brand-holder">
		                     <h1 style="padding-left: 150px;">
		                        <img style="width: 150px;position: absolute;top: 2px;left: 0px;" src="/resources/img/defesa-novo-hor.png"> | GEOPORTAL
		                     </h1>
		                     <h3>Sistema de Geoinformação de Defesa</h3>
		                     <p class="text-justify">
								O Sistema de Geoinformação de Defesa (SisGEODEF) é o sistema de referência para a gestão da geoinformação no Ministério da Defesa. 
								Possui como objetivos, a organização, disponibilização e a eficiência de informações geoespaciais relativos a segurança Nacional, 
								para apoiar as operações conjuntas entre as forças armadas.
		                     </p>
		                  </div>
		                  <div class="col-sm-5">
		                     <div class="box box-primary">
		                     
								<div class="box-header with-border">
					              <i class="fa fa-key"></i><h3 class="box-title">Efetuar Login</h3>
					            </div>		                     
		                     
		                     
                                 <form action="login" role="form" method="post">
	                              <div class="box-body">
                                    <div class="form-group">
                                       <label for="user_login">Usuário</label>
                                       <input placeholder="Username" class="form-control" autocomplete="off" autofocus="autofocus" autocapitalize="off" autocorrect="off" required="required" name="username" id="user_login" type="text">
                                    </div>
                                    <div class="form-group">
                                       <label for="user_password">Senha</label>
                                       <input autocomplete="off" placeholder="Password" class="form-control" required="required" name="password" id="user_password" type="password">
                                    </div>
                                    
                                    <div class="box-footer">
                                       <input name="commit" value="Login" class="btn btn-block btn-success btn-sm" type="submit">
                                       <input type="hidden" class="form-control" name="error" value="">
                                    </div>
									<div style="margin: 0 auto; width: 45%;text-align:center;"><a href="/resetpassword">[ Esqueci a Senha ]</a></div>                                    
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
     versão 06/11/2020
   </div>
   <!-- Default to the left -->
   <strong>Sistema de Geoinformação de Defesa</strong> 
         </div>
         
         
      </div>
      <jsp:include page="requiredscripts.jsp" />
      
      <script>
	    particlesJS.load('particles-js', '/resources/particles/particles-config.json', function() {
    		 //
    	});
      </script>
      
      
   </body>
   
   
   
</html>


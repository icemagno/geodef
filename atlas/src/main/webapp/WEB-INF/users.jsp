<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html manifest="">
<!-- PAGE HEAD -->
<jsp:include page="head.jsp" />
<style type="text/css">
/* show the move cursor as the user moves the mouse over the panel header.*/
#draggablePanelList {
	cursor: move;
}
</style>
<body class="skin-blue layout-top-nav">

	<div class="modal modal-warning fade" id="modal-warning" tabindex="-1"
		role="dialog" aria-labelledby="modal-warning-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modal-warning-label">Confirmar
						Apagar?</h4>
				</div>
				<div class="modal-body" id="modalBody">
					<p>
						Você irá apagar o usuário <span id="userName"></span>
					</p>
					<p>O que você está prestes a fazer é irreversível.</p>
					<p>Quer mesmo continuar?</p>
					<p class="debug-url"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
					<a class="btn btn-danger btn-ok">Apagar Usuário</a>
				</div>
			</div>
		</div>
	</div>


	<div class="modal modal-danger fade" id="modal-danger" tabindex="-1"
		role="dialog" aria-labelledby="modal-danger-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modalDangerLabel"></h4>
				</div>
				<div class="modal-body" id="modalDangerBody"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" id="btnDangerOk">Ok</button>
				</div>
			</div>
		</div>
	</div>


	<div class="modal modal-success fade" id="modal-success" tabindex="-1"
		role="dialog" aria-labelledby="modal-success-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modalSuccessLabel"></h4>
				</div>
				<div class="modal-body" id="modalSuccessBody"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="btnSuccessOk">Ok</button>
				</div>
			</div>
		</div>
	</div>



	<div class="wrapper">
		<!-- Main Header -->
		<header class="main-header">
			<!-- PAGE LOGO -->

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


				<div class="box box-primary">
					<div class="box-header with-border">
						<h3 class="box-title">Gerenciar Usuários</h3>
						<div class="box-tools pull-right">
							<!-- Se quiser colocar algo a direita da barra...  -->
						</div>
						<!-- /.box-tools -->
					</div>
					<div class="mailbox-controls">
						<a href="/newUser" class="btn btn-default"><i
							class="fa fa-plus"></i></a>
					</div>
					<div class="box-body">
						<table id="userTable" class="table table-hover table-striped"></table>
					</div>
				</div>



			</section>

		</div>

		<jsp:include page="footer.jsp" />

	</div>

	<!-- LOAD JAVASCRIPT FILES -->
	<jsp:include page="requiredscripts.jsp" />

	<!-- ALERT MODAL -->
	<div class="modal modal-danger fade" id="modal-danger">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">Algo deu errado!</h4>
				</div>
				<div class="modal-body">
					<p>Não foi possível completar a requisição solicitada. Entre em
						contato com o suporte.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-outline" data-dismiss="modal">Fechar</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

</body>

<script>
  
  function confirmDelete( userId, what ) {
	  var urlDelete = "/user/"+userId;
	  
	  $('#modal-warning').on('show.bs.modal', function(e) {
		  $(this).find('.btn-ok').click( function() {
			  $('#modal-warning').modal('hide');
			  
			    $.ajax({
			        url      : urlDelete,
			        method   : 'DELETE',
			        success : function (obj, textstatus) {
			        	//console.log( textstatus );
			        	//console.log( obj );

			        	if ( obj.type === 'success') {
			        		loadTable();
				        	 
				        	$("#modalSuccessLabel").text("Concluído");
				        	$("#modalSuccessBody").text( "O usuário foi removido do banco de dados." );

							/*
				        	$('#modal-success').on('show.bs.modal', function(e) {
				    		    $('#btnSuccessOk').click( function() {
				    		    	location.reload( true );
				    		    });
				      	    });  
				        	$('#modal-success').modal('show');
				        	*/
			        	}
			        	
			        	
			        	if ( obj.type === 'error') { 
				        	$("#modalDangerLabel").text("Erro");
				        	$("#modalDangerBody").text( obj.message );
	  			      	    $('#modal-danger').on('show.bs.modal', function(e) {
				    		    $('#btnDangerOk').click( function() {
				    		    	location.reload( true );
				    		    });
				      	    });
	  			      		$('#modal-danger').modal('show');
			        	}

			        	
			        	
			        	
			        },
			        failure : function (obj, textstatus) {
						//
			        }			        
			    });
			  
			  
		  });
	  });  
	  
	  $('#modal-warning').modal('show');
	  $("#userName").text( what );
	  
  }
  
  function loadTable(){

	    $.ajax({
	        url: '/userlist',
	        dataType: 'json',
	        success: function (obj, textstatus) {
	    		var usuarios = obj.data;
	    		var dataSet = [];
	    		
	    		for ( var i=0; i<usuarios.length; i++ ) {
	    			var usuario = usuarios[i];
	    			var migData = [];

	    			//console.log( usuario );
	    			
	    			
	    			var userId = usuario.id;
	    			
	    			// {label-warning , label-primary , label-danger }
	    			var habilitado = usuario["enabled"];
	    			var admin = usuario["admin"];
	    			var habIcon = "label-danger";
	    			var habString = "Desabilitado";
	    			if( habilitado ) {
	    				habIcon = "label-success";
	    				habString = "Habilitado";
	    			}
	    			
	    			var admIcon = "label-primary";
	    			var admString = "USUÁRIO";
	    			if( admin ) {
	    				admIcon = "label-danger";
	    				admString = "ADMINISTRADOR";
	    			} 
	    			
	    			
	    			var rolesDisplay = "<div style='width: 250px;'>";
	    			var uRoles = usuario.roles; 
	        		for ( var r=0; r<uRoles.length; r++ ) {
	        			var uRole = uRoles[r];
	        			rolesDisplay = rolesDisplay + '<div style="float:left;margin-right:5px;"><span class="label label-primary">' + uRole.roleName + '</div></span>';
	        			
	        		}
	        		rolesDisplay = rolesDisplay + "</div>";
	    			
	    			
	    			var userFullName = usuario["fullName"];
	    			migData.push( userFullName );
	    			migData.push( usuario["name"] );
	    			
	    			migData.push( usuario["cpf"] );
	    			migData.push( usuario["email"] );
	    			
	    			//migData.push( '<img style="width:40px;height:40px;border:1px solid black;" src="${pageContext.servletContext.contextPath}/photos/' + usuario["profileImage"] + '">' );
	    			//migData.push( '<span class="label ' + habIcon + '">' + habString + '</span>' );
	    			
	    			migData.push( '<span class="label ' + admIcon + '">' + admString + '</span>' );
	    			//migData.push( rolesDisplay );
	    			
	    			
	    			migData.push( 
	    					'<a href="/user/'+userId+'" class="btn btn-xs btn-default"><i class="fa fa-pencil"></i></a> &nbsp;' +
	    					' <a href="#" onclick="confirmDelete(' + userId + ',\''+userFullName+'\')" class="btn btn-xs btn-default"><i class="fa fa-trash"></i></a>');
	    			
	    			dataSet.push( migData );
	    		}

	    		$('#userTable').dataTable( {
	    			'responsive': true,
	    			'destroy' : true,
	    			'rowId': 'cpf',

	    		    language: {
	    		        searchPlaceholder: "Localizar",
	    		        search: "_INPUT_",
	    		        paginate: {
	    		            first:    '«',
	    		            previous: '‹',
	    		            next:     '›',
	    		            last:     '»'
	    		        },
	    		        emptyTable: "Nenhum Registro Encontrado",
	    		        zeroRecords: "Nenhum Registro Encontrado",
	    		        infoEmpty: "Sem registros",
	    		        infoFiltered: " - filtrado de _MAX_ records",
	    		        aria: {
	    		            paginate: {
	    		                first:    'Primeiro',
	    		                previous: 'Anterior',
	    		                next:     'Próximo',
	    		                last:     'Último'
	    		            }
	    		        }    		        
	    		        
	    		    },    			
	    			data : dataSet,
	                   columns: [
	                       { title: "Nome" },
	                       { title: "Login" },
	                       { title: "CPF" },
	                       { title: "E-Mail" },
	                       //{ title: "Foto" },
	                       //{ title: "Habilitado" },
	                       { title: "Perfil" },
	                       { title: "&nbsp;" }
	                   ],
	                   "bPaginate": true,
	                   "bLengthChange": false,
	                   "bFilter": true,
	                   "bInfo": false,
	                   "bAutoWidth": false,	                
	    		});			    	
	         
	        },
	        error: function (obj, textstatus) {
	        	$('#modal-danger').modal({});
	        }
	    });	

  }
  
  
	$( document ).ready(function() {
		loadTable();
	});	

	
  </script>


</html>


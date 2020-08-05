<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html manifest="">
  <!-- PAGE HEAD -->
  <jsp:include page="head.jsp" />
  <body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
      <!-- Main Header -->
      <header class="main-header">
        <!-- PAGE LOGO -->
        <jsp:include page="pagelogo.jsp" />
        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
          <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
          <span class="sr-only">Toggle navigation</span>
          </a>
          <!-- Navbar Right Menu -->
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- NOTIFICATIONS -->
              <jsp:include page="notifications.jsp" />
              <!-- TASKS -->
              <jsp:include page="tasksmenu.jsp" />
              <!-- USER DROP DOWN -->	          
              <jsp:include page="userdropdown.jsp" />
            </ul>
          </div>
        </nav>
      </header>
      <!-- Left side column. contains the logo and sidebar -->
      <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar" >
          <!-- SIDEBAR -->
          <jsp:include page="sidebar.jsp" />
        </section>
        <!-- /.sidebar -->
      </aside>
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Geoportal
            <small>Sistema de Geoinformação de Defesa</small>
          </h1>
        </section>
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
              <a class="btn btn-default"><i class="fa fa-trash"></i></a>
              <a class="btn btn-default"><i class="fa fa-pencil"></i></a>
              <a class="btn btn-default"><i class="fa fa-plus"></i></a>
            </div>
            <div class="box-body no-padding">
              <div class="table-responsive mailbox-messages">
                <table id="userTable" class="table table-hover table-striped"></table>
              </div>
            </div>
          </div>
        </section>
        <!-- /.content -->
      </div>
      <!-- /.content-wrapper -->
      <!-- LOAD PAGE FOOTER -->
      <jsp:include page="footer.jsp" />
    </div>
    <!-- ./wrapper -->
    <!-- LOAD JAVASCRIPT FILES -->
    <jsp:include page="requiredscripts.jsp" />
  </body>
  <script>
    $.ajax({
        url: 'v1/usuarios',
        dataType: 'json',
        success: function (obj, textstatus) {
    		var usuarios = obj.data;
    		var dataSet = [];
    		
    		for ( var i=0; i<usuarios.length; i++ ) {
    			var usuario = usuarios[i];
    			var migData = [];
    			
    			console.log( usuario );
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
    			
    			migData.push( usuario["fullName"] );
    			migData.push( usuario["username"] );
    			migData.push( '<img style="width:40px;height:40px;" src="${pageContext.servletContext.contextPath}/fotos/' + usuario["profileImage"] + '">' );
    			migData.push( '<span class="label ' + habIcon + '">' + habString + '</span>' );
    			migData.push( '<span class="label ' + admIcon + '">' + admString + '</span>' );
    			migData.push( '<a href="user/'+userId+'" class="btn btn-default"><i class="fa fa-edit"></i></a>' );
    			
    			dataSet.push( migData );
    		}
    		
    		$('#userTable').dataTable( {
    			'responsive': true,
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
    		        infoEmpty: "No entries to show",
    		        infoFiltered: " - filtered from _MAX_ records",
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
                       { title: "Foto" },
                       { title: "Habilitado" },
                       { title: "Perfil" },
                       { title: "Editar" }
                   ],
                   "bPaginate": true,
                   "bLengthChange": false,
                   "bFilter": true,
                   "bInfo": false,
                   "bAutoWidth": true,	                
    		});			    	
         
        },
        error: function (obj, textstatus) {
            alert(obj.msg);
        }
    });	
    
  </script>    
</html>


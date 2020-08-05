<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html manifest="">
  <!-- PAGE HEAD -->
  <jsp:include page="head.jsp" />
  <style type="text/css">
    /* show the move cursor as the user moves the mouse over the panel header.*/
    #draggablePanelList  {
    cursor: move;
    }
  </style>
  <body class="hold-transition skin-blue layout-top-nav">
    <div class="wrapper">
      <!-- Main Header -->
      <header class="main-header">
        <!-- PAGE LOGO -->
        
        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
		  <jsp:include page="pagelogo.jsp" />
          <!-- Navbar Right Menu -->
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- NOTIFICATIONS -->
              <jsp:include page="notifications.jsp" />
              <!-- TASKS -->
              <jsp:include page="tasksmenu.jsp" />
              <!-- USER DROP DOWN -->
              <jsp:include page="userdropdown.jsp" />
              <!-- Control Sidebar Toggle Button -->
              <li>
                <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
              </li>
            </ul>
          </div>
        </nav>
      </header>

      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Main content -->
        <section class="content container-fluid">
          <div class="row">


            <div class="col-md-12">
              <div class="box box-primary">
                <div class="box-body">
						Você é um usuário comum. Esta é uma página temporária de portal.<br><br>
						
						<c:forEach var="client" items="${user.clients}">
				            <div class="box box-primary">
								<div class="box-header with-border">
									<h3 class="box-title">&nbsp; </h3>
									<div class="box-tools">
										<a href="${client.homePath}" class="btn btn-default btn-sm"><i class="fa fa-external-link"></i></a>
									</div>				            
								</div>				            
				            
				                <div class="box-body">						
										<div class="box box-widget widget-user-2">
											<div class="widget-user-header bg-light-blue">
											  <div class="widget-user-image">
												<img class="img-circle" src="${client.clientImage}" alt="User Avatar">
											  </div>
											  <h3 class="widget-user-username">${client.clientFullName}</h3>
											  <h5 class="widget-user-desc">${client.descricao}</h5>
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

        <!-- /.content -->
      </div>
      <!-- /.content-wrapper -->
      <!-- LOAD PAGE FOOTER -->
      <jsp:include page="footer.jsp" />
      <!-- Control Sidebar -->
      <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
          <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
          <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
          <!-- Home tab content -->
          <div class="tab-pane active" id="control-sidebar-home-tab">
            <h3 class="control-sidebar-heading">Sistemas:</h3>
			<c:forEach var="client" items="${user.clients}">
			    <h5>${client.clientFullName}</h5>
			</c:forEach>	
            <!-- /.control-sidebar-menu -->
          </div>
          <!-- /.tab-pane -->
          <!-- Stats tab content -->
          <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
          <!-- /.tab-pane -->
          <!-- Settings tab content -->
          <div class="tab-pane" id="control-sidebar-settings-tab">
            <h3 class="control-sidebar-heading">Importadores Ativos</h3>
            <ul class="control-sidebar-menu">
              <li>
                <a href="javascript:;">
                  <h4 class="control-sidebar-subheading">
                    [XYF4A6] - BDGEX 
                    <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                    </span>
                  </h4>
                  <div class="progress progress-xxs">
                    <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                  </div>
                </a>
              </li>
              <li>
                <a href="javascript:;">
                  <h4 class="control-sidebar-subheading">
                    [UUH34C] - DHN-CARTAS 
                    <span class="pull-right-container">
                    <span class="label label-success pull-right">30%</span>
                    </span>
                  </h4>
                  <div class="progress progress-xxs">
                    <div class="progress-bar progress-bar-success" style="width: 30%"></div>
                  </div>
                </a>
              </li>
            </ul>
          </div>
          <!-- /.tab-pane -->
        </div>
      </aside>
      <!-- /.control-sidebar -->
      <!-- Add the sidebar's background. This div must be placed
        immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div>
    <!-- ./wrapper -->
    <!-- LOAD JAVASCRIPT FILES -->
    <jsp:include page="requiredscripts.jsp" />
  </body>



</html>


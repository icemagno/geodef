<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html manifest="">

<!-- PAGE HEAD -->
<jsp:include page="head.jsp" />

<style>
	.skin-black-light .main-header .navbar-brand {
		border-width: 0px !important;
	}

	.skin-black-light .main-header .navbar .navbar-custom-menu .navbar-nav>li>a, .skin-black-light .main-header .navbar .navbar-right>li>a{
		border-width: 0px !important;
	}
	
	
	.skin-black-light .main-header{
		border : 0px !important;
	}
	
	.skin-black-light .main-header .navbar {
		background-color: #3c8dbc !important;
	}
	
	.topmnubtn{
		height : 30px;
	}
	
	.sidebar-toggle:hover {
		background: #3c8dbc;
	}	
	
	.main-sidebar{
		width: 340px; 
	}
	
	.sidebar-collapse .main-sidebar {
		webkit-transform: translate(-230px, 0);
    	-ms-transform: translate(-230px, 0);
    	-o-transform: translate(-230px, 0);	
		transform: translate(-340px, 0);
	}
	
	.main-footer table{
		width: 100%;
    	margin: 0px;
    	padding:0px;
    	padding-left: 2px;	
    	padding-right: 2px;	
	}
	.main-footer table td{
		border-bottom: 1px solid #cacaca;
	}
	
	.slider.slider-horizontal .slider-tick, .slider.slider-horizontal .slider-handle {
	    margin-left: -10px;
	    margin-top: -3px;
	}	
	.slider-handle {
	    width: 10px;
	    height: 16px;	
	}
		
</style>


<body class="skin-black-light layout-top-nav">

	<!--  VERIFICAR SE ESTE MODAL ESTÁ SENDO USADO  -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Fechar</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body" id="modal-bodyku"></div>
				<div class="modal-footer" id="modal-footerq"></div>
			</div>
		</div>
	</div>
	<!-- *********************************************** -->

	<div class="modal modal-warning fade" id="modal-warning" tabindex="-1"
		role="dialog" aria-labelledby="modal-warning-label" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="modal-warning-label">Atenção</h4>
				</div>
				<div class="modal-body" id="modalBody">
					<p id="modalWarningText" ></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>






	<div class="wrapper" style="height: 2000px">
		<!-- Main Header -->
		<header class="main-header">


			<!-- Header Navbar -->
			<nav class="navbar navbar-static-top" role="navigation">
				
				<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button"></a>
				
				<div class="container-fluid">

					<div class="navbar-header">
						<img id="logoMd2" src="/resources/img/logo-md-2.png"
							style="height: 45px; float: left; margin-top: 3px;"> <img
							src="/resources/img/logo-md-1.png"
							style="height: 43px; float: left; margin-right: 15px; margin-top: 7px;">
						<a style="font-size: 22px; color:white;margin-right: 20px;" href="/" class="navbar-brand">Geoportal | SisGEODEF</a>
					</div>


			        <div class="btn-group">
			            
			            <a href="#" class="btn btn-primary navbar-btn dropdown-toggle" style="padding:2px;margin-top: 10px; margin-bottom: 0px;" data-toggle="dropdown">
			            	<img src="${midasLocation}/atlas/icons/solucionadores.png" class="topmnubtn">
			            </a>
			            <ul class="dropdown-menu dropdown-menu-xs">
                           <li><a href="/docs/2.4/sidebar">Cor Meteorológica</a></li>
                           <li><a href="/themes/AdminLTE/documentation/index.html">Análise 3D</a></li>
			            </ul>
			            
			        </div>

			        <div class="btn-group">
			            
			            <a href="#" class="btn btn-primary navbar-btn dropdown-toggle" style="padding:2px;margin-top: 10px; margin-bottom: 0px;" data-toggle="dropdown">
			            	<img src="${midasLocation}/atlas/icons/solucionadores.png" class="topmnubtn">
			            </a>
			            <ul class="dropdown-menu dropdown-menu-xs">
                           <li><a href="/docs/2.4/sidebar">Cor Meteorológica</a></li>
                           <li><a href="/themes/AdminLTE/documentation/index.html">Análise 3D</a></li>
			            </ul>
			            
			        </div>

					<!-- Navbar Right Menu -->
					<div class="navbar-custom-menu">
						<ul class="nav navbar-nav">
							<!-- USER DROP DOWN -->
							<jsp:include page="userdropdown.jsp" />
							<!-- Control Sidebar Toggle Button -->
							<li><a title="Configurações" href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a></li>
						</ul>
					</div>


				</div>
			</nav>

		</header>

		<jsp:include page="sidebar.jsp" />
 
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="position: relative;">
			<!-- Main content -->
			<section style="padding: 0px;" class="content container-fluid">

				<div class="row">
					<div class="fullWindow" id="cesiumContainer"></div>
				</div>

			</section>
			<!-- /.content -->
		</div>



		<!-- /.control-sidebar -->
		<jsp:include page="controlsidebar.jsp" />

		 
	    <!-- Main Footer -->
		<footer class="main-footer" style="height:44px;padding: 0px 10px 0px 10px;">
			<table style="width:100%;">
				<tr><td>ss</td><td>ss</td><td>ss</td><td>ss</td><td>ss</td><td>ss</td><td>ss</td></tr>
				<tr><td>ss</td><td>ss</td><td>ss</td><td>ss</td><td>ss</td><td>ss</td><td>ss</td></tr>
			</table>
		</footer>	
		
	</div>
	<!-- ./wrapper -->
	<!-- LOAD JAVASCRIPT FILES -->
	<jsp:include page="requiredscripts.jsp" />

	<script src="/resources/Cesium/Cesium.js" type="text/javascript"></script>

	<script src="${midasLocation}/atlas/resources/scalebar/viewerCesiumNavigationMixin.min.js" type="text/javascript"></script>

	<script type="text/javascript">
	$( document ).ready(function() {
		var error = '${error}';
		if( error.length > 1 ) {
			$("#modalWarningText").text( error );
			$('#modal-warning').modal('show');
		}
	});	
	</script>


	<script src="${midasLocation}/atlas/resources/globe.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/convertions.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/layers.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/jsonlayers.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/modal.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/profilegraph.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/measures.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/viewshed.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/buildings3d.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/drawfeatures.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/pointcloud.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/flightcontrol.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/screenshot.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/routes.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/favelas.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/flood.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/menubar.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/sensors.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/toast.js"></script>

	<script src="${midasLocation}/atlas/resources/sistram.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/avisosradio.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/arvorecarto.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/pcn.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/climatologia.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/cormeteoro.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/export.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/js/anewradar.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/marinetraffic.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/windparticle.js" type="text/javascript"></script>
	
	<script src="${midasLocation}/atlas/resources/metocprevisao.js" type="text/javascript"></script>
	
	<!-- 	
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoBuildingsProvider.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoPointCloudProvider.js" type="text/javascript"></script>
	 -->
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoMarineTrafficProvider.js" type="text/javascript"></script>
	
	<script src="${midasLocation}/atlas/resources/js/geohash.js" type="text/javascript"></script>
	
</body>

</html>


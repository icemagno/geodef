<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html manifest="">

<!-- PAGE HEAD -->
<jsp:include page="head-new.jsp" />

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
	
	.leftpaneltitle{
		height: 35px;
    	padding-right: 3px;
    	margin-bottom: 10px;
    	padding-left: 3px;
		background-color:#f9fafc
	}
	
	.topmnuimg{
		height : 30px;
	}
	.topmnubtn{
		padding:2px;
		margin-top: 7px; 
		margin-bottom: 0px;
		width: 47px;
    	height: 36px;		
	}
	
	.basemapimg{
		border:1px solid #cacaca;
		border-radius:2px;
	    margin: 3px;
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
	
	#tableFooter{
		width: 100%;
    	margin: 0px;
    	padding:0px;
    	padding-left: 2px;	
    	padding-right: 2px;	
	}
	#tableFooter td{
		border-bottom: 1px solid #cacaca;
		text-align: right;
		width: 150px;
	}
	
	.progress-sm{
		padding:0px !important;
		margin:0px !important;
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

					<!-- Barra de botoes -->
					<jsp:include page="barradebotoes.jsp" />

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
					<div id="toolbar"></div>
					<div id="logging"></div>
				
					<div class="fullWindow" id="cesiumContainer">
						<div style="position: absolute; z-index: 999; right: 80px; bottom: 80px;" id="rosaVentos">
							<img src="/resources/img/compassmap.png" style="height: 120px; opacity: 0.6;">
						</div>
					</div>
				</div>
			</section>
			<!-- /.content -->
		</div>


		<!-- /.control-sidebar -->
		<jsp:include page="controlsidebar.jsp" />

		 
	    <!-- Main Footer -->
	    <jsp:include page="footer.jsp" />

		
	</div>
	
	<!-- LOAD JAVASCRIPT FILES -->
	<jsp:include page="requiredscripts.jsp" />


	<!-- Javascript que so faz sentido para o mapa  -->
	<script src="/resources/Cesium/Cesium.js" type="text/javascript"></script>
	<script src="/resources/graticule/Graticule.js" type="text/javascript"></script>

	<script src="${midasLocation}/atlas/resources/convertions.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/menubar.js" type="text/javascript"></script>
	<script src="/resources/drawhelper/drawhelper.js"></script>
	<script src="${midasLocation}/atlas/resources/scalebar/viewerCesiumNavigationMixin.min.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/globe-new.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/js/geohash.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/drawfeatures-new.js" type="text/javascript"></script>

	<script src="${midasLocation}/atlas/resources/arvorecarto.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/layers.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/controlsidebar.js" type="text/javascript"></script>



	<!-- 
	<script src="${midasLocation}/atlas/resources/jsonlayers.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/modal.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/profilegraph.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/measures.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/viewshed.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/buildings3d.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/pointcloud.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/flightcontrol.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/screenshot.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/routes.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/favelas.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/flood.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/sensors.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/sistram.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/avisosradio.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/pcn.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/climatologia.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/cormeteoro.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/export.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/js/anewradar.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/marinetraffic.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/windparticle.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/metocprevisao.js" type="text/javascript"></script>
 	-->

	<!-- 	
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoBuildingsProvider.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoPointCloudProvider.js" type="text/javascript"></script>
	 -->
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoMarineTrafficProvider.js" type="text/javascript"></script>
	

	<script type="text/javascript">
	$( document ).ready(function() {
		var error = '${error}';
		if( error.length > 1 ) {
			$("#modalWarningText").text( error );
			$('#modal-warning').modal('show');
		}
	});	
	</script>

	
</body>

</html>


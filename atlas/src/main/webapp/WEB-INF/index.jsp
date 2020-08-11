<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html manifest="">
<!-- PAGE HEAD -->
<jsp:include page="head.jsp" />


<style>
	.slider-handle.triangle {
		border-bottom-color: black !important;
	}
</style>

<body class="skin-blue layout-top-nav">

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
				<div class="container-fluid">

					<div class="navbar-header">
						<img id="logoMd2" src="/resources/img/logo-md-2.png"
							style="height: 45px; float: left; margin-top: 3px;"> <img
							src="/resources/img/logo-md-1.png"
							style="height: 43px; float: left; margin-right: 15px; margin-top: 7px;">
						<a style="font-size: 25px;" href="/" class="navbar-brand">GEOPORTAL</a>
					</div>


						<!--  BARRA DE BOTÕES DE FERRAMENTAS -->
						<div id="toolBarsContainer"
							style="float:left;width: auto;margin-top: 7px;margin-left: 25px;">
							<div id="toolBarStandard" class="btn-group"
								style="float: left; opacity: 0.6;">
								
								<button title="Guia Rápido" id="toolGuia" 
									type="button" class="btn btn-primary btn-flat">
									<i class="fa fa-info-circle"></i>
								</button>
								<button title="Catálogo EDGV-DEFESA" id="toolEdgvBook" style="margin-left:10px;"
									type="button" class="btn btn-primary btn-flat">
									<i class="fa fa-book"></i>
								</button>
								
								
								<button title="Solucionadores" id="toolSolucionadores"
									type="button" class="btn btn-primary btn-flat">
									<i class="fa fa-bolt"></i>
								</button>
								<button title="Interrogar" id="showToolQuery" type="button"
									class="btn btn-primary btn-flat">
									<i class="fa fa-question"></i>
								</button>
								<button title="Ferramentas de Rota" id="showToolRoutes"
									type="button" class="btn btn-primary btn-flat">
									<i class="fa fa-automobile"></i>
								</button>
								<button title="Salva a tela atual como imagem"
									id="toolScreenSnapShot" type="button"
									class="btn btn-primary btn-flat">
									<i class="fa fa-camera"></i>
								</button>
								<button title="Ferramentas de Desenho de Feições"
									id="showDesignTools" type="button"
									class="btn btn-primary btn-flat">
									<i class="fa fa-pencil-square-o"></i>
								</button>
								<button title="Ferramentas de Análise 3D" id="show3DTools"
									type="button" class="btn btn-primary btn-flat">
									<i class="fa fa-cube"></i>
								</button>
								<button title="Ferramentas de Medição" id="showMeasureTools"
									type="button" class="btn btn-primary btn-flat">
									<i class="fa fa-arrows-h"></i>
								</button>
								<button title="Barra de Componentes" id="showComponentsBar"
									type="button" class="btn btn-primary btn-flat">
									<i class="fa fa-server"></i>
								</button>
								<button title="Voltar ao Início" id="toolHome" type="button" style="margin-right:10px"
									class="btn btn-success btn-flat">
									<i class="fa fa-home"></i>
								</button>
								<button title="Visualizar de Cima" id="toolGoTopView" type="button"
									class="btn btn-success btn-flat">
									<i class="fa fa-level-down"></i>
								</button>
							</div>
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

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="position: relative;">

			<!-- Content Header (Page header) -->

			<!-- Main content -->
			<section style="padding: 0px;" class="content container-fluid">

				<div class="row">
					<div class="fullWindow" id="cesiumContainer">

						<div
							style="opacity: 0.8; display: none; padding: 5px; text-align: right; width: auto; height: 75px; border: 1px solid black; background-color: #ffcc00; position: absolute; z-index: 999; left: 80px; top: 80px;"
							id="toolTip"></div>

						<div
							style="opacity: 0.9; display: none; padding: 5px; text-align: right; width: 170px; height: 115px; border: 1px solid #3c8dbc; background-color: #f9fafc; position: absolute; z-index: 99999; left: 0px; top: 0px;"
							id="contextMenuRouteInit">
							<button id="btnStartRoute" onclick="setStartRoute()"
								type="button" class="btn btn-flat btn-block btn-primary btn-xs">Origem
								da Rota Aqui</button>
							<button id="btnEndRoute" onclick="calculateRoute()" type="button"
								class="btn btn-flat btn-block btn-primary btn-xs disabled">Destino
								da Rota Aqui</button>
							<button id="btnBlockRoute" onclick="insertBlockRoute()"
								type="button" class="btn btn-flat btn-block btn-primary btn-xs">Inserir
								Bloqueio de Rota</button>
							<button onclick="cancelRouteEditing()" type="button"
								class="btn btn-flat btn-block btn-xs">Cancelar</button>
						</div>

						<div
							style="opacity: 0.9; display: none; padding: 5px; text-align: right; width: 170px; height: 170px; border: 1px solid #3c8dbc; background-color: #f9fafc; position: absolute; z-index: 99999; left: 0px; top: 0px;"
							id="contextMenuRecalcRoute">
							<button id="btnEdtStartRoute" onclick="recalculateRoute('start')"
								type="button" class="btn btn-flat btn-block btn-primary btn-xs">Mover
								Origem Aqui</button>
							<button id="btnEdtEndRoute" onclick="recalculateRoute('end')"
								type="button" class="btn btn-flat btn-block btn-primary btn-xs">Mover
								Destino Aqui</button>
							<button id="btnDerivateRoute"
								onclick="recalculateRoute('newstart')" type="button"
								class="btn btn-flat btn-block btn-primary btn-xs">Nova
								Origem Aqui</button>
							<button id="btnDerivateRoute"
								onclick="recalculateRoute('derivate')" type="button"
								class="btn btn-flat btn-block btn-primary btn-xs">Novo
								Destino Aqui</button>
							<button id="btnDerivateRoute"
								onclick="recalculateRoute('addwaypoint')" type="button"
								class="btn btn-flat btn-block btn-primary btn-xs">Obrigatório
								Passar Aqui</button>
							<button onclick="cancelRouteEditing()" type="button"
								class="btn btn-flat btn-block btn-xs">Cancelar</button>
						</div>

						<div
							style="position: absolute; z-index: 999; right: 80px; bottom: 80px;"
							id="rosaVentos">
							<img src="/resources/img/compassmap.png"
								style="height: 120px; opacity: 0.6;">
						</div>

						<div id="elevationProfileContainer"
							style="left: 270px; position: absolute; z-index: 9999; bottom: 43px; height: 90px; width: 400px; opacity: 0.9; display: none;">

							<div class="box box-primary">
								<div class="box-body" style="padding: 2px;">
									<div id="interactive"
										style="height: 80px; width: 310px; float: left;"></div>
									<div id="profilePanel"
										style="height: 80px; width: 80px; float: left; font-family: Consolas; font-size: 11px;">
										<div id="profileHeightValue"></div>
										<div id="profileMaxHeightValue"></div>
									</div>
								</div>
							</div>

						</div>

						<!-- PAINEL LATERAL DE ELEMENTOS -->
						<div id="layerContainer"
							style="display: none; font-size: 11px; height: auto; left: 10px; position: absolute; z-index: 9999; top: 5px; width: 300px; background-color: white;">

							<!-- ARVORE -->
							<div class="panel" style="margin-bottom: 0px">
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseZero"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-sitemap"></i> &nbsp; Árvore de Camadas
									</button>
								</div>
								<div id="collapseZero" class="panel-collapse collapse">
									<div style="padding: 0px; height: 400px" class="box-body">
										<div id="cartoTreeContainer"
											style="padding: 4px; height: 400px" class="box-body">

											<div class="form-group" style="margin-bottom: 5px;">
												<a style="margin-right: 6px;" title="Limpar" href="#"
													onClick="closeSearchToolBarMenu();"
													class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a> <input id="layerNameFinder"
													style="width: 200px; height: 25px;" type="text"
													name="message" onkeyup="findLayerByNome();"
													placeholder="Localizar Camada ..." class="form-control">
											</div>
											<div class="table-responsive">
												<table id="searchMenuTable" class="table"
													style="margin-bottom: 0px; width: 100%"></table>
											</div>

											<div id="treeview-terrestre" class=""></div>
										</div>
									</div>
								</div>
							</div>

							<!-- CAMADAS -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="layersCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseOne"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-map-o"></i> &nbsp; Camadas Ativas
									</button>
								</div>
								<div id="collapseOne" class="panel-collapse collapse">
									<div style="padding: 0px; height: 433px" class="box-body">
										<div class="table-responsive">
											<table class="table" id="activeLayersControlButtons" style="border-bottom:2px solid #3c8dbc;margin-bottom: 0px;width:100%">
												<tr>
													<td class="layerTable" style="text-align: right;"> 
														<button title="Acessar Arquivo de Mapas" onclick="openMapCalisto();" type="button" class="btn btn-primary btn-xs btn-flat"><i class="fa fa-list"></i></button>
														<button title="Exportar Mapa (PDF)" onclick="exportStandardMap();" type="button" class="btn btn-primary btn-xs btn-flat"><i class="fa fa-file-pdf-o"></i></button>
													</td>
												</tr>
											</table>
										</div>										
										<div id="activeLayerContainer" style="padding: 4px; height: 400px" class="box-body">
										</div>
									</div>
								</div>
							</div>


							<!-- CLIMATOLOGIA -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="climatoInmetCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseZion"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-soundcloud"></i> &nbsp; Climatologia
									</button>
								</div>
								<div id="collapseZion" class="panel-collapse collapse">
									<div style="padding: 0px; height: 400px" class="box-body">
										<div id="climatoInmetContainer"	style="padding: 4px; height: 400px" class="box-body">
											<div class="table-responsive">
												<table class="table" id="climatoControlButtons" style="border-bottom:2px solid #3c8dbc;display:none;margin-bottom: 0px;width:100%">
													<tr>
														<td colspan="3" class="layerTable" style="text-align: right;background-color:#30376d"> 
															<img style="height:30px;float:left;margin-left: 4px;" src="/resources/img/inmet.png"> 
															<button style="background-color: #30376d;" title="Primeiro Quadro" onclick="toFirstFrame();" type="button" class="btn btn-primary btn-sm btn-flat"><i class="fa fa-fast-backward"></i></button>
															<button style="background-color: #30376d;" title="Quadro Anterior" onclick="toPreviousFrame();" type="button" class="btn btn-primary btn-sm btn-flat"><i class="fa fa-step-backward"></i></button>
															<button style="background-color: #30376d;" title="Animar" onclick="start();"  type="button" class="btn btn-primary btn-sm btn-flat"><i class="fa fa-play"></i></button>
															<button style="background-color: #30376d;" title="Parar" onclick="stop();" type="button" class="btn btn-primary btn-sm btn-flat"><i class="fa fa-stop"></i></button>
															<button style="background-color: #30376d;" title="Próximo Quadro" onclick="toNextFrame();" type="button" class="btn btn-primary btn-sm btn-flat"><i class="fa fa-step-forward"></i></button>
															<button style="background-color: #30376d;" title="Último Quadro" onclick="toLastFrame();" type="button" class="btn btn-primary btn-sm btn-flat"><i class="fa fa-fast-forward"></i></button>
														</td>
													</tr>
													
													<tr>
														<td class="layerTable" style="width: 30%;text-align: left;">
															Transparência
														</td>
														<td colspan="2" style="padding-left: 15px;padding-right: 15px;padding-top: 3px;padding-bottom: 3px;">
															<input id="climatoSlider" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100"
																data-slider-handle="triangle" data-slider-tooltip="hide" data-slider-step="5" data-slider-value="40" data-slider-id="blue">
														</td>
													</tr>
													<tr>
														<td id="monthControlStart" colspan="2" class="layerTable" style="text-align: left;">
															Janeiro
														</td>
														<td id="monthControlEnd" class="layerTable" style="text-align: right;">
															Dezembro
														</td>
													</tr>
													<tr>
														<td colspan="3" style="padding-left: 15px;padding-right: 15px;padding-top: 3px;padding-bottom: 3px;">
															<input id="monthControlSlider" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="11"
																data-slider-handle="triangle" data-slider-tooltip="hide" data-slider-step="1" data-slider-value="[0,11]" data-slider-id="blue">
														</td>
													</tr>
													<tr>
														<td id="climatoMonth" colspan="3" class="layerTable" style="font-weight:bold;font-size: 12px;text-align: center;">&nbsp;</td>
													</tr>
												</table>
											</div>		
										</div>
									</div>
								</div>
							</div>



							<!-- ROTAS -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="routesCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseTwo"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-automobile"></i> &nbsp; Rotas
									</button>
								</div>
								<div id="collapseTwo" class="panel-collapse collapse">
									<div id="routesContainer" style="padding: 4px; height: 400px"
										class="box-body"></div>
								</div>
							</div>

							<!-- DESENHO -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="drawedCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseThree"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-pencil-square-o"></i> &nbsp; Desenhos
									</button>
								</div>
								<div id="collapseThree" class="panel-collapse collapse">
									<div style="padding: 0px; height: 400px" class="box-body">
										<div id="drawedObjectsContainer"
											style="padding: 4px; height: 400px" class="box-body"></div>
									</div>
								</div>
							</div>

							<!-- DOMINIO DE TERRENO -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="viewshedCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseFour"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-cube"></i> &nbsp; Análise 3D
									</button>
								</div>
								<div id="collapseFour" class="panel-collapse collapse">
									<div style="padding: 0px; height: 400px" class="box-body">
										<div id="viewshedResultsContainer"
											style="padding: 4px; height: 400px" class="box-body"></div>
									</div>
								</div>
							</div>

							<!-- MEDIDAS -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="measureCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseFive"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-arrows-h"></i> &nbsp; Medições
									</button>
								</div>
								<div id="collapseFive" class="panel-collapse collapse">
									<div style="padding: 0px; height: 400px" class="box-body">
										<div id="measureResultsContainer"
											style="padding: 4px; height: 400px" class="box-body"></div>
									</div>
								</div>
							</div>

							<!-- EXPORTADOS -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="exportedCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="text-align: left; padding: 0px;"
									class="box-header with-border">
									<button style="text-align: left;" href="#collapseSix"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-camera"></i> &nbsp; Produtos Exportados
									</button>
								</div>
								<div id="collapseSix" class="panel-collapse collapse">
									<div style="padding: 0px; height: 400px" class="box-body">
										<div id="exportedProductsContainer"
											style="padding: 4px; height: 400px" class="box-body"></div>
									</div>
								</div>
							</div>


							<!-- DIVERSOS -->
							<div class="panel" style="margin-bottom: 0px">
								<div id="diversosCounter"
									style="z-index: 9999; right: 5px; position: absolute; height: 22px; width: 22px; text-align: right; color: white;"></div>
								<div style="padding: 0px;" class="box-header with-border">
									<button style="text-align: left;" href="#collapseSeven"
										data-toggle="collapse" data-parent="#layerContainer"
										type="button"
										class="btn btn-block btn-primary btn-xs btn-flat">
										<i class="fa fa-cubes"></i> &nbsp; Diversos
									</button>
								</div>
								<div id="collapseSeven" class="panel-collapse collapse">
									<div style="padding: 0px; height: 400px" class="box-body">
										<div id="diversosContainer"
											style="padding: 4px; height: 400px" class="box-body"></div>
									</div>
								</div>
							</div>


						</div>

						<!-- DIREÇÕES DAS ROTAS -->
						<div id="routeContainer"
							style="display: none; font-size: 11px; height: 523px; left: 320px; position: absolute; z-index: 9999; top: 45px; width: 250px; background-color: white; border-bottom: 2px solid #3c8dbc;">
							<div style="padding: 0px;" class="box-header with-border">
								<button id="routeDirButton" style="text-align: left;"
									type="button" class="btn btn-block btn-primary btn-xs btn-flat">
									<i class="fa fa-arrows-alt"></i> &nbsp; Direções da Rota <a
										style="color: white;" title="Fechar" href="#"
										onClick="hideRouteDir();" class="pull-right"><i
										class="fa fa-close"></i></a> &nbsp; <a
										style="color: white; margin-right: 10px;"
										title="Exportar para PDF" href="#"
										onClick="exportDirectionsToPDF();" class="pull-right"><i
										class="fa fa-file-pdf-o"></i></a>
								</button>
							</div>
							<div id="routeDetailContainer"
								style="background-color: white; padding: 5px;"></div>
						</div>


						<!--  CAIXA DE MENUS DAS FERRAMENTAS  -->
						<!-- ROTA -->
						<div id="routeMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="routeMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><i class="fa fa-automobile"></i>
												&nbsp;<b>Ferramenta de Rota</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeRouteToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i>Use o botão direito do
														mouse para abrir as opções.</i></span></td>
										</tr>
										<tr>
											<td class="layerTable">Sugerir Rota Alternativa (mais
												lento)</td>
											<td class="layerTable" style="text-align: right;"><input
												id="allowAlternatives" type="checkbox" class="pull-right"></td>
										</tr>
										<tr>
											<td class="layerTable">Raio do Bloqueio de Rota (metros)</td>
											<td class="layerTable" style="text-align: right;"><input
												value="5" class="pull-right"
												style="text-align: right; height: 17px; width: 50px; font-family: Consolas;"
												id="barrierRadius"></td>
										</tr>
										<tr>
											<td class="layerTable">Bloqueio tem precedência sobre
												Obrigatoriedade</td>
											<td class="layerTable" style="text-align: right;"><input
												id="blockRoutePrecedence" checked type="checkbox"
												class="pull-right"></td>
										</tr>
									</table>
								</div>
							</div>
						</div>


						<!-- INTERROGACAO -->
						<div id="queryMenuBox" class="toolBarMenuBox" style="width:350px">
							<div class="box-body">
								<div class="table-responsive">
									<table id="queryMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable" colspan="2"><i
												class="fa fa-question"></i> &nbsp;<b>Ferramenta de
													Interrogação</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeQueryToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="3"><span
												style="font-size: 11px"><i>Clique e solte o botão
														esquerdo sobre o item que deseja interrogar.</i></span></td>
										</tr>
									</table>
								</div>
							</div>
						</div>

						<!-- DESENHO -->
						<div id="drawMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="drawMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><i class="fa fa-pencil-square-o"></i>
												&nbsp;<b>Ferramenta de Desenho</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeDrawToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i>Clique e solte o botão
														esquerdo para posicionar os pontos. Botão direito para
														terminar.</i></span></td>
										</tr>
										<tr>
											<td class="layerTable" colspan="2">&nbsp;</td>
										</tr>
									</table>
								</div>
							</div>
						</div>

						<!-- VIEWSHED -->
						<div id="vsMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="vsMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><i class="fa fa fa-cube"></i>
												&nbsp;<b>Ferramenta de Análise 3D</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeVsToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i><b>Domínio de Terreno:</b> Clique e solte o botão
														esquerdo para posicionar a origem. Mova o mouse lentamente
														sem arrastar para posicionar o sensor. Botão direito para
														terminar.</i></span></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i><b>Construções OSM:</b> Clique no canto inferior esquerdo 
												e no canto superior direito da área desejada.</i></span><span
												style="font-size: 11px"><i>Selecione áreas pequenas (aprox. 5km2)</i></span></td>
										</tr>
									</table>
								</div>
							</div>
						</div>

						<!-- MEDIÇÃO -->
						<div id="measureMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="measureMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><i class="fa fa fa-arrows-h"></i>
												&nbsp;<b>Ferramenta de Medição</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeMeasureToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i>Selecione uma
														ferramenta. Clique com o botão esquerdo para posicionar os
														pontos de medição. Botão direito para terminar.</i></span></td>
										</tr>
										<tr>
											<td class="layerTable" colspan="2">&nbsp;</td>
										</tr>
									</table>
								</div>
							</div>
						</div>


						<!-- AVISOS RADIO -->
						<div id="avisosRadioMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="avisosRadioMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><img
												src="/resources/img/wave.png"
												style="width: 15px; height: 15px;"> &nbsp;<b>Avisos Rádio</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeAvisosRadioToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i>Centro de Hidrografia da Marinha</i></span></td>
										</tr>
										<tr>
											<td class="layerTable">Somente Eventos SAR</td>
											<td class="layerTable" style="text-align: right;"><input id="sarEventsOnly" type="checkbox" class="pull-right"></td>
										</tr>
										<!-- 
										<tr>
											<td class="layerTable">Usar Dados Fictícios</td>
											<td class="layerTable" style="text-align: right;"><input id="avisoMockData" type="checkbox" class="pull-right"></td>
										</tr>
										 -->
										<tr>
											<td colspan="2" class="layerTable">
												<button id="loadAvisosRadioBtn" type="button" class="btn btn-block btn-primary btn-xs btn-flat">Carregar Dados</button>
											</td>
										</tr>
										
										
									</table>
								</div>
							</div>
						</div>

						<!-- CONTEUDO DOS AVISOS -->
						<div id="avisosContainer"
							style="display: none; font-size: 11px; height: 323px; left: 320px; position: absolute; z-index: 9999; top: 45px; width: 350px; background-color: white; border-bottom: 2px solid #3c8dbc;">
							<div style="padding: 0px;" class="box-header with-border">
								<button id="avisosButton" style="text-align: left;"
									type="button" class="btn btn-block btn-primary btn-xs btn-flat">
									<i class="fa fa-arrows-alt"></i> &nbsp; Avisos Vigentes 
									<a style="color: white;" title="Fechar" href="#" onClick=" $('#avisosContainer').hide(); " class="pull-right"><i class="fa fa-close"></i></a>
								</button>
								<div >
									<img style='float:right;height: 38px; width: 348px;' src='/resources/img/logo-chm.png'>
									<img style='position: absolute; right: 1px; bottom: 2px;height: 38px; width: 43px;' src='/resources/img/chm.png'>
								</div>
							</div>
							<div id="avisosDetailContainer"
								style="background-color: white; padding: 5px;"></div>
						</div>


						<!-- PLATAFORMAS -->
						<div id="plataformasMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="plataformasMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><img
												src="/resources/img/plataforma.png"
												style="width: 15px; height: 15px;"> &nbsp;<b>Plataformas
													de Petróleo</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closePlataformasToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i>Clique em uma
														plataforma para verificar área de segurança.</i></span></td>
										</tr>
										<tr>
											<td class="layerTable">Raio de Segurança (mn)</td>
											<td class="layerTable" style="text-align: right;"><input
												value="0.5" class="pull-right"
												style="text-align: right; height: 17px; width: 50px; font-family: Consolas;"
												id="platSecurityRadius"></td>
										</tr>
									</table>
								</div>
							</div>
						</div>

						<!-- METEOROLOGIA -->
						<div id="metocMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="metocMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><img
												src="/resources/img/clima2.png"
												style="width: 15px; height: 15px;"> &nbsp;<b>INMET | Climatologia</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeMetocToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i>Climatologia - Séries Históricas.</i></span></td>
										</tr>
										<tr>
											<td class="layerTable">Período</td>
											<td class="layerTable" style="text-align: right;">
												<select class="pull-right" style="text-align: right; height: 17px; width: 160px; font-family: Consolas;" id="periodoHistorico" >
								                    <option value="6190" selected>1961 - 1990</option>
								                    <option value="8110">1981 - 2010</option>
								                </select>											
											</td>
										</tr>
										<tr>
											<td class="layerTable">Variável Meteorológica</td>
											<td class="layerTable" style="text-align: right;">
												<select class="pull-right" style="text-align: right; height: 17px; width: 160px; font-family: Consolas;" id="varMeteorologica" >
								                    <option value="NULL">Temperatura Máxima</option>
								                    <option value="NULL">Temperatura Mínima</option>
								                    <option value="precip" selected>Precipitação Acumulada (mm)</option>
								                    <option value="NULL">Intensidade e Direção do Vento (10m)</option>
								                </select>											
											</td>
										</tr>
										<tr>
											<td colspan="2" class="layerTable">
												<button id="loadClimatologiaBtn" type="button" class="btn btn-block btn-primary btn-xs btn-flat">Carregar Dados</button>
											</td>
										</tr>
										
									</table>
								</div>
							</div>
						</div>

						<!-- PCN -->
						<div id="pcnMenuBox" class="toolBarMenuBox">
							<div class="box-body">
								<div class="table-responsive">
									<table id="pcnMenuTable" class="table"
										style="margin-bottom: 0px; width: 100%">
										<tr>
											<td class="layerTable"><img
												src="/resources/img/pcn.png"
												style="width: 15px; height: 15px;"> &nbsp;<b>Busca por PCN</b></td>
											<td style="width: 5px; padding: 0px;"><a title="Fechar"
												href="#" onClick="closeMetocToolBarMenu();"
												class="text-light-blue pull-right"><i
													class="fa fa-close"></i></a></td>
										</tr>
										<tr style="border-bottom: 2px solid #3c8dbc">
											<td class="layerTable" colspan="2"><span
												style="font-size: 11px"><i>Localiza pistas de pouso por critério de PCN.</i></span></td>
										</tr>
										<tr>
											<td class="layerTable">Largura Mínima (m)</td>
											<td class="layerTable" style="text-align: right;">
												<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNWidth">
											</td>
										</tr>
										<tr>
											<td class="layerTable">Comprimento Mínimo (m)</td>
											<td class="layerTable" style="text-align: right;">
												<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNLength">
											</td>
										</tr>
										<tr>
											<td class="layerTable">Classe PCN</td>
											<td class="layerTable" style="text-align: right;">
												<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNClass">
											</td>
										</tr>
										<tr>
											<td class="layerTable">Tipo de Pavimento</td>
											<td class="layerTable" style="text-align: right;">
												<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNPavement" >
								                    <option value="*" selected>Indiferente</option>
								                    <option value="R">[R] - Rígido</option>
								                    <option value="F">[F] - Flexível</option>
								                </select>											
											</td>
										</tr>
										<tr>
											<td class="layerTable">Resistência</td>
											<td class="layerTable" style="text-align: right;">
												<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNResistence" >
								                    <option value="*" selected>Indiferente</option>
								                    <option value="A">[A] - Alta</option>
								                    <option value="B">[B] - Média</option>
								                    <option value="C">[C] - Baixa</option>
								                    <option value="D">[D] - Ultrabaixa</option>
								                </select>											
											</td>
										</tr>
										<tr>
											<td class="layerTable">Pressão dos Pneus</td>
											<td class="layerTable" style="text-align: right;">
												<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNPressure" >
								                    <option value="*" selected>Indiferente</option>
								                    <option value="W">[W] - Alta</option>
								                    <option value="X">[X] - Média</option>
								                    <option value="Y">[Y] - Baixa</option>
								                    <option value="Z">[Z] - Muito Baixa</option>
								                </select>											
											</td>
										</tr>
										<tr>
											<td class="layerTable">Método de Avaliação</td>
											<td class="layerTable" style="text-align: right;">
												<select class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchPCNAval" >
								                    <option value="*" selected>Indiferente</option>
								                    <option value="T">[T] - Análise Técnica</option>
								                    <option value="U">[U] - Análise Prática</option>
								                    <option value="O">[O] - Outros</option>
								                </select>											
											</td>
										</tr>
										<tr>
											<td class="layerTable">ICAO (Opcional)</td>
											<td class="layerTable" style="text-align: right;">
												<input value="" class="pull-right" style="text-align: right; height: 17px; width: 150px; font-family: Consolas;" id="searchICAO">
											</td>
										</tr>
										
										
										<tr>
											<td class="layerTable" style="width:50%">
												<button onclick="searchPCNRunwaysBtn();" id="searchPCNRunwaysBtn" type="button" class="btn btn-block btn-primary btn-xs btn-flat">Mapa</button>
											</td>
											<td class="layerTable" style="width:50%">	
												<button onclick="searchPCNRunwaysBtnR();" id="searchPCNRunwaysBtnR" type="button" class="btn btn-block btn-primary btn-xs btn-flat">Relatório</button>
											</td>
										</tr>
										
									</table>
								</div>
							</div>
						</div>

						<!--  SUB MENU DE FERRAMENTAS -->
						<div id="toolBarsSubContainer"
							style="left: 381px; position: absolute; z-index: 9999; top: 5px; width: auto; opacity: 0.9;">

							<!-- MEDIDA -->
							<div id="toolBarMeasure" class="btn-group"
								style="display: none; float: right;">
								<button title="Realiza medição de área" id="toolMeasureArea"
									type="button" class="btn btn-warning btn-flat">
									<i class="fa fa-object-ungroup"></i>
								</button>
								<button title="Realiza medição de linha" id="toolMeasureLine"
									type="button" class="btn btn-warning btn-flat">
									<i class="fa fa-expand"></i>
								</button>
							</div>

							<!-- ROTA -->
							<div id="toolBarRoutes" class="btn-group"
								style="display: none; float: right;">
								<button style="margin-right: 2px;" title="Cálculo de Rotas"
									id="toolRoutes" type="button" class="btn btn-warning btn-flat">
									<i class="fa fa-map-signs"></i>
								</button>
							</div>

							<!-- VIEWSHED -->
							<div id="toolBarTerrainAnalysis" class="btn-group"
								style="display: none; float: right;">
								<button title="Domínio de Terreno" id="toolViewShed"
									type="button" class="btn btn-warning btn-flat">
									<i class="fa fa-eye"></i>
								</button>
								<button title="Construções OSM 3D" id="toolOSM3D" type="button"
									class="btn btn-warning btn-flat">
									<i class="fa fa-bank"></i>
								</button>
							</div>

							<!-- DESENHO -->
							<div id="toolBarFeatures" class="btn-group"
								style="display: none; float: right;">
								<button title="Desenhar Polígono 3D" id="toolAddPolygon"
									type="button" class="btn btn-warning btn-flat">
									<i class="fa fa-object-group"></i>
								</button>
								<button title="Desenhar Polígono 2D" id="toolAddPolygonSurface"
									type="button" class="btn btn-warning btn-flat">
									<i class="fa fa-clone"></i>
								</button>
								<button title="Desenhar Ponto" id="toolAddPoint" type="button"
									class="btn btn-warning btn-flat">
									<i class="fa fa-circle"></i>
								</button>
								<button title="Desenhar Linha" id="toolAddLine" type="button"
									class="btn btn-warning btn-flat">
									<i class="fa fa-expand"></i>
								</button>
							</div>

							<!-- SOLUCIONADORES -->
							<!-- Va em menubar.js para os handlers  -->
							<div id="toolBarSolucionadores" class="btn-group"
								style="display: none; float: right;">
								
								<button title="Avisos Rádio" id="toolAvisoRadio"
									type="button" class="btn btn-warning  btn-flat">
									<img src="/resources/img/wave.png"
										style="width: 20px; height: 20px; left: 10px; position: absolute; top: 7px;">
								</button>

								<button title="Área de Segurança de Plataformas" id="toolGtOpA"
									type="button" class="btn btn-warning  btn-flat">
									<img src="/resources/img/plataforma.png"
										style="width: 20px; height: 20px; left: 10px; position: absolute; top: 7px;">
								</button>
								
								<button title="Climatologia" id="toolMetoc"
									type="button" class="btn btn-warning  btn-flat">
									<img src="/resources/img/clima2.png"
										style="width: 20px; height: 20px; left: 10px; position: absolute; top: 7px;">
								</button>

								<button title="Número de Classificação de Pavimento (PCN)" id="toolPCN"
									type="button" class="btn btn-warning  btn-flat">
									<img src="/resources/img/pcn.png"
										style="width: 29px;height: 25px;left: 5px;position: absolute;top: 2px;">
								</button>

								<button title="Cor Meteorológica" id="toolCOR"
									type="button" class="btn btn-warning  btn-flat">
									<img src="/resources/img/cormet.png"
										style="width: 29px;height: 25px;left: 5px;position: absolute;top: 2px;">
								</button>

								
							</div>


						</div>

						<div id="flightControlsContainer"
							style="display: none; right: 140px; position: absolute; z-index: 9999; top: 5px; height: 50px;">
							<div id="flightControls"
								style="width: 100px; height: 50px; margin: 0 auto;">
								<span id="attitude"></span><span id="heading"></span><span
									id="altimeter"></span>
								<div class="instrument" style="width: 100px; height: 100px;">
									<img class="background box" src="/img/fi_box.svg">
									<div class="roll box">
										<img style="width: 100px; height: 100px; padding: 5px;"
											src="/resources/img/compass.jpg">
									</div>
									<div id="compassPointer" class="roll box">
										<img
											style="width: 70px; height: 70px; position: absolute; top: 17px; left: 16px;"
											src="/resources/img/pointer.png">
									</div>
								</div>
							</div>
						</div>

						<div id="bottonBar"
							style="width: 100%; position: absolute; z-index: 9999; font-family: Consolas; font-size: 11px; bottom: 0px; height: 15px; background-color: rgb(60, 141, 188); color: white;">

							<div class="layerCounter" id="layerLoadingPanelGau" style="width: 150px; display:none;float: left; margin-left: 20px;margin-right:5px;padding-top:3px">
								<div class='progress progress-sm active'>
									<div class='progress-bar progress-bar-red progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'></div>
								</div>
							</div>
							<div class="layerCounter" id="layerLoadingPanelCnt" style="width: 50px; float: left;display:none">
								<div id="lyrCount" style="width: 50px; float: left">0</div>
							</div>


							<div id="latLonPanel"
								style="width: 210px; float: right; margin-right: 10px;">
								<div id="mapLat"
									style="width: 100px; text-align: right; float: left"></div>
								<div id="mapLon"
									style="width: 100px; text-align: right; float: left"></div>
							</div>

							<div id="heightPanel"
								style="width: 200px; float: right; margin-right: 10px;">
								<div id="mapHei"
									style="width: 100px; text-align: right; float: left"></div>
								<div id="mapAltitude"
									style="width: 100px; text-align: right; float: left;"></div>
							</div>

							<div id="utmPanel"
								style="width: 160px; float: right; margin-right: 5px;">
								<div id="mapUtm"
									style="width: 160px; text-align: right; float: left"></div>
							</div>

							<div id="hdmsPanel"	style="width: 200px; float: right; margin-right: 5px;">
								<div id="mapHdmsLat"
									style="width: 100px; text-align: right; float: left;"></div>
								<div id="mapHdmsLon"
									style="width: 100px; text-align: right; float: left;"></div>
							</div>

							<div id="geohashPanel"	style="width: 100px; float: right; margin-right: 5px;">
								<div id="mapGeohash" style="width: 100px; text-align: right; float: left;"></div>
							</div>


							<div id="instPanel"
								style="width: 190px; float: right; margin-right: 15px; display: none;">
								<div id="mapHeading"
									style="width: 60px; text-align: right; float: left;"></div>
								<div id="mapAttRoll"
									style="width: 60px; text-align: right; float: left;"></div>
								<div id="mapAttPitch"
									style="width: 60px; text-align: right; float: left;"></div>
							</div>

						</div>
					</div>


				</div>

			</section>
			<!-- /.content -->
		</div>

		<aside class="control-sidebar control-sidebar-light">

			<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
				<li class="active"><a title="Configurações" href="#control-sidebar-home-tab"
					data-toggle="tab"><i class="fa fa-desktop"></i></a></li>
				<li><a title="Camadas do Sistema" href="#control-sidebar-layers-tab" data-toggle="tab"><i
						class="fa fa-map"></i></a></li>
				 		
				<!-- 		
				<li><a title="Guia Rápido de Funcionalidades" href="#control-sidebar-help-tab" data-toggle="tab"><i
						class="fa fa-info-circle"></i></a></li>
				<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
						class="fa fa-gears"></i></a></li>
				 -->		
			</ul>


			<div class="tab-content">

				<div class="tab-pane active" id="control-sidebar-home-tab">

					<form method="post">
						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir
								Coordenadas Dec <input id="hudCoordenadas" type="checkbox"
								class="pull-right" checked>
							</label>
							<p>Exibe coordenadas decimais na barra inferior da tela.</p>
						</div>
						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir
								Coordenadas UTM <input id="hudUtm" type="checkbox"
								class="pull-right" checked>
							</label>
							<p>Exibe coordenadas UTM na barra inferior da tela.</p>
						</div>
						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir
								Coordenadas GMS <input id="hudHdms" type="checkbox"
								class="pull-right" checked>
							</label>
							<p>Exibe coordenadas no formato GGº MM" SS' na barra inferior
								da tela.</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir
								Altitude <input id="hudAltitude" type="checkbox"
								class="pull-right" checked>
							</label>
							<p>Exibe a altitude do terreno na posição atual do mouse
								(TER) e da "câmera" (CAM) na barra inferior da tela.</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir
								Instrumentos <input id="hudFlight" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe instrumentos de aviação na parte superior da tela.</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir Rosa
								dos Ventos. <input id="hudRosaVentos" checked type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe Rosa dos Ventos</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir Perfil
								de Elevação <input id="hudProfile" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe painel de Perfil de Elevação seguindo o ponteiro do
								mouse.</p>
						</div>
						<!-- /.form-group -->

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir
								Informação do Observador <input id="hudAttitude" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe informações de posicionamento da "câmera" na barra
								inferior da tela.</p>
						</div>
						<!-- /.form-group -->


						<!-- 	
		          <div class="form-group">
		            <label class="control-sidebar-subheading">
		              Delete chat history
		              <a href="javascript:void(0)" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
		            </label>
		          </div>
		         -->
					</form>


				</div>

				<div class="tab-pane" id="control-sidebar-layers-tab">
					<form method="post">

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir camada
								padrão BDGEX <input id="sysLayerNaturalEarth" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe camada básica de cartas do BDGEX.</p>
						</div>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir Curvas
								de Nível <input id="sysLayerCurvas" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe camada de curvas de nível geradas a partir dos
								arquivos SRTM da NASA.</p>
						</div>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir Camada
								RapidEye <input id="sysLayerRapidEye" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe imagens de satélite RapidEye do BDGEX.</p>
						</div>


						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir Relevo
								<input id="sysLayerShades" type="checkbox" class="pull-right">
							</label>
							<p>Exibe sombreamento do relevo (hillshade) gerados a partir
								dos arquivos SRTM da NASA.</p>
						</div>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir
								OpenStreetMap Offline <input id="sysLayerOSM" type="checkbox"
								checked class="pull-right">
							</label>
							<p>Exibe mapa de fundo OpenStreetMap do servidor local. Não
								requer Inernet.</p>
						</div>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir Camada
								OpenSeaMap <input id="sysLayerOpenSeaMap" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe elementos náuticos OpenSeaMap.</p>
						</div>

						<div class="form-group">
							<label class="control-sidebar-subheading"> Exibir Camada
								MarineTraffic <input id="sysLayerMarineTraffic" type="checkbox"
								class="pull-right">
							</label>
							<p>Exibe tráfego marítimo MarineTraffic.</p>
						</div>


					</form>

				</div>

				<div class="tab-pane" id="control-sidebar-help-tab">
				
					<table>
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/visucima.png"></td>
							<td colspan="2">Visualizar de Cima - Permite retornar facilmente para uma visão de cima do mapa com o norte alinhado, levando em consideração o ponto atual de visualização.</td>
						</tr>					
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/voltaini.png"></td>
							<td colspan="2">Voltar ao Início - Centraliza o Mapa na visão inicial do sistema.</td>
						</tr>					
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/barracomp.png"></td>
							<td colspan="2">Barra de Componentes - Exibe ou esconde a barra localizada no canto esquerdo que é responsável por apresentar os componentes e quais estão em uso.</td>
						</tr>					
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/ferramedicao.png"></td>
							<td colspan="2">Ferramenta de Medição - As ferramentas de medição são agrupadas nesta funcionalidade, todas os pontos são posicionados com o botão esquerdo e é utilizado o direito para terminar, sendo as funcionalidades:</td>
						</tr>					

					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/medelinh.png"></td>
							<td>Medição de Linha - Realiza a medição de uma distância com uma linha, podendo inserir vários segmentos.</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/realizmedarea.png"></td>
							<td>Medição de Área - Realiza a medição de uma área com um polígono, podendo inserir quantos vértices forem necessários.</td>
						</tr>					
						
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/ferraanali.png"></td>
							<td colspan="2">Ferramenta de Análise 3D - As ferramentas de análise 3D no mapa são agrupadas nesta funcionalidade, sendo elas:</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/construosm3d.png"></td>
							<td>Construções OSM 3D - Exibe, em áreas selecionadas pelo usuário, as construções 3D vindas do OSM. É recomendando selecionar áreas pequenas de aproximadamente 5km².</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/domterreno.png"></td>
							<td>Domínio de Terreno - Ferramenta voltada para a identificação das áreas vistas e não vistas a partir do ponto de vista do observador.</td>
						</tr>					
						

						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/ferraanali.png"></td>
							<td colspan="2">Ferramenta de Desenho - As ferramentas de desenho são agrupadas nesta funcionalidade, utilizando o botão esquerdo para posicionar e o direito para terminar, sendo:</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/desenlinh.png"></td>
							<td>Desenhar de Linha - Possibilita desenhar uma linha no mapa, clicando com o botão esquerdo do mouse é possível  desenhar pontos entre os segmentos.</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/desenpont.png"></td>
							<td>Desenhar Ponto - Possibilita inserir um ponto no mapa. Ao se inserir um ponto é possível , consultar a aba Desenhos na Barra de Componentes e utilizar a funcionalidade de posicionar um radar no ponto.</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/desenpolin.png"></td>
							<td>Desenhar Polígono 2D - Possibilita desenhar um polígono em 2D no mapa, clicando com o botão esquerdo do mouse é possível  desenhar vértices.</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/desenpolin3d.png"></td>
							<td>Desenhar Polígono 3D - Possibilita desenhar um polígono em 3D no mapa, clicando com o botão esquerdo do mouse é possível  desenhar vértices. Na aba Desenhos na Barra de Componentes é possível  alterar a Altitude (Base) e o Teto.</td>
						</tr>					



						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/salvatela.png"></td>
							<td colspan="2">Salva a tela atual como imagem - Salva uma imagem (png) da tela atual. Consultando a aba de Produtos Exportados na Barra de Componentes é possível Salvar no Servidor e Fazer Download da Imagem.</td>
						</tr>					
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/ferramrota.png"></td>
							<td colspan="2">Ferramenta de Rota - Ferramenta para traçar rotas, podendo também se adicionar bloqueios. Para utilizar a funcionalidade deve clicar com o botão esquerdo e selecionar os pontos de origem e destino. É possível incluir mais de uma origem e/ou destino, traçando assim várias rotas para um mesmo ponto. Para isso é necessário acessar a Barra de Componentes, em seguida a aba Rotas e alterar a rota inicialmente desenhada. Após isso, ficará habilitada a inserção de novos pontos no botão esquerdo do mouse.</td>
						</tr>					
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/interrogar.png"></td>
							<td colspan="2">Interrogar - Ferramenta de interrogação permite interrogar as camadas georreferenciadas.</td>
						</tr>					
						<tr>
							<td style="width:42px"><img src="/resources/img/fastguide/solucionadores.png"></td>
							<td colspan="2">Solucionadores - As funcionalidades especificas para soluções de problemas são agrupadas aqui, sendo:</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/pcnn.png"></td>
							<td>Número de Classificação de Pavimento (PCN) - A funcionalidade permite buscar pistas de pouso  que se enquadrem nos parâmetros de Largura, Comprimento e PCN, informados.</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/metoc.png"></td>
							<td>Climatologia - Apresenta as informações de  Mapas Climatológico do Brasil vindos do INMET.</td>
						</tr>					
						<tr>
							<td style="width:42px">&nbsp;</td>
							<td style="width:42px"><img src="/resources/img/fastguide/plataform.png"></td>
							<td>Área de Segurança de Plataformas - Exibe as localizações das plataformas de petróleo (fixas e moveis) e identificar embarcações que se aproximem da plataforma, em um raio de distância determinada.</td>
						</tr>					


						
								
					
					</table>
					
				</div>

				<div class="tab-pane" id="control-sidebar-settings-tab">
					<ul class="control-sidebar-menu">
						<li><a href="javascript:;">
								<h4 class="control-sidebar-subheading">
									[XYF4A6] - BDGEX <span class="pull-right-container"> <span
										class="label label-danger pull-right">70%</span>
									</span>
								</h4>
								<div class="progress progress-xxs">
									<div class="progress-bar progress-bar-danger"
										style="width: 70%"></div>
								</div>
						</a></li>
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
	
	<!-- 	
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoBuildingsProvider.js" type="text/javascript"></script>
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoPointCloudProvider.js" type="text/javascript"></script>
	 -->
	<script src="${midasLocation}/atlas/resources/js/providers/MagnoMarineTrafficProvider.js" type="text/javascript"></script>
	
	<script src="${midasLocation}/atlas/resources/js/geohash.js" type="text/javascript"></script>
	
</body>

</html>


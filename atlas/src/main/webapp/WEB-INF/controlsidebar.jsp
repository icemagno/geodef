<aside class="control-sidebar control-sidebar-light">
	<div class="tab-content">
	
	<div class="tab-content">
		<form method="post">
		
			<div class="form-group">
				<label class="control-sidebar-subheading"> Camada de Base</label>
				<div class="box-body">
					<div style="padding: 2px;" class="col-sm-12">
						<div class="row">
							<div class="col-sm-6" style="padding:0px">
								<div style="position:relative;margin: 2px;">
									<input style="cursor:pointer;position: absolute;top:2px;right:2px" type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
									<img title="OSM-DEFESA"  class="img-responsive basemapimg" src="${midasLocation}/atlas/basemaps/bg_osm.jpg" alt="Photo">
								</div>
								<div style="position:relative;margin: 2px;">
									<input style="cursor:pointer;position: absolute;top:2px;right:2px" type="radio" name="optionsRadios" id="optionsRadios2" value="option1">
									<img title="Carta Mosaico BDGEX" class="img-responsive basemapimg" src="${midasLocation}/atlas/basemaps/bg_mosaico.jpg" alt="Photo">
								</div>
								<div style="position:relative;margin: 2px;">
									<input style="cursor:pointer;position: absolute;top:2px;right:2px" type="radio" name="optionsRadios" id="optionsRadios5" value="option1">
									<img title="GEBCO Leito Marinho" class="img-responsive basemapimg" src="${midasLocation}/atlas/basemaps/bg_gebco.jpg" alt="Photo">
								</div>
							</div>
							<div class="col-sm-6" style="padding:0px">
								<div style="position:relative;margin: 2px;">
									<input style="cursor:pointer;position: absolute;top:2px;right:2px" type="radio" name="optionsRadios" id="optionsRadios3" value="option1">
									<img title="RapidEye BDGEX" class="img-responsive basemapimg" src="${midasLocation}/atlas/basemaps/bg_rapideye.jpg" alt="Photo">
								</div>
								<div style="position:relative;margin: 2px;">
									<input style="cursor:pointer;position: absolute;top:2px;right:2px" type="radio" name="optionsRadios" id="optionsRadios4" value="option1">
									<img title="Ortoimagens BDGEX" class="img-responsive basemapimg" src="${midasLocation}/atlas/basemaps/bg_bdgex_orto.jpg" alt="Photo">
								</div>
								<div style="position:relative;margin: 2px;">
									<!-- 
									<input style="cursor:pointer;position: absolute;top:2px;right:2px" type="radio" name="optionsRadios" id="optionsRadios6" value="option1">
									 -->
									<img class="img-responsive basemapimg" src="${midasLocation}/atlas/basemaps/bg_white.jpg" alt="Photo">
								</div>
							</div>
						</div>
						<div  title="Opacidade da Camada Base"  class="row" style="margin-left: -5px;">
							<input id="mainLayerSlider" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100" 
								data-slider-tooltip="hide" data-slider-step="5" data-slider-value="100" data-slider-id="blue">
						</div>
					</div>
				</div>
			</div>
			
			
			<div class="form-group">
				<label class="control-sidebar-subheading"> Configurações </label>
				<div class="box-body" style="background-color: #3c8dbc;">
					<table id="configTable" style="width:100%">
						<tr>
							<td>
								<button title="Grid Geográfico" id="optGG" type="button" class="configBtn btn btn-primary disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/grid.png" style="width: 35px; height: 35px;">
								</button>
							</td>
							<td style="text-align: right;">
								<button title="Mapa de Situação" id="opMap" type="button" class="configBtn  btn btn-primary disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/mini_mapa.png" style="width: 35px; height: 35px;">
								</button>
							</td>
						</tr>
						<tr>
							<td>
								<button title="Escala" id="optLeg" type="button" class="configBtn btn btn-primary disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/escala.png" style="width: 35px; height: 35px;">
								</button>
								<!-- 
								<button title="Legenda" id="optLeg" type="button" class="configBtn btn btn-primary disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/legenda2.png" style="width: 35px; height: 35px;">
								</button>
								-->
							</td>
							<td style="text-align: right;">
								<button title="Instrumentos de Aviação" id="optIns" type="button" class="configBtn  btn btn-primary disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/instrumentos.png" style="width: 35px; height: 35px;">
								</button>
							</td>
						</tr>
						<tr>
							<td>
								<button title="Modo Offline" id="optOff" type="button" class="configBtn btn btn-primary disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/offline.png" style="width: 35px; height: 35px;">
								</button>
							</td>
							<td style="text-align: right;">
								<button title="Rosa dos Ventos" id="optAvi" type="button" class="configBtn  btn btn-primary btn-flat disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/rosa.png" style="width: 35px; height: 35px;">
								</button>
								<!-- 
								<button title="Avisos" id="optAvi" type="button" class="configBtn  btn btn-primary btn-flat disabled" style="padding: 0px;">
									<img src="${midasLocation}/atlas/icons/avisos.png" style="width: 35px; height: 35px;">
								</button>
								 -->
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			
		</form>
		
		
	</div>
	
		
	</div>
</aside>
<!-- Add the sidebar's background. This div must be placed
      immediately after the control sidebar -->
<div class="control-sidebar-bg" ></div>


		
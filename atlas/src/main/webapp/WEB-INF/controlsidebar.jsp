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
									<input style="cursor:pointer;position: absolute;top:2px;right:2px" type="radio" name="optionsRadios" id="optionsRadios6" value="option1">
									<img title="Nenhuma" class="img-responsive basemapimg" src="${midasLocation}/atlas/basemaps/bg_white.jpg" alt="Photo">
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
				<label class="control-sidebar-subheading"> Configura��es </label>
				<div class="box-body">
					<table id="configTable">
						<tr><td><img src="${midasLocation}/atlas/icons/grid.png"></td><td><img src="${midasLocation}/atlas/icons/mini_mapa.png"></td></tr>
						<tr><td><img src="${midasLocation}/atlas/icons/legenda2.png"></td><td><img src="${midasLocation}/atlas/icons/instrumentos.png"></td></tr>
						<tr><td><img src="${midasLocation}/atlas/icons/offline.png"></td><td><img src="${midasLocation}/atlas/icons/avisos.png"></td></tr>
					</table>
				</div>
			</div>
			
			
		</form>
		
		
	</div>
	
		
	</div>
</aside>
<!-- Add the sidebar's background. This div must be placed
      immediately after the control sidebar -->
<div class="control-sidebar-bg"></div>


		
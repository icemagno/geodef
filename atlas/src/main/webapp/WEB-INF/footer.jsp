<%@ page pageEncoding="UTF-8" %>


<footer class="main-footer" style="height:44px;padding: 0px 10px 0px 10px;">
	<table id="tableFooter" style="width:100%;">
		<tr>
			<td>
				<div class="layerCounter" id="layerLoadingPanelGau" style="width: 120px;float:left;margin-left: 20px;margin-right:5px;padding-top:3px;display:none;">
					<div class='progress progress-sm active'>
						<div class='progress-bar progress-bar-red progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'></div>
					</div>
				</div>
				<div class="layerCounter" id="layerLoadingPanelCnt" style="width: 20px; float: left;display:none;">
					<div id="lyrCount" style="width: 50px; float: left">0</div>
				</div>
			</td>
			<td id="vpW">&nbsp;</td>
			<td id="vpN">&nbsp;</td>
			<td id="mapUtm"></td>
			<td id="mapHei"></td>
			<td id="mapLat"></td>
			<td id="mapHdmsLat"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td id="vpS">&nbsp;</td>
			<td id="vpE">&nbsp;</td>
			<td id="mapGeohash"></td>
			<td id="mapAltitude"></td>
			<td id="mapLon"></td>
			<td id="mapHdmsLon"></td>
		</tr>
	</table>
</footer>	

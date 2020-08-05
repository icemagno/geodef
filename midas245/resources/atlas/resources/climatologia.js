var frameBuffer = [];
var intervalClock = null;
var currentFrame = null;
var months = ["Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"];

var startMonth = 0;
var endMonth = 11;
var currentMonth = 0;
var animating = false;

var defaultAlpha = 0.4;
var speed = 900; 

function reset(){
	jQuery("#monthControlSlider").slider('refresh');
	jQuery("#climatoSlider").slider('refresh');
	defaultAlpha = 0.4;
	currentMonth = 0;
	startMonth = 0;
	endMonth = 11;
	for( x=0; x<frameBuffer.length;x++ ) {
		viewer.entities.remove( frameBuffer[ x ].entity );
	}
	frameBuffer = [];
	jQuery("#climatoMonth").text( months[currentMonth] );
	jQuery("#monthControlStart").text( months[startMonth] );
	jQuery("#monthControlEnd").text( months[endMonth] );
}

jQuery("#monthControlSlider").slider({});
jQuery("#climatoSlider").slider({});
jQuery("#monthControlSlider").on("slide", function(slideEvt) {
	startMonth = slideEvt.value[0];
	endMonth = slideEvt.value[1];
	jQuery("#monthControlStart").text( months[startMonth] );
	jQuery("#monthControlEnd").text( months[endMonth] );
});

jQuery("#climatoSlider").on("slide", function(slideEvt) {
	var valu = slideEvt.value / 100;
	defaultAlpha = valu;
	if( !animating ) {
		currentFrame = frameBuffer[ currentMonth ];
		currentFrame.entity.rectangle.material.color = Cesium.Color.WHITE.withAlpha( defaultAlpha );
	}
	
});	

function deleteClimato( uuid ) {
	jQuery("#" + uuid).fadeOut(400, function(){
		jQuery("#" + uuid).remove();
		var count = jQuery('#climatoInmetContainer').children().length -1;
		if ( count === 0 ) { 
			jQuery("#climatoInmetCounter").html( '' );
			stop();
			reset();
			jQuery("#climatoControlButtons").hide();
		} else { jQuery("#climatoInmetCounter").html( count ); }
	});
}

function addClimatoToPanel(  climatoData  ) {
	var uuid = climatoData.uuid;
	var varMeteorologica = climatoData.varMeteorologica;
	var perHisText = climatoData.perHisText;
	var varMetText = climatoData.varMetText;
	
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable"><i class="fa fa-soundcloud"></i> &nbsp; <b>' + varMetText + '</b>' +
	'<a title="Apagar Camada" href="#" onClick="deleteClimato(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'</td></tr>'; 

	var legenda = "<img style='width:100%;height:65%' src='/resources/data/climatologia/" + varMeteorologica + "-leg.png'>";
	table = table + '<tr><td colspan="2" class="layerTable">Período</td><td class="layerTable" style="text-align:right" >'+perHisText+'</td></tr>';
	table = table + '<tr><td colspan="3" class="layerTable" style="position: relative;">'+ legenda +'</td></tr>';
	table = table + '</table></div>';
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#climatoInmetContainer").append( layerText );
	var count = jQuery('#climatoInmetContainer').children().length -1;
	jQuery("#climatoInmetCounter").html( count );	
	jQuery("#layerContainer").show( "slow" );
	
	jQuery("#climatoControlButtons").show( "slow" );
	
}

function flipImage() {
	var oldFrame = currentFrame; 
	currentFrame = frameBuffer[ currentMonth ];
	currentFrame.entity.rectangle.material.color = Cesium.Color.WHITE.withAlpha( defaultAlpha );
	currentFrame.entity.show = true;
	oldFrame.entity.show = false;
	oldFrame = null;
	jQuery("#climatoMonth").text( months[currentMonth] );
}


function start(){
	if( animating ) return;
	animating = true;
	intervalClock = setInterval(function(){ 
		toNextFrame();
	}, speed);		
}
function toFirstFrame() {
	currentMonth = startMonth;
	flipImage();	
}
function toPreviousFrame() {
	currentMonth--;
	if( currentMonth < startMonth ) currentMonth = endMonth;
	flipImage();
}
function stop() {
	animating = false;
	clearInterval( intervalClock );
}
function toNextFrame() {
	currentMonth++;
	if( currentMonth > endMonth ) currentMonth = startMonth;
	flipImage();
}
function toLastFrame() {
	currentMonth = endMonth;
	flipImage();	
}



function loadClimato() {
	var varMeteorologica = jQuery("#varMeteorologica").val();
	var periodoHistorico = jQuery("#periodoHistorico").val();	
	
	
	var varMetText = jQuery('#varMeteorologica option:selected').text();
	var perHisText = jQuery('#periodoHistorico option:selected').text();
	
	if ( varMeteorologica === 'NULL' ) return; 
	
	var fileKmz = varMeteorologica + "-" + periodoHistorico + ".kmz";
	var kmlPromise = Cesium.KmlDataSource.load('/resources/data/climatologia/' + fileKmz, { camera: viewer.scene.camera, canvas: viewer.scene.canvas });
	kmlPromise.then(function(dataSource) {
		var climatoData = {};
		climatoData.uuid = createUUID();
		climatoData.varMeteorologica = varMeteorologica;
		climatoData.periodoHistorico = periodoHistorico;
		climatoData.varMetText = varMetText;
		climatoData.perHisText = perHisText;
		
		var entities = dataSource.entities.values;
		for (var i = 0; i < entities.length; i++) {
			var entity = entities[i];
			if( entity.rectangle ) {
				
				var theEntity = viewer.entities.add({
					show : false,
				    rectangle: {
				        coordinates: entity.rectangle.coordinates,
				        material: new Cesium.ImageMaterialProperty({
				            image: entity.rectangle.material.image,
				            color: Cesium.Color.WHITE.withAlpha( defaultAlpha )
				        }),
				    }
				});				
				var precImg = {};
				precImg.climatoData = climatoData;
				precImg.entity = theEntity;
				
				frameBuffer.push( precImg );
			}
		}
		addClimatoToPanel( climatoData );
		
		currentFrame = frameBuffer[ currentMonth ];
		currentFrame.entity.show = true;
		jQuery("#climatoMonth").text( months[currentMonth] );
		
	});
	
}


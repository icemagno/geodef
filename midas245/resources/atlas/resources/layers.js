var layerStack = [];
var searchedLayersResult = [];
var stackedProviders = [];
var baseLayer = null;	

var queryLayerEventHandler = null;
var isQuerying = false;

var drawedEditableFeatures = [];

var bdgexCartasImageryProvider = null;
var rapidEyeImagery = null;
var contourLines = null;
var contourShade = null;
var openseamap = null;
var cartasCHM = null;
var metocLayer = null;
var marinetraffic = null;

function getFeatureById( uuid ){
	for( var x=0; x < drawedEditableFeatures.length; x++ ) {
		if( drawedEditableFeatures[x].uuid === uuid ) return drawedEditableFeatures[x]; 
	}
	return null;
}

function updateLayersOrder( event, ui ){
	
	var uuid = ui.item[0].id;
	var newLayerIndex = ui.item.index() + 2;  // 0=Camada Base // 1=Grid Coordenadas // 2 > Camadas do usuário...
	var layer = getLayerByUUID( uuid );
	if( !layer ) return;
	var currentLayerIndex = viewer.imageryLayers.indexOf( layer );
	
	if( newLayerIndex < currentLayerIndex ){
		var steps = currentLayerIndex - newLayerIndex;
		for( x=0; x<steps; x++){
			viewer.imageryLayers.lower(layer);
		}
	}
	if( newLayerIndex > currentLayerIndex ){
		var steps = newLayerIndex - currentLayerIndex;
		for( x=0; x<steps; x++){
			viewer.imageryLayers.raise(layer);
		}
	}
	
	var targetLayerIndex = viewer.imageryLayers.indexOf( layer );
}

function expandCard(uuid){
	var idX = "#expd_" + uuid;
	var idC = "#cops_" + uuid;
	$( idX ).hide();
	$( idC ).show();
	$("#" + uuid).css( 'height', 300 );
}

function collapseCard( uuid ){
	var idX = "#expd_" + uuid;
	var idC = "#cops_" + uuid;
	$( idC ).hide();
	$( idX ).show();
	$("#" + uuid).css( 'height', 70 );
}


function hideLayer( uuid ){
	var idH = "#hdlay_" + uuid;
	var idS = "#swlay_" + uuid;
	$( idH ).hide();
	$( idS ).show();
	doHideLayer( uuid );
}

function showLayer( uuid ){
	var idH = "#hdlay_" + uuid;
	var idS = "#swlay_" + uuid;
	$( idS ).hide();
	$( idH ).show();
	doShowLayer( uuid, 1 );
}

function doShowLayer( uuid ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid === uuid ) {
			sp.layer.show = true;
		}
	}
}


function getLayerDataByUUID( uuid ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid === uuid ) {
			return sp.data;
		}
	}
	return null;
}


function getLayerByUUID( uuid ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid === uuid ) {
			return sp.layer;
		}
	}
	return null;
}

function getLayerByKey( key ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		var layerKey = sp.data.uniqueKey;
		if( layerKey === key ) {
			return sp;
		}
	}
	return null;
}


function doHideLayer( uuid ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid == uuid ) {
			sp.layer.show = false;
		}
	}
}

function doSlider( uuid, value ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid == uuid ) {
			sp.layer.alpha = value;
		}
	}
}


function getAFeatureCard( data, defaultImage ){
	var layerAlias = "Feição";
	var uuid = data.uuid;
	
	var legendSymbol = "<div style='float: left; width:15px; height:15px; border:1px solid #d2d6de; background-color: "+data.attributes.color.css+"'>&nbsp;</div>";
	var legendText = "<div style='margin-left: 5px;float: left; width:250px; height:20px;font-size: 12px;'>Feição do usuário</div>";
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>'+layerAlias+'</b>'+
	
	'<div class="box-tools pull-right">'+                           
		'<button id="hdlay_'+uuid+'" onClick="hideFeature(\''+uuid+'\');" title="Ocultar Camada" type="button" style="padding: 0px;margin-right:15px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-eye"></i></button>'+
		'<button id="swlay_'+uuid+'" onClick="showFeature(\''+uuid+'\');" title="Exibir Camada" type="button" style="display:none;padding: 0px;margin-right:15px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-eye-slash"></i></button>'+
		'<button id="expd_'+uuid+'" onClick="expandCard(\''+uuid+'\');" title="Expandir" type="button" style="padding: 0px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-caret-right"></i></button>'+
		'<button id="cops_'+uuid+'"onClick="collapseCard(\''+uuid+'\');" title="Recolher" type="button" style="display:none;padding: 0px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-caret-down"></i></button>'+
	'</div>' +	
	
	'</td></tr>'; 
	table = table + '<tr><td colspan="2" style="width: 80%;">'; 
	table = table + '<input id="SL_'+uuid+'" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100" ' +
		'data-slider-tooltip="hide" data-slider-step="5" data-slider-value="100" data-slider-id="blue">';
	table = table + '</td><td style="width:20%" >' + 
	'<a title="Excluir Camada" href="#" onClick="deleteFeature(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'<a title="Editar Camada" style="margin-right: 10px;" href="#" onClick="editFeature(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-pencil-square-o"></i></a>' + 
	'<a title="RF-ZZZ" style="display:none;margin-right: 10px;" href="#" onClick="layerToDown(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-gear"></i></a>' + 
	'<a title="RF-WWW" style="display:none;margin-right: 10px;" href="#" onClick="exportLayerToPDF(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-search-plus"></i></a>' + 
	'</td></tr>';
	table = table + '</table></div>';
	var layerText = '<div class="sortable" id="'+uuid+'" style="overflow:hidden;height:70px;background-color:white; margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div>' + 
	'<div style="height: 200px;" class="box-footer feature-legend" id="LEG_'+uuid+'">'+legendSymbol + legendText + '</div>' + 
	'</div>';
	return layerText;
}

function editFeature( uuid ){
	console.log('Editar feature');
}

function deleteFeature( uuid ){
	for( var x=0; x < drawedEditableFeatures.length; x++ ) {
		var featureData = drawedEditableFeatures[x];
		if( featureData.uuid === uuid ){
			if( featureData.type === 'POINT' ){ 
				drawedFeaturesBillboards.remove( featureData.feature );
			} else {
				featureData.feature.setEditMode( false );
				scene.groundPrimitives.remove( featureData.feature );
			}
			
			drawedEditableFeatures.splice(x, 1);
			$("#" + uuid).fadeOut(400, function(){
				$("#" + uuid).remove();
			});
			return;
		}
		
	}
}

function showFeature( uuid ){
	var featureData = getFeatureById( uuid );
	var idH = "#hdlay_" + uuid;
	var idS = "#swlay_" + uuid;
	if( featureData ){
		$( idH ).show();
		$( idS ).hide();
		featureData.feature.show = true;
	}
}

function hideFeature( uuid ){
	var featureData = getFeatureById( uuid );
	var idH = "#hdlay_" + uuid;
	var idS = "#swlay_" + uuid;
	if( featureData ){
		$( idH ).hide();
		$( idS ).show();
		if( featureData.type != 'POINT' ) featureData.feature.setEditMode( false );
		featureData.feature.show = false;
	}
}

function getALayerCard( uuid, layerAlias, defaultImage  ){
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>'+layerAlias+'</b>'+
	
	'<div class="box-tools pull-right">'+                           
		'<button id="hdlay_'+uuid+'" onClick="hideLayer(\''+uuid+'\');" title="Ocultar Camada" type="button" style="padding: 0px;margin-right:15px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-eye"></i></button>'+
		'<button id="swlay_'+uuid+'" onClick="showLayer(\''+uuid+'\');" title="Exibir Camada" type="button" style="display:none;padding: 0px;margin-right:15px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-eye-slash"></i></button>'+
		'<button id="expd_'+uuid+'" onClick="expandCard(\''+uuid+'\');" title="Expandir" type="button" style="padding: 0px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-caret-right"></i></button>'+
		'<button id="cops_'+uuid+'"onClick="collapseCard(\''+uuid+'\');" title="Recolher" type="button" style="display:none;padding: 0px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-caret-down"></i></button>'+
	'</div>' +	
	
	'</td></tr>'; 
	table = table + '<tr><td colspan="2" style="width: 100%;">'; 
	table = table + '<input id="SL_'+uuid+'" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100" ' +
		'data-slider-tooltip="hide" data-slider-step="5" data-slider-value="100" data-slider-id="blue">';
	table = table + '</td><td style="width:7%" >' + 
	'<a title="Excluir Camada" href="#" onClick="deleteLayer(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'<a title="RF-YYY" style="display:none;margin-right: 10px;" href="#" onClick="importVectors(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-floppy-o"></i></a>' + 
	'<a title="RF-ZZZ" style="display:none;margin-right: 10px;" href="#" onClick="layerToDown(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-gear"></i></a>' + 
	'<a title="RF-WWW" style="display:none;margin-right: 10px;" href="#" onClick="exportLayerToPDF(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-search-plus"></i></a>' + 
	'</td></tr>';
	table = table + '</table></div>';
	var layerText = '<div class="sortable" id="'+uuid+'" style="overflow:hidden;height:70px;background-color:white; margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div><div class="box-footer" id="LEG_'+uuid+'"></div></div>';
	return layerText;
}

/*
function getALayerGroup( uuid, groupName, defaultImage ){
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>'+groupName+'</b></td></tr>'; 
	table = table + '<tr><td colspan="3" id="GRPCNT_'+uuid+'"></td></tr>';
	table = table + '</table></div>';
	var layerText = '<div class="sortable" id="'+uuid+'" style="background-color:white; margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';
	return layerText;
}
*/


function importVectors( uuid ){
	// Importa para o BD os vetores do geoserver desta camada
	console.log('Voce nao esta preparado pra isso ainda.');
	return;
	/*
	var data = getLayerDataByUUID( uuid );
    var cpf = mainConfiguration.user.cpf;
	jQuery.ajax({
		url: "/proxy/getfeature?userId=" + cpf + "&sourceId=" + data.id + '&bw='+globalScreenViewport.bWest+
			'&bs='+globalScreenViewport.bSouth+'&be='+globalScreenViewport.bEast+'&bn='+globalScreenViewport.bNorth,
		type: "GET", 
		success: function( imagePath ) {
			//
		}
	});
	*/
}



function updateLegendImages(){
	for( x=0; x<stackedProviders.length;x++ ){
		var sp = stackedProviders[x];
		var data = sp.data;
		if( data ){
			var uuid = sp.uuid;
			var imgUUID = "IMG_" + uuid;
			var legendUrl = "/proxy/getlegend?uuid=" + uuid + "&sourceId=" + data.id + '&bw='+globalScreenViewport.bWest +
				'&bs='+globalScreenViewport.bSouth+'&be='+globalScreenViewport.bEast+'&bn='+globalScreenViewport.bNorth;
			
			console.log( legendUrl );

			jQuery.ajax({
				url: legendUrl,
				type: "GET", 
				success: function( imagePath ) {
					if( imagePath != '' ){
						$( "#" + imgUUID ).attr("src", imagePath );
					} else {
						console.log('Sem legenda.');
					}
				}
			});
		}
	}
}






function addFeatureCard( data ){
	var uuid = data.uuid;
	// Adiciona o Card
    var defaultImage = "<img title='Alterar Ordem' style='cursor:move;border:1px solid #cacaca;width:19px;' src='/resources/img/drag.png'>";
    var layerText = getAFeatureCard( data, defaultImage );
    $("#activeLayerContainer").append( layerText );

    
	$("#SL_"+uuid).bootstrapSlider({});
	$("#SL_"+uuid).on("slide", function(slideEvt) {
		var valu = slideEvt.value / 100;
		var tUuid = this.id.substr(3);
		var featureData = getFeatureById( tUuid );
		if( featureData ){
			if( featureData.type === 'POINT' ) {
				featureData.feature.color = featureData.feature.color.withAlpha( valu );
			} else {
				featureData.feature.setEditMode( false );
				featureData.feature.material.uniforms.color.alpha = valu;
			}
			
		}		
		
	});	
    
    var id = "LEG_"+uuid;
	html2canvas( document.getElementById( id ), { height:'400' } ).then(function(canvas) {
		var dataURL = canvas.toDataURL();
		jQuery.ajax({
			type: "POST",
			url: "/savelegend", 
			data: {'imgBase64': dataURL, 'id' : uuid },
			success: function( url ) {
				data.attributes.legendUrl = url;
			}
		});
	});		
	
	fireToast( 'info', 'Concluído', 'A camada foi adicionada ao seu projeto.' , '000' );
}

function addLayerCard( data ){
	var uuid = "L-" + createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.data = data;
	
	var key = data.sourceAddress + data.sourceLayer;
	if( getLayerByKey( key ) != null ) {
		fireToast( 'info', 'Camada Já Criada', 'A camada ' + data.sourceName + ' já está criada.' , '000' );
		return;
	}
	
	data.uniqueKey = key;
	
	var provider = getProvider( data.sourceAddress, data.sourceLayer, false, 'png', true );
	if( provider ){
		theProvider.layer = viewer.imageryLayers.addImageryProvider( provider );
		
		var props = { 'uuid':uuid  }
		theProvider.layer.properties = props; 
		theProvider.data = data;

		stackedProviders.push( theProvider );		

		// Adiciona o Card
	    var defaultImage = "<img title='Alterar Ordem' style='cursor:move;border:1px solid #cacaca;width:19px;' src='/resources/img/drag.png'>";
		var layerText = getALayerCard( uuid, data.sourceName, defaultImage );
		$("#activeLayerContainer").append( layerText );
		
		$("#SL_"+uuid).bootstrapSlider({});
		$("#SL_"+uuid).on("slide", function(slideEvt) {
			var valu = slideEvt.value / 100;
			doSlider( this.id.substr(3), valu );
		});	

		// Legenda
		var legUUID = "LEG_" + uuid;
		var imgUUID = "IMG_" + uuid;
		
		var urlLeg = "/proxy/getlegend?uuid=" + uuid + "&sourceId=" + data.id + '&bw='+globalScreenViewport.bWest+
				'&bs='+globalScreenViewport.bSouth+'&be='+globalScreenViewport.bEast+'&bn='+globalScreenViewport.bNorth;
			
		jQuery.ajax({
			url: urlLeg,
			type: "GET", 
			success: function( imagePath ) {
				if( imagePath != '' ){
					var n = new Date().getTime();					
					$( "#" + legUUID ).html( "<img class='legendImage' id='"+imgUUID+"' src='" + imagePath + "'>" );
					$( "#" + legUUID ).slimScroll({
				        height: '205px',
				        wheelStep : 10,
				    });
				} else {
					console.log('Sem legenda.');
				}
			}
		});
		
		$('#activeLayerContainer').slimScroll();
		
		fireToast( 'info', 'Concluído', 'A camada foi adicionada ao seu projeto.' , '000' );

	}	

}

function updateCheckBox( param, enabled ){
	$("#chk" + param ).prop( "checked", enabled );
}

function deleteLayer( uuid ) {
	for( x=0; x < stackedProviders.length;x++ ) {
		var ll = stackedProviders[x];
		if ( ll.uuid == uuid ) {
			if( ll.data.param ) updateCheckBox( ll.data.param, false );  
			if( viewer.imageryLayers.remove( ll.layer, true ) ){
				stackedProviders.splice(x, 1);
				jQuery("#" + uuid).fadeOut(400, function(){
					jQuery("#" + uuid).remove();
				});
			} else {
				// um toast?
			}
			return;
		}
	}
}

function getProvider(  sourceUrl, sourceLayers, canQuery, imageType, isTransparent, time ) {
	if( !imageType ) imageType = 'png8';	
	var provider = getBaseImageryProvider( sourceUrl, sourceLayers, canQuery, currentBaseLayerAlphaValue, imageType, isTransparent, time );
	return provider;
}

function getBaseImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType, isTransparent, time ) {

	var imageryProvider = new Cesium.WebMapServiceImageryProvider({ 
		url : sourceUrl, 
		layers : sourceLayers,
		tileWidth: 256,
		tileHeight: 256,		
		enablePickFeatures : canQuery,
		parameters : { 
			version: '1.1.0',
			transparent : isTransparent,
			srs	: 'EPSG:4326',
			format : 'image/' + imageType, 
			tiled : true
		}
	});	
	imageryProvider.defaultAlpha = transparency;
	return imageryProvider;
}


function queryLayer() {
	if( isQuerying ){
		isQuerying = false;
		queryLayerEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_CLICK);
		viewer._container.style.cursor = "default";
		$("#showToolQuery").addClass("btn-primary");
		$("#showToolQuery").removeClass("btn-danger");
		
	} else {
		isQuerying = true;
		viewer._container.style.cursor = "help";

		$("#showToolQuery").removeClass("btn-primary");
		$("#showToolQuery").addClass("btn-danger");
		
		queryLayerEventHandler.setInputAction( function( click ) {

			var position = getMapPosition3D2D( click.position );
			cartographic = Cesium.Ellipsoid.WGS84.cartesianToCartographic( position );
			var longitudeString = Cesium.Math.toDegrees(cartographic.longitude).toFixed(10);
			var latitudeString = Cesium.Math.toDegrees(cartographic.latitude).toFixed(10);    	    
			
			showQueryResultContainer( )
			
			for( x=0; x<stackedProviders.length;x++ ) {
				var sp = stackedProviders[x];
				var queryUrl = "/proxy/getfeatureinfo?layerId=" + sp.data.id + "&lat=" + latitudeString + '&lon='+longitudeString;

				jQuery.ajax({
					url: queryUrl,
					type: "GET",
					stackedProvider : stackedProviders[x],
					success: function( featureCollection ) {
						showFeaturesData( JSON.parse(featureCollection), this.stackedProvider );
					}
				});
			}
			
			
			// Objetos
			var pickedObject = viewer.scene.pick( click.position );
		    if ( Cesium.defined( pickedObject ) ) {
		    	var entity = pickedObject.id;
		    	if( entity ){
		    		console.log("QUERY ENTITY: " + entity.name );
		    	}
		    	
		    	/*
		    	if ( entity.name === 'ROTA_POI') showRotaPoi( entity );
		    	if ( entity.name === 'PHOTO_HASTE') showStreetImage( entity );
		    	if ( entity.name === "PCN_RUNWAY") showRunwayInfo( entity );
		    	if ( entity.name === "CORMET_AERODROMO") showColorAerodromo( entity );
		    	if ( entity.name === "MUNICIPIO_PREVISAO") showPrevisaoMunicipio( entity );
		    	if ( entity.name === "AERODROMO_METOC") showMetarAerodromo( entity );
		    	*/
		    	
		    } else {
		    	console.log('Nenhuma entidade clicada.');
		    }
		}, Cesium.ScreenSpaceEventType.LEFT_CLICK);
	
	}	
}



// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

function createImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType ) {

	var imageryProvider = new Cesium.WebMapServiceImageryProvider({ 
		url : sourceUrl, 
		layers : sourceLayers,
		tileWidth: 256,
		tileHeight: 256,		
		enablePickFeatures : canQuery,
		parameters : { 
			transparent : false,
			srs	: 'EPSG:4326',
			format : 'image/' + imageType, 
			tiled : true 
		}
	});	
	imageryProvider.defaultAlpha = transparency;
	return imageryProvider;
}

function createFilteredImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType, filter ) {

	var imageryProvider = new Cesium.WebMapServiceImageryProvider({ 
		url : sourceUrl, 
		layers : sourceLayers,
		tileWidth: 256,
		tileHeight: 256,		
		enablePickFeatures : canQuery,
		parameters : { 
			transparent : true,
			srs	: 'EPSG:4326',
			format : 'image/' + imageType, 
			tiled : true, 
			cql_filter : filter
		}
	});	
	imageryProvider.defaultAlpha = transparency;

	return imageryProvider;
}


function addLayerWithFilter( layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType, filter ) {
	if( !imageType ) imageType = 'png8';	
	var layer = {};
	var provider = createFilteredImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType, filter );
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	return layer.imageryLayer;
}


function addWMTSLayer( layerName, sourceUrl, sourceLayers, transparency, time ) {
	var layer = {};
	
	var times = Cesium.TimeIntervalCollection.fromIso8601({
	    iso8601: '2019-11-20/2019-11-20/P1D',
	    dataCallback: function dataCallback(interval, index) {
	        return {
	            Time: Cesium.JulianDate.toIso8601(interval.start)
	        };
	    }
	});	
	
	var provider = new Cesium.WebMapTileServiceImageryProvider({ 
	    url : 'https://map1a.vis.earthdata.nasa.gov/wmts-geo/wmts.cgi?time=2019-11-20',
	    layer : 'VIIRS_SNPP_CorrectedReflectance_BandsM11-I2-I1',
	    style : 'default',
	    //times : times,
	    //clock : viewer.clock,
	    format : 'image/jpeg',
	    tileMatrixSetID : 'EPSG4326_250m',
	});

	/*
	provider.readyPromise.then(function() {
        var start = Cesium.JulianDate.fromIso8601('2015-07-30');
        var stop = Cesium.JulianDate.fromIso8601('2017-06-17');
        viewer.timeline.zoomTo(start, stop);
        var clock = viewer.clock;
        clock.startTime = start;
        clock.stopTime = stop;
        clock.currentTime = start;
        clock.clockRange = Cesium.ClockRange.LOOP_STOP;
        clock.multiplier = 86400;
    });
    */	
	
	
	provider.defaultAlpha = transparency;
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	layer.imageryLayer.brightness = 5.0;
	layer.imageryLayer.alpha = transparency;
	return layer.imageryLayer;
}


// https://wms.hycom.org/thredds/wms/GLBy0.08/latest?service=WMS&version=1.3.0&request=GetCapabilities
// https://wms.hycom.org/thredds/wms/GLBy0.08/latest?LAYERS=sea_water_velocity&ELEVATION=-15&TIME=2019-10-25T12%3A00%3A00.000Z&TRANSPARENT=true&STYLES=vector%2Frainbow&COLORSCALERANGE=-50%2C50&NUMCOLORBANDS=20&LOGSCALE=false&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&FORMAT=image%2Fpng&SRS=EPSG%3A4326&BBOX=-44.472656250001,-27.564697265625,-36.035156250001,-20.972900390625&WIDTH=768&HEIGHT=600
// https://wms.hycom.org/thredds/wms/GLBy0.08/latest/?transparent=true&width=256&height=256&elevation=-15&time=2019-10-25T12%3A00%3A00.000Z&srs=EPSG%3A4326&styles=vector%2Frainbow&colorscalerange=0.004%2C0.8193&format=image%2Fpng&tiled=true&numcolorbands=20&logscale=false&service=WMS&version=1.1.1&request=GetMap&layers=sea_water_velocity&bbox=-47.81249999999999%2C-22.5%2C-45%2C-19.687499999999996
function addMetocLayer( layerName, sourceUrl, sourceLayers, transparency, time ) {
	console.log( sourceUrl );
	var layer = {};
	// http://sisgeodef.defesa.mil.br:36485/thredds/wms/testAll/best_chuva.nc?
	// LAYERS=Precipitation_rate_surface&
	// ELEVATION=0&
	// TIME=2019-09-26T00:00:00.000Z&
	// TRANSPARENT=true&
	// STYLES=boxfill/rainbow&
	// COLORSCALERANGE=0,0.0038&
	// NUMCOLORBANDS=20&
	// LOGSCALE=false&
	// SERVICE=WMS&
	// VERSION=1.1.1&
	// REQUEST=GetMap&
	// FORMAT=image/png&
	// SRS=EPSG:4326&
	// BBOX=-33.75,-11.25,-22.5,0&
	// WIDTH=256&HEIGHT=256
	var provider = new Cesium.WebMapServiceImageryProvider({ 
		url : sourceUrl, 
		layers : sourceLayers,
		enablePickFeatures : false,
		parameters : { 
			transparent : true,
			//WIDTH:256,
			//HEIGHT:256,
			ELEVATION:0,
			time : time,
			srs	: 'EPSG:4326',
			//styles : 'vector/rainbow', // 'boxfill/rainbow', // contour/rainbow
			COLORSCALERANGE : '0.001,2.005', //  '0.004,0.8193',
			format : 'image/png', 
			tiled : true,
			NUMCOLORBANDS : 253,
			LOGSCALE : false,
			
		}
	});	
	provider.defaultAlpha = transparency;
	
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	
	layer.imageryLayer.brightness = 5.0;
	layer.imageryLayer.alpha = transparency;
	//layer.imageryLayer.contrast = 0.0;
	//layer.imageryLayer.hue = 0.0;
	//layer.imageryLayer.saturation = 0.0;
	//layer.imageryLayer.gamma = 15.0;
	
	
	return layer.imageryLayer;
}

function addLayer( layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType ) {
	if( !imageType ) imageType = 'png8';	
	var layer = {};
	var provider = createImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType );
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	return layer.imageryLayer;
}


function addMarineTrafficLayer( elementId ) {
	var layer = {};
	var layerName = 'MarineTraffic';
	var provider = new MagnoMarineTrafficProvider({
		url : "https://tiles.marinetraffic.com/ais_helpers/shiptilesingle.aspx?output=png&sat=1&grouping=shiptype&tile_size=512&legends=1&zoom={z}&X={x}&Y={y}",
		whenFeaturesAcquired : function( shipPackageData ){
			for( x=0; x < shipPackageData.ships.length; x++   ) {
				var theShip = shipPackageData.ships[x];
				var lat = theShip[1];
				var lon = theShip[0];
				var theHash = Geohash.encode(lat,lon,10);
				var key = theShip[2];
				theShip.push( theHash );
				shipsInScreen[ key ] = theShip;
			}
			console.log( shipPackageData );
		}
	});
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	
	var uuid = createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.layer = layer.imageryLayer;
	
	var props = { 'uuid':uuid, 'elementId':elementId, 'layerName': layerName, 'sourceUrl':'', 'sourceLayers':'' };
	theProvider.layer.properties = props; 
	stackedProviders.push( theProvider );
	return theProvider;
}


function addBaseSystemLayer( elementId, layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType ) {
	var uuid = createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.layer = addLayer( layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType ); 
	
	var props = { 'uuid':uuid, 'elementId':elementId, 'layerName':layerName, 'sourceUrl':sourceUrl, 'sourceLayers':sourceLayers };
	theProvider.layer.properties = props; 
	stackedProviders.push( theProvider );
	
	return theProvider;
}

/*  ************* METODO ESPECIAl PARA TILE SERVER **************** */

function addLayerXYZ( layerName, url, transparency  ) {
	var layer = {};
	var provider = new Cesium.UrlTemplateImageryProvider({
		url : url,
		credit : 'Ministério da Defesa - SisGeoDef',
		maximumLevel : 18,
		hasAlphaChannel : false,
		enablePickFeatures : false
	});
	provider.defaultAlpha = transparency;
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	return layer.imageryLayer;
}
function addBaseSystemLayerXYZ( elementId, layerName, url, transparency ) {
	var uuid = createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.layer = addLayerXYZ( layerName, url, transparency ); 
	var props = { 'uuid':uuid, 'elementId':elementId, 'layerName':layerName, 'sourceUrl':url, 'sourceLayers': 'OpenStreetMap' };
	theProvider.layer.properties = props; 
	stackedProviders.push( theProvider );
	return theProvider;
}


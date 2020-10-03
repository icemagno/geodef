var viewer = null;
var camera = null;
var terrainProvider = null;
var west = -80.72;
var south = -37.16;
var east = -31.14;
var north = 11.79;	
var homeLocation = Cesium.Rectangle.fromDegrees(west, south, east, north);
var mainEventHandler = null;
var scene = null;
var timeout = 6000; 
var imageryLayers = null; 

var mapStyle = '3D'; // [ 3D || 2D ]

var mainConfiguration = null;

var pickedObject = null;
var pickedObjectColor = null;

var cartographic = null;
var cartesian = null;

var attitude = null;
var heading = null;
var altimeter = null;

var mapPointerLatitude = 0;
var mapPointerLongitude = 0;
var mapPointerHeight = 0;

var bdgexMapCache = 'http://bdgex.eb.mil.br/mapcache/';
var bdgexGeoPortal = 'http://bdgex.eb.mil.br/cgi-bin/geoportal';
var bdgexMapaIndice = 'http://www.geoportal.eb.mil.br/cgi-bin/mapaindice/';
var bdgexTeogc = 'http://bdgex.eb.mil.br/teogc/250/terraogcmed.cgi/';


var sisgeodefHost = 'http://sisgeodef.defesa.mil.br';

var volcano;
var efestus;
var pleione;
var mapproxy;
var osmLocal;
var osmTileServer;
var olimpo;

var bdqueimadas = 'http://queimadas.dgi.inpe.br/queimadas/terrama2q/geoserver/wms';

var handler = null;

function updateSisgeodefAddress(){
	osmLocal = sisgeodefHost + '/mapproxy/service/wms';
	mapproxy = sisgeodefHost + '/mapproxy/service/wms';
	pleione = sisgeodefHost + '/geoserver/wms';
	efestus = sisgeodefHost + '/geoserver/wms';
	volcano = sisgeodefHost + '/geoserver/wms';
	olimpo = sisgeodefHost + '/olimpo/tilesets/sisgide';
}


function drawOperationArea( operationArea ) {
	viewer.entities.add({
	    wall : {
	        positions : Cesium.Cartesian3.fromDegreesArrayHeights([west, south, 4000.0,
	                                                        east, south, 4000.0,
	                                                        east, north, 4000.0,
	                                                        west, north, 4000.0,
	                                                        west, south, 4000.0]),
	        material : Cesium.Color.RED.withAlpha(0.5),
	        outline : true
	    }   
	});		
}


function goToOperationArea( operationArea ) {

	
	var center = Cesium.Rectangle.center(operationArea);
	var initialPosition = Cesium.Cartesian3.fromRadians(center.longitude, center.latitude, 8900000);
	var initialOrientation = new Cesium.HeadingPitchRoll.fromDegrees(0, -90, 0);
	scene.camera.setView({
	    destination: initialPosition,
	    orientation: initialOrientation,
	    endTransform: Cesium.Matrix4.IDENTITY
	});	
}


function startMap() {
	
	mapStyle = '2D';
	
	terrainProvider = new Cesium.CesiumTerrainProvider({
		url : olimpo,
		requestVertexNormals : true,
		isSct : false
	});
	
	var baseOsmProvider = "";
	if( mainConfiguration.useExternalOsm ){
		fireToast( 'warning', 'Atenção', 'Você está usando o OpenStreetMap Online.', '000' );
		baseOsmProvider = new Cesium.createOpenStreetMapImageryProvider({
			url : 'https://a.tile.openstreetmap.org/'
		});
	} else {
		fireToast( 'info', 'OpenStreetMap', 'Você está usando o OpenStreetMap em ' + osmTileServer , '000' );
		baseOsmProvider = new Cesium.UrlTemplateImageryProvider({
			url : osmTileServer + 'tile/{z}/{x}/{y}.png',
			credit : 'Ministério da Defesa - SisGeoDef',
			maximumLevel : 25,
			hasAlphaChannel : false,
			enablePickFeatures : false
		});
	}	
		
	var sceneMapMode = Cesium.SceneMode.SCENE2D;
	if ( mapStyle === '3D' ) sceneMapMode = Cesium.SceneMode.SCENE3D;
	
	viewer = new Cesium.Viewer('cesiumContainer',{
		terrainProvider : terrainProvider,
		sceneMode : sceneMapMode,
		mapMode2D: Cesium.MapMode2D.ROTATE,
		timeline: false,
		animation: false,
		baseLayerPicker: false,
		skyAtmosphere: false,
		fullscreenButton : false,
		geocoder : false,
		homeButton : false,
		infoBox : false,
		sceneModePicker : false,
		selectionIndicator : false,
		navigationHelpButton : false,
		//requestRenderMode : true,
	    imageryProvider: baseOsmProvider,
	    
	    //shouldAnimate : true,
        //contextOptions: {
        //	requestWebgl2: true
        //},	    
	});
	viewer.extend( Cesium.viewerCesiumNavigationMixin, {});
	camera = viewer.camera;
	scene = viewer.scene;
	scene.highDynamicRange = false;
	scene.globe.enableLighting = false;
	scene.globe.baseColor = Cesium.Color.WHITE;
	scene.screenSpaceCameraController.enableLook = false;
	scene.screenSpaceCameraController.enableCollisionDetection = true;
	scene.screenSpaceCameraController.inertiaZoom = 0.8;
	scene.screenSpaceCameraController.inertiaTranslate = 0.8;
	scene.globe.maximumScreenSpaceError = 1;
	scene.globe.depthTestAgainstTerrain = true;
	//scene.globe.tileCacheSize = 250;
	scene.pickTranslucentDepth = true;
	scene.useDepthPicking = true;
	scene.skyBox.show = false;
	scene.sun.show = false;
	//scene.bloomEffect.show = true;
	//scene.bloomEffect.threshold = 0.1;
	//scene.bloomEffect.bloomIntensity = 0.3;		

	imageryLayers = scene.imageryLayers;
	
	// drawOperationArea( homeLocation );
	goToOperationArea( homeLocation );
	
	imageryLayers.layerAdded.addEventListener(function (event) {
		//console.log( "Adicionou: " + event.imageryProvider.layers );
		//jQuery('.layerCounter').show();
		//jQuery("#lyrCount").text( event.imageryProvider.layers );
	});
	imageryLayers.layerRemoved.addEventListener(function (event) {
		//console.log( "Removeu: " + event.imageryProvider.layers );
	});	
	
	
	var helper = new Cesium.EventHelper();
	helper.add( viewer.scene.globe.tileLoadProgressEvent, function (event) {
		
		jQuery("#lyrCount").text( event );
		if (event == 0) {
			jQuery('.layerCounter').hide();
			jQuery("#lyrCount").text( "" );
		} else {
			jQuery('.layerCounter').show();
		}
		
	});
	
	
	var measureWidget = new Cesium.Measure({
		container : 'cesiumContainer',
		scene : scene,
		units : new Cesium.MeasureUnits({
		distanceUnits : Cesium.DistanceUnits.METERS,
		areaUnits : Cesium.AreaUnits.SQUARE_METERS,
		volumeUnits : Cesium.VolumeUnits.CUBIC_FEET,
		angleUnits : Cesium.AngleUnits.DEGREES,
		slopeUnits : Cesium.AngleUnits.GRADE})
	});	
	
	
	// Conecta o WebSocket
	connect();
	
};


// Rotina para realizar testes. Nao eh para rodar em produção!!!
function doSomeSandBoxTests(){
	
	populateLayerPanelAsTesting();
	
	/*  Maldito CORS !!
	var imageryProvider = new Cesium.SingleTileImageryProvider({
	    url : "https://mapas.inmet.gov.br/BR.gif",
	    rectangle : Cesium.Rectangle.fromDegrees(-95.0, -60.17, -19.8, 22.4   ) //west, south, east, north
	});
	
	imageryProvider.defaultAlpha = 0.7;
		
	var layers = viewer.scene.imageryLayers;
	layers.addImageryProvider( imageryProvider );	
	*/
	
	
	
	
	// Teste de particulas de vento
	// doWindParticles();
	
	
	/*
	var promise =  viewer.scene.addFieldLayer("/resources/data/climatologia/UTCI_APR.nc");
	Cesium.when(promise,function(fieldLayer){
		fieldLayer.particleVelocityFieldEffect.velocityScale = 100.0;
		fieldLayer.particleVelocityFieldEffect.particleSize = 2;
		fieldLayer.particleVelocityFieldEffect.paricleCountPerDegree = 1.5;
		scene.primitives.add(fieldLayer);
		fieldLayer.particleVelocityFieldEffect.colorTable = colorTable;
		var options = {
			longitude:'lon',
	        latitude:'lat',
	        uwnd:'uwnd',
	        vwnd:'uwnd'
		}
		fieldLayer.NetCDFData = options;
	});
	*/
	
	
	
	
	var testScript = getUrlParam('testscript','xxx');
	if( testScript !== 'xxx'){
		var url = 'http://sisgeodef.defesa.mil.br:36280/scripts/'+testScript+'.js?_d=' + createUUID();
		console.log('Sandbox: invocando run() em ' + url);
		loadScript( url, function(){
			run();
		});
	}
	console.log( 'Variaveis passadas:');
	console.log( getUrlVars() );
	
}

function bindInterfaceElements() {

	bindToolBarButtons();
	
	jQuery("#hudCoordenadas").click( function(){
		jQuery("#mapLat").toggle();
		jQuery("#mapLon").toggle();
	});
	jQuery("#hudAltitude").click( function(){
		jQuery("#mapHei").toggle();
		jQuery("#mapAltitude").toggle();
	});
	jQuery("#hudUtm").click( function(){
		jQuery("#mapUtm").toggle();
	});
	jQuery("#hudHdms").click( function(){
		jQuery("#mapHdmsLat").toggle();
		jQuery("#mapHdmsLon").toggle();
	});

	jQuery("#hudFlight").click( function(){
		jQuery("#flightControlsContainer").toggle();
	});

	jQuery("#hudRosaVentos").click( function(){
		jQuery("#rosaVentos").toggle();
	});
	
	jQuery("#hudAttitude").click( function(){
		jQuery("#instPanel").toggle();
	});

	jQuery("#hudProfile").click( function(){
		jQuery("#elevationProfileContainer").toggle();
	});
	
	// *********************************************************************************************************
	// *********************************************************************************************************
	/* 
	 * Chave das camadas de sistema 
	 */
	// *********************************************************************************************************
	// *********************************************************************************************************
	
	jQuery("#sysLayerShades").click( function(){
		var isChecked = jQuery("#sysLayerShades").prop('checked');
		if( isChecked ) {
			contourShade = addBaseSystemLayer( this.id, 'HillShade', volcano, 'volcano:hillshade', false, 1.0 );
			addBasicLayerToPanel( 'Sombreamento 3D', contourShade );
		} else {
			deleteLayer( contourShade.layer.properties.uuid );
		}
	});	
	
	/*
	jQuery("#sysLayercartasChm").click( function(){
		var isChecked = jQuery("#sysLayercartasChm").prop('checked');
		if( isChecked ) {
			cartasCHM = addBaseSystemLayer( this.id, 'CartasCHM', mapproxy, 'cartasapolo', false, 1.0, 'png' );
			addBasicLayerToPanel( 'Cartas Náuticas CHM', cartasCHM );
		} else {
			deleteLayer( cartasCHM.layer.properties.uuid );
		}
	});
	*/	
	
	
	jQuery("#sysLayerCurvas").click( function(){
		var isChecked = jQuery("#sysLayerCurvas").prop('checked');
		if( isChecked ) {
			contourLines = addBaseSystemLayer( this.id, 'CurvasNivel', volcano, 'volcano:contour', false, 1.0 );
			addBasicLayerToPanel( 'Curvas de Nível NASA', contourLines );
		} else {
			deleteLayer( contourLines.layer.properties.uuid );
		}
	});
	
	jQuery("#sysLayerRapidEye").click( function(){
		var isChecked = jQuery("#sysLayerRapidEye").prop('checked');
		if( isChecked ) {
			rapidEyeImagery = addBaseSystemLayer( this.id, 'RapidEye', mapproxy, 'rapideye', false, 1.0, 'jpeg' );
			addBasicLayerToPanel( 'RapidEye do BDGEX', rapidEyeImagery );
		} else {
			deleteLayer( rapidEyeImagery.layer.properties.uuid );
		}
	});

	jQuery("#sysLayerOpenSeaMap").click( function(){
		var isChecked = jQuery("#sysLayerOpenSeaMap").prop('checked');
		if( isChecked ) {
			openseamap = addBaseSystemLayer( this.id, 'OpenSeaMap', mapproxy, 'seamarks', false, 1.0, 'png' );
			addBasicLayerToPanel( 'Elementos Náuticos OpenSeaMap', openseamap );
		} else {
			deleteLayer( openseamap.layer.properties.uuid );
		}
	});

	
	jQuery("#sysLayerMarineTraffic").click( function(){
		var isChecked = jQuery("#sysLayerMarineTraffic").prop('checked');
		if( isChecked ) {
			marinetraffic = addMarineTrafficLayer( this.id );
			addBasicLayerToPanel( 'Marine Traffic', marinetraffic );
			
			marineTrafficEventHandler.setInputAction(function ( e ) {
				var position = e.position;
				var clickPoint = getLatLogFromMouse( position );
		        var longitude = clickPoint.longitude;
		        var latitude = clickPoint.latitude;
				queryMarineTraffic( latitude, longitude );
			}, Cesium.ScreenSpaceEventType.LEFT_CLICK);			

		} else {
			deleteLayer( marinetraffic.layer.properties.uuid );
			marineTrafficEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_CLICK);
		}
	});
	
	
	jQuery("#sysLayerOSM").click( function(){
		var isChecked = jQuery("#sysLayerOSM").prop('checked');
		if( isChecked ) {
			imageryLayers.get(0).alpha = 1;	
		} else {
			imageryLayers.get(0).alpha = 0;
		}
	});	

	// Layer basico: sempre presente
	jQuery("#sysLayerNaturalEarth").click( function(){
		var isChecked = jQuery("#sysLayerNaturalEarth").prop('checked');
		if( isChecked ) {
			bdgexCartasImageryProvider = addBaseSystemLayer( this.id, 'Cartas BDGEX', mapproxy, 'bdgex', false, 1.0, 'png' );
			addBasicLayerToPanel('Cartas BDGEX', bdgexCartasImageryProvider );
		} else {
			deleteLayer( bdgexCartasImageryProvider.layer.properties.uuid );
		}
	});	
	
	// *********************************************************************************************************
	// *********************************************************************************************************
	
	attitude = jQuery.flightIndicator('#attitude', 'attitude', {roll:50, pitch:-20, size:100, showBox : true});
	heading = jQuery.flightIndicator('#heading', 'heading', {heading:150, size:100, showBox:true});
	altimeter = jQuery.flightIndicator('#altimeter', 'altimeter', {size:100, showBox:true});	
	
	var viewportHeight= jQuery(".main-sidebar").height() - 170;
    
	jQuery('#activeLayerContainer').css({'height': viewportHeight });
	jQuery('#activeLayerContainer').slimScroll({
        height: viewportHeight - 10 + 'px',
        wheelStep : 10,
    });
	
    
    // MACETES - ESCONDER ELEMENTOS "DESNECESSARIOS"
	
    jQuery(".cesium-viewer-bottom").hide();
    jQuery(".cesium-viewer-navigationContainer").hide();
    jQuery(".navigation-controls").hide();
    jQuery(".compass").hide();
    jQuery(".distance-legend").css( {"border": "none", "background-color" : "rgb(60, 141, 188, 0.5)", "height" : 25, "bottom": 60, "right" : 61, "border-radius": 0} );
    jQuery(".distance-legend-label").css( {"font-size": "11px", "font-weight":"bold",  "line-height" : 0, "color" : "white", "font-family": "Consolas"} );
    jQuery(".distance-legend-scale-bar").css( {"height": "9px", "top" : 10, "border-color" : "white"} );
    jQuery.fn.awesomeCursor.defaults.color = 'white';
	
};


jQuery(function () {
	
	// polling para tentar manter o login.
	/*
	setInterval( function(){ 
	    jQuery.ajax({
			url:"/config", 
			type: "GET", 
			success: function( obj ) {
				mainConfiguration = obj;
			},
		    error: function(xhr, textStatus) {
		    	fireToast( 'error', 'Erro Crítico', 'O sistema está fora do ar. Verifique o servidor.', '404' );
		    }, 		
	    });
	}, 60000 );	
	*/
	
	// Adiciona funcionalidade "rotate" ao JQuery
	jQuery.fn.rotate = function(degrees) {
	    jQuery(this).css({'-webkit-transform' : 'rotate('+ degrees +'deg)',
	                 '-moz-transform' : 'rotate('+ degrees +'deg)',
	                 '-ms-transform' : 'rotate('+ degrees +'deg)',
	                 'transform' : 'rotate('+ degrees +'deg)'});
	    return jQuery(this);
	};	
	
	jQuery(window).on("resize", applyMargins);
	
	$("#mainLayerSlider").slider({});
	$("#mainLayerSlider").on("slide", function(slideEvt) {
		var valu = slideEvt.value / 100;
		console.log(valu);
	});	    
	
	
    jQuery.ajax({
		url:"/config", 
		type: "GET", 
		success: function( obj ) {
			mainConfiguration = obj;
			sisgeodefHost = obj.sisgeodefHost;
			updateSisgeodefAddress( );
			osmTileServer = obj.osmTileServer;
			startMap();
			mainEventHandler = new Cesium.ScreenSpaceEventHandler( scene.canvas );
			marineTrafficEventHandler = new Cesium.ScreenSpaceEventHandler( scene.canvas );
			removeMouseDoubleClickListener();
			addMouseHoverListener();
			addCameraChangeListener();
			bindInterfaceElements();
			applyMargins();
			startCartoTree();
			
			
			// So para testes. Dispara apos 3seg
			setTimeout(function(){ 
				//console.log('Nenhum teste sendo executado.');
				doSomeSandBoxTests(); 
			}, 3000);

			
		},
	    error: function(xhr, textStatus) {
	    	alert('Erro ao conectar com o backend da aplicação.');
	    }, 		
    });

	
	/***************************************************************************
			TESTE DE ARRASTAR
	*/
	
    //var pinBuilder = new Cesium.PinBuilder();
    //var position = Cesium.Cartesian3.fromRadians(camera.positionCartographic.longitude, camera.positionCartographic.latitude);
    /*
    var entity = viewer.entities.add({
        position: position,
        billboard: {
            image: pinBuilder.fromColor(Cesium.Color.SALMON, 48),
            verticalOrigin: Cesium.VerticalOrigin.BOTTOM
        }
    });
    */
	
	/*
    var entity = null;
	
	var dragging = false;

	mainEventHandler.setInputAction(
	    function(click) {
	        var pickedObject = scene.pick(click.position);
	        if ( Cesium.defined(pickedObject) ) {
	        	entity = pickedObject.id;
	        	scene.screenSpaceCameraController.enableRotate = false;
	            dragging = true;
	        }
	        */
	        /*
	        if (Cesium.defined(pickedObject) && (pickedObject.id === entity)) {
	            entity.billboard.scale = 1.2;
	            scene.screenSpaceCameraController.enableRotate = false;
	        }
	        */
		/*
	    },
	    Cesium.ScreenSpaceEventType.LEFT_DOWN
	);

	mainEventHandler.setInputAction(
	    function(movement) {
	    	console.log( movement );
	        if ( dragging ) {
	        	
	            entity.position = camera.pickEllipsoid(movement.endPosition);
	        }
	    },
	    Cesium.ScreenSpaceEventType.MOUSE_MOVE
	);

	mainEventHandler.setInputAction(
	    function() {
	    	if ( Cesium.defined(entity) ) { 
	        //entity.billboard.scale = 1;
	        dragging = false;
	        scene.screenSpaceCameraController.enableRotate = true;
	    	}
	    },
	    Cesium.ScreenSpaceEventType.LEFT_UP
	);	
	*/
	
	
	
});

function applyMargins() {
	/*
	var totalHeight= jQuery(window).height();
	var contentHeight= totalHeight - 150;
	jQuery(".content-wrapper").css({"height": contentHeight});
	jQuery(".content-wrapper").css({"min-height": contentHeight});
	jQuery(".control-sidebar-subheading").css({"font-size": "15px"});
	jQuery(".form-group p").css({"font-size": "14px"});
	*/
}

function addCameraChangeListener() {
	
	camera.moveStart.addEventListener(function() { 
		mapIsMoving = true;
	});
	
	camera.moveEnd.addEventListener(function() { 
		mapIsMoving = false;
		updateCamera();
	});
	
}


function updateCamera() {
    var rollV = Cesium.Math.toDegrees( camera.roll );
    var pitchV = Cesium.Math.toDegrees( camera.pitch ) ;
    var headingV = 360 - Cesium.Math.toDegrees( camera.heading );
    var altitudeV = camera.positionCartographic.height;
    
    attitude.setRoll( rollV );
    attitude.setPitch( pitchV );	
    heading.setHeading ( Cesium.Math.toDegrees( camera.heading ) );
    altimeter.setAltitude( altitudeV  );
    
    jQuery("#compassPointer").rotate( headingV );
    jQuery("#rosaVentos").rotate( headingV );
    jQuery("#mapHeading").text( 'Y: ' + headingV.toFixed(0) + "\xB0 " );
    jQuery("#mapAttRoll").text( 'Z: ' + rollV.toFixed(0) + "\xB0 " );
    jQuery("#mapAttPitch").text( 'X: ' + pitchV.toFixed(0) + "\xB0 " );
    jQuery("#mapAltitude").text( altitudeV.toFixed(0) + "m" );
    
}

function updatePanelFooter( position ) {
	cartographic = Cesium.Ellipsoid.WGS84.cartesianToCartographic( position );
	var longitudeString = Cesium.Math.toDegrees(cartographic.longitude).toFixed(10);
	var latitudeString = Cesium.Math.toDegrees(cartographic.latitude).toFixed(10);    	    

	mapPointerLatitude = latitudeString.slice(-15);
	mapPointerLongitude = longitudeString.slice(-15);

	var coordHDMS = convertDMS(mapPointerLatitude,mapPointerLongitude);
	jQuery( document ).ready(function( jQuery ) {
		jQuery("#mapLat").text( mapPointerLatitude );
		jQuery("#mapLon").text( mapPointerLongitude );    	    
		jQuery("#mapUtm").text( latLonToUTM(mapPointerLongitude, mapPointerLatitude  ) );    	    
		jQuery("#mapHdmsLat").text( coordHDMS.lat + " " + coordHDMS.latCard );
		jQuery("#mapHdmsLon").text( coordHDMS.lon + " " + coordHDMS.lonCard );
		
		var geohash = Geohash.encode( mapPointerLatitude, mapPointerLongitude, 8 );
		jQuery("#mapGeohash").text( geohash );
	});

	var positions = [ cartographic ];
	var promise = Cesium.sampleTerrain(terrainProvider, 11, positions);
	Cesium.when(promise, function( updatedPositions ) {
		var tempHeight = cartographic.height;
		if( tempHeight < 0 ) tempHeight = 0; 
		mapPointerHeight = tempHeight.toFixed(2);
		jQuery("#mapHei").text( mapPointerHeight + 'm' );    	    
	});	
	
	
}


function getMapMousePosition( movement ) {

	if ( mapStyle === '2D' ) {
        var position = viewer.camera.pickEllipsoid(movement.endPosition, scene.globe.ellipsoid);
        if (position) {
        	return position;
        } 
	}
	
	if ( mapStyle === '3D' ) {
		var ray = viewer.camera.getPickRay(movement.endPosition);
		var position = viewer.scene.globe.pick(ray, viewer.scene);
		if (Cesium.defined(position)) {
			return position;
		} 
	}
	
}

function addMouseHoverListener() {
	mainEventHandler.setInputAction( function(movement) {
		var position = getMapMousePosition( movement );
		try {
			if ( position ) updatePanelFooter( position );
		} catch ( err ) {
			// ignore
		}
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE );
};

function removeMouseDoubleClickListener() {
	viewer.screenSpaceEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_DOUBLE_CLICK);
}

function removeMouseClickListener() {
	mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.RIGHT_CLICK);			
	mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_CLICK);
	mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_DOUBLE_CLICK);
	jQuery('.cesium-viewer').css('cursor', '');
}


function bindRouteRightClick() {
	mainEventHandler.setInputAction(function ( e ) {
		var position = e.position;
		routeMouseClickPosition = position;
		
		jQuery("#contextMenuRouteInit").css({
			top: position.y + 5, 
			left: position.x + 5, 
			display:'block'
		});
		if( startPoint ) {
			jQuery("#btnEndRoute").removeClass( "disabled" )
		}
		
	}, Cesium.ScreenSpaceEventType.RIGHT_CLICK);

	
	mainEventHandler.setInputAction(function ( e ) {
		hideRouteMenu();
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);			
	
	
}



// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

function getALayerCard( uuid, layerAlias, defaultImage  ){
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>'+layerAlias+'</b></td></tr>'; 
	table = table + '<tr><td colspan="2" style="width: 60%;">'; 
	table = table + '<input id="SL_'+uuid+'" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100" ' +
		'data-slider-tooltip="hide" data-slider-step="5" data-slider-value="100" data-slider-id="blue">';
	table = table + '</td><td >' + 
	'<a title="RF-XXX" href="#" onClick="deleteLayer(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'<a title="RF-YYY" style="margin-right: 10px;" href="#" onClick="layerToUp(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-floppy-o"></i></a>' + 
	'<a title="RF-ZZZ" style="margin-right: 10px;" href="#" onClick="layerToDown(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-gear"></i></a>' + 
	'<a title="RF-WWW" style="margin-right: 10px;" href="#" onClick="exportLayerToPDF(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-search-plus"></i></a>' + 
	'</td></tr>';
	table = table + '</table></div>';
	var layerText = '<div class="sortable" id="'+uuid+'" style="background-color:white; margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';
	return layerText;
}


function getALayerGroup( uuid, groupName, defaultImage ){
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>'+groupName+'</b></td></tr>'; 
	table = table + '<tr><td colspan="3" id="GRPCNT_'+uuid+'"></td></tr>';
	table = table + '</table></div>';
	var layerText = '<div class="sortable" id="'+uuid+'" style="background-color:white; margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';
	return layerText;
}


function populateLayerPanelAsTesting(){
    var defaultImage = "<img title='Alterar Ordem' style='cursor:move;border:1px solid #cacaca;width:19px;' src='/resources/img/drag.png'>";
	
    for( x=0; x < 5; x++ ){
	    var uuid = "layer" + x;
	    var layerAlias = "[ CAMADA ]";
	    
	    var layerText = getALayerCard( uuid, layerAlias, defaultImage );
		$("#activeLayerContainer").append( layerText );
		
		$("#SL_"+uuid).slider({});
		$("#SL_"+uuid).on("slide", function(slideEvt) {
			var valu = slideEvt.value / 100;
			//
		});	
	}
	$("#activeLayerContainer").sortable({
		update: function( event, ui ) {
			console.log( ui );
		}
	});

/*
$(function() {
    $( "#sortable" ).sortable({
        update: function(event, ui) { 
            console.log('update: '+ui.item.index())
        },
        start: function(event, ui) { 
            console.log('start: ' + ui.item.index())
        }
    });
    $( "#sortable" ).disableSelection();
});

If you want the start index to be available to you in the update, then you'll need to set it like this:$(ui.item).data('startindex', ui.item.index()) and then access it with $(ui.item).data().startindex

*/
	
}

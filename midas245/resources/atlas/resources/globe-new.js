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
var scratchRectangle = new Cesium.Rectangle();
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
var baseOsmProvider;

var bdqueimadas = 'http://queimadas.dgi.inpe.br/queimadas/terrama2q/geoserver/wms';

var handler = null;


var drawHelper = null;

function updateSisgeodefAddress( useGateKeeper ){
	if( useGateKeeper){
		osmLocal = sisgeodefHost + '/mapproxy/service/wms';
		mapproxy = sisgeodefHost + '/mapproxy/service/wms';
		pleione = sisgeodefHost + '/geoserver/wms';
		efestus = sisgeodefHost + '/geoserver/wms';
		volcano = sisgeodefHost + '/geoserver/wms';
		olimpo = sisgeodefHost + '/olimpo/tilesets/sisgide';
	} else {
		osmLocal = sisgeodefHost + ':36890/service/wms';
		mapproxy = sisgeodefHost + ':36890/service/wms';
		pleione = sisgeodefHost + ':36212/geoserver/wms';
		efestus = sisgeodefHost + ':36212/geoserver/wms';
		volcano = sisgeodefHost + ':36212/geoserver/wms';
		olimpo = sisgeodefHost + ':36503/tilesets/sisgide';
		
	}
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
	var initialPosition = Cesium.Cartesian3.fromRadians(center.longitude, center.latitude, 11500000);
	var initialOrientation = new Cesium.HeadingPitchRoll.fromDegrees(0, -90, 0);
	scene.camera.setView({
	    destination: initialPosition,
	    orientation: initialOrientation,
	    endTransform: Cesium.Matrix4.IDENTITY
	});	
}



function startMap( theMapStyle ) {
	
	mapStyle = theMapStyle;
	
	if( mapStyle == '2D'){
		$("#analise3dMainBtn").addClass('disabled');
	} 
	
	
	terrainProvider = new Cesium.CesiumTerrainProvider({
		url : olimpo,
		requestVertexNormals : true,
		isSct : false
	});
	
	if( mainConfiguration.useExternalOsm ){
		fireToast( 'warning', 'Atenção', 'Você está usando o OpenStreetMap Online.', '000' );
		
		baseOsmProvider = new Cesium.OpenStreetMapImageryProvider({
		    url : 'https://a.tile.openstreetmap.org/'
		});		
		
		
	} else {
		fireToast( 'info', 'OpenStreetMap', 'Você está usando o OpenStreetMap em ' + osmTileServer , '000' );
		baseOsmProvider = new Cesium.UrlTemplateImageryProvider({
			url : osmTileServer + 'tile/{z}/{x}/{y}.png',
			credit : 'Ministério da Defesa - SisGeoDef',
			maximumLevel : 25,
			hasAlphaChannel : false
		});
	}	
		
	var sceneMapMode = Cesium.SceneMode.SCENE2D;
	if ( mapStyle === '3D' ) sceneMapMode = Cesium.SceneMode.SCENE3D;
	
	viewer = new Cesium.Viewer('cesiumContainer',{
		//terrainProvider : terrainProvider,
		sceneMode : sceneMapMode,
		//mapMode2D: Cesium.MapMode2D.ROTATE,
		timeline: false,
		animation: false,
		baseLayerPicker: false,
		skyAtmosphere: false,
		fullscreenButton : false,
		geocoder : false,
		homeButton : false,
		infoBox : false,
		skyBox : false,
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
	scene.globe.depthTestAgainstTerrain = false;
	//scene.globe.tileCacheSize = 250;
	scene.pickTranslucentDepth = true;
	scene.useDepthPicking = true;

	var width = viewer.scene.drawingBufferWidth;
	var height = viewer.scene.drawingBufferHeight;
	console.log('Resolução ' + width + ' x ' + height );	
	
	imageryLayers = scene.imageryLayers;
	
	// drawOperationArea( homeLocation );
	goToOperationArea( homeLocation );
	
	
	imageryLayers.layerShownOrHidden.addEventListener(function (event) {
		console.log('Shown/Hidden');
	});
	imageryLayers.layerAdded.addEventListener(function (event) {
		//console.log( "Adicionou: " + event.imageryProvider.layers );
		//$('.layerCounter').show();
		//$("#lyrCount").text( event.imageryProvider.layers );
	});
	imageryLayers.layerRemoved.addEventListener(function (event) {
		//console.log( "Removeu: " + event.imageryProvider.layers );
	});	
	
	
	var helper = new Cesium.EventHelper();
	helper.add( viewer.scene.globe.tileLoadProgressEvent, function (event) {
		
		$("#lyrCount").text( event );
		if (event == 0) {
			$('.layerCounter').hide();
			$("#lyrCount").text( "" );
		} else {
			$('.layerCounter').show();
		}
		
	});
	
	// Conecta o WebSocket
	connect();
	drawHelper = new DrawHelper( viewer );
	
	
	viewer.clock.onTick.addEventListener(function() {
	    var rect = viewer.camera.computeViewRectangle( viewer.scene.globe.ellipsoid, scratchRectangle );
	    if( Cesium.defined(rect) ){
		    var bWest = Cesium.Math.toDegrees(rect.west);
		    var bSouth = Cesium.Math.toDegrees(rect.south);
		    var bEast = Cesium.Math.toDegrees(rect.east);
		    var bNorth = Cesium.Math.toDegrees(rect.north);
		    
		    $("#vpW").text( bWest );
		    $("#vpE").text( bEast );
		    $("#vpN").text( bNorth );
		    $("#vpS").text( bSouth );
	    }	    
	    
	});	
	
	var graticule = new Graticule({
	      	tileWidth: 512,
	      	tileHeight: 512,
			fontColor:  Cesium.Color.ORANGE, 
			color :   Cesium.Color.ORANGE,
			sexagesimal : false,
			weight:  0.8, 
			zoomInterval: [
				   Cesium.Math.toRadians(0.01), 
				   Cesium.Math.toRadians(0.02),
			       Cesium.Math.toRadians(0.05),
			       Cesium.Math.toRadians(0.1),
			       Cesium.Math.toRadians(0.2),
			       Cesium.Math.toRadians(0.5),
			       Cesium.Math.toRadians(1.0),
			       Cesium.Math.toRadians(2.0),
			       Cesium.Math.toRadians(5.0),
			       Cesium.Math.toRadians(10.0),
			       Cesium.Math.toRadians(20.0),
			       Cesium.Math.toRadians(50.0)
			] // Different map zoom levels show the grid interval
	}, scene);
	viewer.scene.imageryLayers.addImageryProvider(graticule);
	graticule.setVisible( true );	
	
};


// Rotina para realizar testes. Nao eh para rodar em produção!!!
function doSomeSandBoxTests(){

	
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
	
	$("#hudCoordenadas").click( function(){
		$("#mapLat").toggle();
		$("#mapLon").toggle();
	});
	$("#hudAltitude").click( function(){
		$("#mapHei").toggle();
		$("#mapAltitude").toggle();
	});
	$("#hudUtm").click( function(){
		$("#mapUtm").toggle();
	});
	$("#hudHdms").click( function(){
		$("#mapHdmsLat").toggle();
		$("#mapHdmsLon").toggle();
	});

	$("#hudFlight").click( function(){
		$("#flightControlsContainer").toggle();
	});

	$("#hudRosaVentos").click( function(){
		$("#rosaVentos").toggle();
	});
	
	$("#hudAttitude").click( function(){
		$("#instPanel").toggle();
	});

	$("#hudProfile").click( function(){
		$("#elevationProfileContainer").toggle();
	});
	
	// *********************************************************************************************************
	// *********************************************************************************************************
	/* 
	 * Chave das camadas de sistema 
	 */
	// *********************************************************************************************************
	// *********************************************************************************************************
	
	$("#sysLayerShades").click( function(){
		var isChecked = $("#sysLayerShades").prop('checked');
		if( isChecked ) {
			contourShade = addBaseSystemLayer( this.id, 'HillShade', volcano, 'volcano:hillshade', false, 1.0 );
			addBasicLayerToPanel( 'Sombreamento 3D', contourShade );
		} else {
			deleteLayer( contourShade.layer.properties.uuid );
		}
	});	

	
	$("#sysLayerCurvas").click( function(){
		var isChecked = $("#sysLayerCurvas").prop('checked');
		if( isChecked ) {
			contourLines = addBaseSystemLayer( this.id, 'CurvasNivel', volcano, 'volcano:contour', false, 1.0 );
			addBasicLayerToPanel( 'Curvas de Nível NASA', contourLines );
		} else {
			deleteLayer( contourLines.layer.properties.uuid );
		}
	});
	
	$("#sysLayerRapidEye").click( function(){
		var isChecked = $("#sysLayerRapidEye").prop('checked');
		if( isChecked ) {
			rapidEyeImagery = addBaseSystemLayer( this.id, 'RapidEye', mapproxy, 'rapideye', false, 1.0, 'jpeg' );
			addBasicLayerToPanel( 'RapidEye do BDGEX', rapidEyeImagery );
		} else {
			deleteLayer( rapidEyeImagery.layer.properties.uuid );
		}
	});

	$("#sysLayerOpenSeaMap").click( function(){
		var isChecked = $("#sysLayerOpenSeaMap").prop('checked');
		if( isChecked ) {
			openseamap = addBaseSystemLayer( this.id, 'OpenSeaMap', mapproxy, 'seamarks', false, 1.0, 'png' );
			addBasicLayerToPanel( 'Elementos Náuticos OpenSeaMap', openseamap );
		} else {
			deleteLayer( openseamap.layer.properties.uuid );
		}
	});

	
	$("#sysLayerMarineTraffic").click( function(){
		var isChecked = $("#sysLayerMarineTraffic").prop('checked');
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
	
	
	$("#sysLayerOSM").click( function(){
		var isChecked = $("#sysLayerOSM").prop('checked');
		if( isChecked ) {
			imageryLayers.get(0).alpha = 1;	
		} else {
			imageryLayers.get(0).alpha = 0;
		}
	});	

	// Layer basico: sempre presente
	$("#sysLayerNaturalEarth").click( function(){
		var isChecked = $("#sysLayerNaturalEarth").prop('checked');
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
	
	var viewportHeight= $(".main-sidebar").height() - 170;
    
	$('#activeLayerContainer').css({'height': viewportHeight });
	$('#activeLayerContainer').slimScroll({
        height: viewportHeight - 10 + 'px',
        wheelStep : 10,
    });
	
	
	
	$("#activeLayerContainer").sortable({
		update: function( event, ui ) {
			updateLayersOrder( event, ui );
		},
        start: function (event, ui) {
            //$(ui.item).data( "startindex", ui.item.index() );
        },
        stop: function (event, ui) {
            //
        }		
	});
	    
	
    // MACETES - ESCONDER ELEMENTOS "DESNECESSARIOS"
	
    $(".cesium-viewer-bottom").hide();
    $(".cesium-viewer-navigationContainer").hide();
    $(".navigation-controls").hide();
    $(".compass").hide();
    $(".distance-legend").css( {"border": "none", "background-color" : "rgb(60, 141, 188, 0.5)", "height" : 25, "bottom": 60, "right" : 61, "border-radius": 0} );
    $(".distance-legend-label").css( {"font-size": "11px", "font-weight":"bold",  "line-height" : 0, "color" : "white", "font-family": "Consolas"} );
    $(".distance-legend-scale-bar").css( {"height": "9px", "top" : 10, "border-color" : "white"} );
    jQuery.fn.awesomeCursor.defaults.color = 'white';
	
};


$(function () {
	
	// polling para tentar manter o login.
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
	
	// Adiciona funcionalidade "rotate" ao JQuery
	jQuery.fn.rotate = function(degrees) {
	    $(this).css({'-webkit-transform' : 'rotate('+ degrees +'deg)',
	                 '-moz-transform' : 'rotate('+ degrees +'deg)',
	                 '-ms-transform' : 'rotate('+ degrees +'deg)',
	                 'transform' : 'rotate('+ degrees +'deg)'});
	    return $(this);
	};	
	
	$(window).on("resize", applyMargins);
	
	
	var theMapStyle = getUrlParam('mapStyle','2D');
	
    jQuery.ajax({
		url:"/config", 
		type: "GET", 
		success: function( obj ) {
			mainConfiguration = obj;
			sisgeodefHost = obj.sisgeodefHost;
			updateSisgeodefAddress( obj.useGateKeeper  );
			osmTileServer = obj.osmTileServer;
			startMap( theMapStyle );
			mainEventHandler = new Cesium.ScreenSpaceEventHandler( scene.canvas );
			marineTrafficEventHandler = new Cesium.ScreenSpaceEventHandler( scene.canvas );
			removeMouseDoubleClickListener();
			addMouseHoverListener();
			addCameraChangeListener();
			bindInterfaceElements();
			applyMargins();
			initControlSideBar();
			
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
	var totalHeight= $(window).height();
	var contentHeight= totalHeight - 150;
	$(".content-wrapper").css({"height": contentHeight});
	$(".content-wrapper").css({"min-height": contentHeight});
	$(".control-sidebar-subheading").css({"font-size": "15px"});
	$(".form-group p").css({"font-size": "14px"});
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
    
    $("#compassPointer").rotate( headingV );
    $("#rosaVentos").rotate( headingV );
    $("#mapHeading").text( 'Y: ' + headingV.toFixed(0) + "\xB0 " );
    $("#mapAttRoll").text( 'Z: ' + rollV.toFixed(0) + "\xB0 " );
    $("#mapAttPitch").text( 'X: ' + pitchV.toFixed(0) + "\xB0 " );
    $("#mapAltitude").text( altitudeV.toFixed(0) + "m" );
    
}

function updatePanelFooter( position ) {
	cartographic = Cesium.Ellipsoid.WGS84.cartesianToCartographic( position );
	var longitudeString = Cesium.Math.toDegrees(cartographic.longitude).toFixed(10);
	var latitudeString = Cesium.Math.toDegrees(cartographic.latitude).toFixed(10);    	    

	mapPointerLatitude = latitudeString.slice(-15);
	mapPointerLongitude = longitudeString.slice(-15);

	var coordHDMS = convertDMS(mapPointerLatitude,mapPointerLongitude);
	$( document ).ready(function( jQuery ) {
		$("#mapLat").text( mapPointerLatitude );
		$("#mapLon").text( mapPointerLongitude );    	    
		$("#mapUtm").text( latLonToUTM(mapPointerLongitude, mapPointerLatitude  ) );    	    
		$("#mapHdmsLat").text( coordHDMS.lat + " " + coordHDMS.latCard );
		$("#mapHdmsLon").text( coordHDMS.lon + " " + coordHDMS.lonCard );
		
		var geohash = Geohash.encode( mapPointerLatitude, mapPointerLongitude, 8 );
		$("#mapGeohash").text( geohash );
	});

	var positions = [ cartographic ];
	var promise = Cesium.sampleTerrain(terrainProvider, 11, positions);
	Cesium.when(promise, function( updatedPositions ) {
		var tempHeight = cartographic.height;
		if( tempHeight < 0 ) tempHeight = 0; 
		mapPointerHeight = tempHeight.toFixed(2);
		$("#mapHei").text( mapPointerHeight + 'm' );    	    
	});	
	
	
}

/*
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
*/

function addMouseHoverListener() {
	mainEventHandler.setInputAction( function(movement) {
		
		var position = getMapPosition3D2D( movement.endPosition );
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
	$('.cesium-viewer').css('cursor', '');
}


function bindRouteRightClick() {
	mainEventHandler.setInputAction(function ( e ) {
		var position = e.position;
		routeMouseClickPosition = position;
		
		$("#contextMenuRouteInit").css({
			top: position.y + 5, 
			left: position.x + 5, 
			display:'block'
		});
		if( startPoint ) {
			$("#btnEndRoute").removeClass( "disabled" )
		}
		
	}, Cesium.ScreenSpaceEventType.RIGHT_CLICK);

	
	mainEventHandler.setInputAction(function ( e ) {
		hideRouteMenu();
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);			
	
	
}


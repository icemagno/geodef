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
var globalScreenViewport = {};
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

var drawedFeaturesBillboards;

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
		//$("#analise3dMainBtn").addClass('disabled');
		console.log('Desabilitei temporariamente o chaveamento do botão de 3D');
	} 
	
	
	terrainProvider = new Cesium.CesiumTerrainProvider({
		url : olimpo,
		requestVertexNormals : false,
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
	
	if( mapStyle == '3D'){
		viewer.terrainProvider = terrainProvider;
	} 	
	
	viewer.extend( Cesium.viewerCesiumNavigationMixin, {});
	camera = viewer.camera;
	scene = viewer.scene;
	scene.highDynamicRange = false;
	scene.globe.enableLighting = false;
	scene.globe.baseColor = Cesium.Color.WHITE;
	scene.screenSpaceCameraController.enableLook = false;
	scene.screenSpaceCameraController.enableCollisionDetection = true;
	
	scene.screenSpaceCameraController.inertiaZoom = 0;
	scene.screenSpaceCameraController.inertiaTranslate = 0;
	scene.screenSpaceCameraController.inertiaSpin = 0;
	
	//scene.globe.maximumScreenSpaceError = 1;
	scene.globe.depthTestAgainstTerrain = false;
	//scene.globe.tileCacheSize = 250;
	scene.pickTranslucentDepth = true;
	scene.useDepthPicking = true;

	var width = viewer.scene.drawingBufferWidth;
	var height = viewer.scene.drawingBufferHeight;
	console.log('Resolução ' + width + ' x ' + height );	
	
	imageryLayers = scene.imageryLayers;
	
	goToOperationArea( homeLocation );
	
	imageryLayers.layerShownOrHidden.addEventListener(function (event) {
		//
	});
	imageryLayers.layerAdded.addEventListener(function (event) {
		//console.log( "Adicionou layer.");
		//$('.layerCounter').show();
		//$("#lyrCount").text( event.imageryProvider.layers );
	});
	imageryLayers.layerRemoved.addEventListener(function (event) {
		//console.log( "Removeu layer");
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
	//connect();
	
	
	drawHelper = new DrawHelper( viewer, function( object, position ){
		
		if( object.id ){
			viewer._container.style.cursor = "help";
			if( object.id.properties ){
				var qtd = object.id.properties.propertyNames.length
				drawHelper._tooltip.showAt( position , qtd + ' atributo(s)' );
			} else {
				drawHelper._tooltip.showAt( position , 'sem atributos' );
			}
		}


	}, function(){
		drawHelper._tooltip.setVisible(false);
		viewer._container.style.cursor = "default";		
	});
	
	drawedFeaturesBillboards = new Cesium.BillboardCollection({scene: viewer.scene});
	scene.groundPrimitives.add( drawedFeaturesBillboards );
	
	/*
	var graticule = new Graticule({
	      	tileWidth: 512,
	      	tileHeight: 512,
			fontColor:  Cesium.Color.ORANGE, 
			color :   Cesium.Color.ORANGE,
			sexagesimal : false,
			weight:  0.8, 
	}, scene);
	viewer.scene.imageryLayers.addImageryProvider(graticule);
	graticule.setVisible( true );	
	*/
	
	
};

/*
var windy;
var windy2;
var timer = null;

function redraw() {
    timer = setInterval(function () {
    	if( windy ) windy.animate();
    	if( windy2 ) windy2.animate();
    }, 300);
}
*/
// Rotina para realizar testes. Nao eh para rodar em produção!!!
function doSomeSandBoxTests(){

	/*
	var url = "/radar?l={l}&r={r}&t={t}&b={b}";
	var buildingsProvider = new MagnoMetocRadarProvider({
	  debugTiles : false,
	  viewer : viewer,
	  activationLevel : 5,
	  sourceUrl : url,
	  featuresPerTile : 1000,
	  rampStart : '#b9e1fa',
	  rampEnd : '#039eff',
	  rampCountStart : -30,
	  rampCountEnd : 50,
	  whenFeaturesAcquired : function( entities ){
		console.log( entities.length + " celulas recebidas." );
	  }
	});
	viewer.imageryLayers.addImageryProvider( buildingsProvider );	
	*/
	
	
	// initCappiMonitor();
	// Teste de particulas de vento
	/*
    $.ajax({
        type: "get",
        // url: "http://s0.cptec.inpe.br/oceano/blend/vsm/vsm_diario_glb/vsm.json",// 
        url: "/resources/data/climatologia/glb-vsm.json", 
        dataType: "json",
        success: function (response) {
            var header = response[0].header;
            windy = new Windy(response, viewer, {
            	color : Cesium.Color.RED
            });
            redraw();
        },
        error: function (errorMsg) {
            alert("Erro");
        }
    });	
	*/
	
	/*
    $.ajax({
        type: "get",
        // url: "http://s0.cptec.inpe.br/oceano/blend/vsm/vsm_diario_glb/vsm.json",// 
        url: "/resources/data/climatologia/asm-vsm.json", 
        dataType: "json",
        success: function (response) {
        	console.log( response);
            var header = response[0].header;
            windy2 = new Windy(response, viewer, {
            	color : Cesium.Color.BLUE
            });
        },
        error: function (errorMsg) {
            alert("Erro");
        }
    });	
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
	
	console.log( viewportHeight - 10 );
	
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
			queryLayerEventHandler = new Cesium.ScreenSpaceEventHandler( scene.canvas );
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
    
    var rect = viewer.camera.computeViewRectangle( viewer.scene.globe.ellipsoid, scratchRectangle );
    var bWest = "", bSouth = "", bEast = "", bNorth = "";

    if( Cesium.defined(rect) ){
	    bWest = Cesium.Math.toDegrees(rect.west);
	    bSouth = Cesium.Math.toDegrees(rect.south);
	    bEast = Cesium.Math.toDegrees(rect.east);
	    bNorth = Cesium.Math.toDegrees(rect.north);
    } else {
		var cl2 = new Cesium.Cartesian2(0, 0);
		var leftTop = viewer.scene.camera.pickEllipsoid(cl2, viewer.scene.globe.ellipsoid);
			
		var cr2 = new Cesium.Cartesian2(viewer.scene.canvas.width, viewer.scene.canvas.height);
		var rightDown = viewer.scene.camera.pickEllipsoid(cr2, viewer.scene.globe.ellipsoid);
		
		leftTop = viewer.scene.globe.ellipsoid.cartesianToCartographic(leftTop);
		rightDown = viewer.scene.globe.ellipsoid.cartesianToCartographic(rightDown);
		
		bWest = Cesium.Math.toDegrees(leftTop.longitude);
		bEast = Cesium.Math.toDegrees(rightDown.longitude);
		bNorth = Cesium.Math.toDegrees(leftTop.latitude);
		bSouth = Cesium.Math.toDegrees(rightDown.latitude);
		//rect = new Cesium.Rectangle(leftTop.longitude, rightDown.latitude, rightDown.longitude, leftTop.latitude);
    }

    globalScreenViewport.bWest = bWest;
    globalScreenViewport.bSouth = bSouth;
    globalScreenViewport.bEast = bEast;
    globalScreenViewport.bNorth = bNorth;
    
    $("#vpW").text( bWest );
    $("#vpE").text( bEast );
    $("#vpN").text( bNorth );
    $("#vpS").text( bSouth );
    
    
    
    // Em layers.js
    updateLegendImages();
    
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
		
		var utmVal = fromLatLon( parseFloat(mapPointerLatitude), parseFloat(mapPointerLongitude));
		var easting = utmVal.easting + "";
		var northing = utmVal.northing + "";
		var eaArr = easting.split(".");
		var noArr = northing.split(".");
		
		var eaDec = eaArr[1].substring(0,2);
		var noDec = noArr[1].substring(0,2);
		
		//var theUtm = utmVal.zoneNum + utmVal.zoneLetter + " " + eaArr[0].substring(0,5) + "." + eaDec + " " + noArr[0].substring(0,5) + "." + noDec;
		var theUtm = utmVal.zoneNum + utmVal.zoneLetter + " " + eaArr[0] + " " + noArr[0];
		
		$("#mapUtm").text( theUtm );    	    
		
		
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




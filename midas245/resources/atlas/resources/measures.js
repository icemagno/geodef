
var lines = [];

jQuery("#toolMeasureArea").click( function(){
	measurePolygon();
});


jQuery("#toolMeasureLine").click( function(){
	measureLine();
});

function deleteMeasureLine( uuid ) {
	
	for ( y=0; y<lines.length; y++ ) {
		
		if( lines[y].uuid == uuid ) {
			viewer.entities.remove( lines[y].medicaoLine );
			lines.splice(y, 1);
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#measureResultsContainer').children().length;
				if ( count === 0 ) { jQuery("#measureCounter").html( '' ); } else { jQuery("#measureCounter").html( count ); }
			});			
			return true;
		}
	}
}


function gotoMeasureLine( uuid ) {
	for ( y=0; y<lines.length; y++ ) {
		if( lines[y].uuid == uuid ) {
			viewer.zoomTo( lines[y].medicaoLine );
		}
	}
}

function updateTooltip( viewModel ) {
	jQuery("#toolTip").html( viewModel.distance + '</br>' + viewModel.longitude + '</br>' + viewModel.latitude );
	jQuery("#toolTip").css( {top: viewModel.top, left: viewModel.left} );
}

function addToPanel( viewModel ) {
	
	var comprimento = viewModel.distance;
	var uuid = viewModel.uuid;
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td class="layerTable"><i class="fa fa-expand"></i> &nbsp; <b>Linha de Medição</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<ul style="margin: 0px;" class="list-inline">' + 
	'<li><a href="#" onClick="deleteMeasureLine(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a></li>' + 
	'</ul></td></tr>'; 
	
	table = table + '<tr><td class="layerTable">Comprimento</td>'+
	'<td  class="layerTable" style="text-align: right;">'+ comprimento +'</td></tr>';
	
	table = table + '<tr><td colspan="2" class="layerTable" style="text-align: right;"><button onclick="gotoMeasureLine(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';

	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#measureResultsContainer").append( layerText );

	var count = jQuery('#measureResultsContainer').children().length;
	jQuery("#measureCounter").html( count );		
	
	jQuery("#layerContainer").show( "slow" );
	jQuery("#sysLayerPanel").prop( "checked", true );		
	
	
}


function addToPanelMPoly( viewModel ) {
	
	var comprimento = viewModel.distance;
	var uuid = viewModel.uuid;
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td class="layerTable"><i class="fa fa-object-ungroup"></i> &nbsp; <b>Área de Medição</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<ul style="margin: 0px;" class="list-inline">' + 
	'<li><a href="#" onClick="deleteMeasureLine(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a></li>' + 
	'</ul></td></tr>'; 
	
	table = table + '<tr><td class="layerTable">Área</td>'+
	'<td  class="layerTable" style="text-align: right;">'+ comprimento +'</td></tr>';
	
	table = table + '<tr><td colspan="2" class="layerTable" style="text-align: right;"><button onclick="gotoMeasureLine(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';

	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#measureResultsContainer").append( layerText );

	var count = jQuery('#measureResultsContainer').children().length;
	jQuery("#measureCounter").html( count );		
	
	jQuery("#layerContainer").show( "slow" );
	jQuery("#sysLayerPanel").prop( "checked", true );		
	
	
}



function measureLine() {
	
	changeMouseToHand();
	
	var viewModel = {
		uuid      : '',	
		distance  : '',
		longitude : '',
		latitude  : '',
		height    : '',
		top       : 0,
		left      : 0,
		medicaoLine : null,
	};
	
	var handlerDis = new Cesium.MeasureHandler( viewer, Cesium.MeasureMode.Distance, Cesium.ClampMode.Ground );
	handlerDis.clampMode = Cesium.ClampMode.Ground;
	handlerDis.enableDepthTest = true;
	
	handlerDis.activate();

	handlerDis.measureEvt.addEventListener( function( result ){
		distance = result.distance > 1000 ? (result.distance / 1000).toFixed(2) + ' km' : result.distance + ' m';
		viewModel.distance = distance;	
		updateTooltip( viewModel );
		jQuery("#toolTip").show();
		changeMouseToHand();
	});	
	
	mainEventHandler.setInputAction(function ( movement ) {

		try {
			var position = getMapMousePosition( movement );
			updatePanelFooter( position );
			
			cartographic = Cesium.Ellipsoid.WGS84.cartesianToCartographic(position);
			var longitudeString = Cesium.Math.toDegrees(cartographic.longitude).toFixed(10);
			var latitudeString = Cesium.Math.toDegrees(cartographic.latitude).toFixed(10);    	    
	
			mapPointerLatitude = latitudeString.slice(-15);
			mapPointerLongitude = longitudeString.slice(-15);
			var tempHeight = cartographic.height;
			if( tempHeight < 0 ) tempHeight = 0; 
			mapPointerHeight = tempHeight.toFixed(2);
	
			var coordHDMS = convertDMS(mapPointerLatitude,mapPointerLongitude);
			
			
			viewModel.longitude = coordHDMS.lon + " " + coordHDMS.lonCard;
			viewModel.latitude = coordHDMS.lat + " " + coordHDMS.latCard;
			viewModel.height = mapPointerHeight;
			
			var screenPosition = movement.endPosition;
			viewModel.top = screenPosition.y + 20;
			viewModel.left = screenPosition.x + 10;
		} catch ( error ) {
			//
		}
		
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);					
	
	mainEventHandler.setInputAction(function (e) {
		
		var pl = handlerDis.polyline;
		
		// guarda a linha medida
		var medicaoLine = viewer.entities.add({
		    polyline : {
		        positions : pl.positions,
		        width : 3.0,
		        material : Cesium.Color.RED,
		        clampToGround : true
		    }
		});
		
		viewModel.uuid = createUUID();
		viewModel.medicaoLine = medicaoLine;
		
		lines.push( viewModel );	
		addToPanel( viewModel );
		
		// Cancela o evento do botao direito.
		mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.RIGHT_CLICK);
		// Cancela o evento do movimento.
		mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.MOUSE_MOVE);
		// Cancela o callback de observacao da lista de entidades
		// esconde o display de medida
		jQuery("#toolTip").hide();
		// Restaura o evento de mouse original ( elementos de tela )
		addMouseHoverListener();
		
		handlerDis.clear();
		
		jQuery('.cesium-viewer').css('cursor', '');
		
	}, Cesium.ScreenSpaceEventType.RIGHT_CLICK);	

	
}

function changeMouseToHand() {
	jQuery('.cesium-viewer').awesomeCursor('hand-o-down', {
		outline: 'white',
		size: 20,
		hotspot: [10, 20],
	});
}	

/*  ************************************************
 * 
 *   MEDICAO DE AREA
 *   
 ***************************************************/

function measurePolygon() {

	changeMouseToHand();
	
	var viewModel = {
			uuid      : '',	
			distance  : '',
			longitude : '',
			latitude  : '',
			height    : '',
			top       : 0,
			left      : 0,
			medicaoPolygon : null,
		};	
	
	var handlerDis = new Cesium.MeasureHandler( viewer, Cesium.MeasureMode.Area, Cesium.ClampMode.Ground );
	handlerDis.clampMode = Cesium.ClampMode.Ground;
	handlerDis.enableDepthTest = true;	
	handlerDis.activate();
	
	handlerDis.measureEvt.addEventListener(function(result){
		var area = result.area > 1000000 ? (result.area/1000000).toFixed(2) + ' km²' : result.area + ' m²';
		viewModel.distance = area;	
		updateTooltip( viewModel );
		jQuery("#toolTip").show();
		changeMouseToHand();		
	});
	
	
	mainEventHandler.setInputAction(function ( movement ) {
		
		try {
			var position = getMapMousePosition( movement );
			updatePanelFooter( position );
			
			cartographic = Cesium.Ellipsoid.WGS84.cartesianToCartographic(position);
			var longitudeString = Cesium.Math.toDegrees(cartographic.longitude).toFixed(10);
			var latitudeString = Cesium.Math.toDegrees(cartographic.latitude).toFixed(10);    	    
	
			mapPointerLatitude = latitudeString.slice(-15);
			mapPointerLongitude = longitudeString.slice(-15);
			var tempHeight = cartographic.height;
			if( tempHeight < 0 ) tempHeight = 0; 
			mapPointerHeight = tempHeight.toFixed(2);
	
			var coordHDMS = convertDMS(mapPointerLatitude,mapPointerLongitude);
			
			
			viewModel.longitude = coordHDMS.lon + " " + coordHDMS.lonCard;
			viewModel.latitude = coordHDMS.lat + " " + coordHDMS.latCard;
			viewModel.height = mapPointerHeight;
			
			var screenPosition = movement.endPosition;
			viewModel.top = screenPosition.y + 20;
			viewModel.left = screenPosition.x + 10;
			
			changeMouseToHand();
			
		} catch ( error ) {
			console.log( error );
		}
		
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);		
	
	mainEventHandler.setInputAction(function (e) {
		
		var pl = handlerDis.polyline;
		pl.positions.push( pl.positions[0] );
		
		// guarda a linha medida
		var medicaoLine = viewer.entities.add({
		    polyline : {
		        positions : pl.positions,
		        width : 3.0,
		        material : Cesium.Color.GREEN,
		        clampToGround : true,
		    }
		});
		viewModel.uuid = createUUID();
		viewModel.medicaoLine = medicaoLine;
		lines.push( viewModel );	
		addToPanelMPoly( viewModel );
		
		// Cancela o evento do botao direito.
		mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.RIGHT_CLICK);
		// Cancela o evento do movimento.
		mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.MOUSE_MOVE);
		// Cancela o callback de observacao da lista de entidades
		// esconde o display de medida
		jQuery("#toolTip").hide();
		// Restaura o evento de mouse original ( elementos de tela )
		addMouseHoverListener();
		
		handlerDis.clear();
		
		jQuery('.cesium-viewer').css('cursor', '');
		
	}, Cesium.ScreenSpaceEventType.RIGHT_CLICK);		
	
}
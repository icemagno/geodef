var routePoints = [];
var routeResultLines = [];
var routeMouseClickPosition = null;
var routesToUpdate = [];
var lastWaypoint = null;
var routeInInstruction = null;
var startPoint = null;
var editingRoute = false;
var clickedPointPin = null;

var routeColorActive = new Cesium.PolylineGlowMaterialProperty({ glowPower : 0.14, color : Cesium.Color.LIMEGREEN });
var routeColorSelected = new Cesium.PolylineGlowMaterialProperty({ glowPower : 0.14, color : Cesium.Color.RED });			    	 
	
var routeBeingEdited = {};

var barrierPoints = [];

function setStartRoute() {
	startPoint = getLatLogFromMouse( routeMouseClickPosition );
	jQuery("#contextMenuRouteInit").css({
		display:'none'
	});
	routePoints = [];
	
	if ( clickedPointPin ) viewer.entities.remove( clickedPointPin );
	clickedPointPin = putMarker( Cesium.Cartesian3.fromDegrees( parseFloat( startPoint.longitude ), parseFloat( startPoint.latitude) ), 'pin-start.png' );
	
}


function insertBlockRoute() {
	hideRouteMenu();
	
	var point = getLatLogFromMouse( routeMouseClickPosition );
	var uuid = createUUID();
	var bpPos = Cesium.Cartesian3.fromDegrees( parseFloat( point.longitude ), parseFloat( point.latitude ) );

	var barrierRadius = 5.0;
	try {
		barrierRadius = parseFloat( barrierRadius = jQuery("#barrierRadius").val() );
	} catch ( error ) {
		// use default
	}
	
	var barrier = viewer.entities.add({
		name : 'ROTA_BARRREIRA_PONTO',
	    position : bpPos,
	    ellipse: {
	        semiMajorAxis: barrierRadius,
	        semiMinorAxis: barrierRadius,
	        material: new Cesium.StripeMaterialProperty({
	            evenColor : Cesium.Color.GOLD.withAlpha(0.5),
	            oddColor : Cesium.Color.BLACK.withAlpha(0.4),
	            repeat : 15.0,
	        }),	        
            stRotation : Cesium.Math.toRadians(45)	            
	    }
	});	
	
	var bp = { "latitude" : point.latitude, "longitude" : point.longitude, "uuid" : uuid, "alcance" : barrierRadius, "barrier" : barrier };
	
	barrierPoints.push( bp );
	addToPanelBarrierPoint( bp );
	
	recalculateAllRoutes();
}

function addToPanelBarrierPoint( bp ) {
	var uuid = bp.uuid;
	var latitude = bp.latitude;
	var longitude = bp.longitude;
	var alcance = bp.alcance;
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable"><i class="fa fa-ban"></i> &nbsp; <b>Bloqueio de Rota</b>' +
	'<a title="Apagar Bloqueio" href="#" onClick="deleteBarrier(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td class="layerTable">Latitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+latitude  +'</td></tr>';
	table = table + '<tr><td class="layerTable">Longitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+longitude+'</td></tr>';
	table = table + '<tr><td class="layerTable">Alcance</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+alcance+' metros</td></tr>';
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;"><button onclick="gotoBarrier(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';
	table = table + '</table></div>';
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	
	jQuery("#routesContainer").append( layerText );
	
	var count = jQuery('#routesContainer').children().length;
	jQuery("#routesCounter").html( count );	
	
	jQuery("#layerContainer").show( "slow" );
	
}

function calculateRoute() {
	hideRouteMenu();
	if ( startPoint === null ) return true;
	var endPoint = getLatLogFromMouse( routeMouseClickPosition );
	var data = {};	

	routePoints.push( startPoint );
	routePoints.push( endPoint );
	
	data.points = routePoints;
	
	var allowAlternatives = jQuery("#allowAlternatives").prop('checked');
	data.alternatives = allowAlternatives;
	
	data.blockedAreas = [];
	for ( x=0; x<barrierPoints.length; x++  ) {
		var bp = barrierPoints[x];
		data.blockedAreas.push( { "latitude" : bp.latitude, "longitude" : bp.longitude, "raio" : bp.alcance } );
	}
	
	startPoint = null;
	endPoint = null;
	
	var loadingId = createUUID();
    jQuery.ajax({
		url:"/computeroute", 
		type: "POST", 
		data: JSON.stringify( data ),
		beforeSend : function() { 
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Calculando rota...</td></tr>";
			jQuery("#routeMenuTable").append( loading );
		},
		success: function( obj ) {
			var theMessage;
			var tr = jQuery("#" + loadingId );
			
			viewer.entities.remove( clickedPointPin );
			if ( obj.paths ) {
				var routes = obj.paths;
				var geoJsonRoute = getAsGeoJson( routes );
				loadRoute( geoJsonRoute, data, true );
				theMessage = "Concluído";
			} else {
				theMessage = obj.message;
	    		tr.css("background-color","#FF3700");
			}
			
	    	jQuery("#" + loadingId + "_td" ).text( theMessage );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	        
		}, 
	    complete: function(xhr, textStatus) {
	    	//
	    }, 		
		dataType: "json",
		contentType: "application/json"
	});  	
	
}

function deleteRoute( uuid ) {
	console.log('Delete route ' + uuid );
	for ( y=0; y<routeResultLines.length; y++ ) {
		if( routeResultLines[y].uuid == uuid ) {

			viewer.entities.remove( routeResultLines[y].line );
			viewer.entities.remove( routeResultLines[y].m1 );
			viewer.entities.remove( routeResultLines[y].m2 );
			
			routeResultLines.splice(y, 1);
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#routesContainer').children().length;
				if ( count === 0 ) { jQuery("#routesCounter").html( '' ); } else { jQuery("#routesCounter").html( count ); }
			});
			
			return true;
		
		}
	}
}

function resetRoutesColor() {
	for ( y=0; y<routeResultLines.length; y++ ) {
		routeResultLines[ y ].line.polyline.material = routeColorActive;
	}
}


function gotoBarrier( uuid ) {
	for ( y=0; y<barrierPoints.length; y++ ) {
		if( barrierPoints[y].uuid == uuid ) {
			viewer.zoomTo( barrierPoints[y].barrier );
			return true;
		}
	}
}

function deleteBarrier( uuid ) {
	for ( y=0; y<barrierPoints.length; y++ ) {
		if( barrierPoints[y].uuid == uuid ) {
			viewer.entities.remove( barrierPoints[y].barrier );
			barrierPoints.splice(y, 1);
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#routesContainer').children().length;
				if ( count === 0 ) { jQuery("#routesCounter").html( '' ); } else { jQuery("#routesCounter").html( count ); }
			});		
			return true;
		}
	}
}

function gotoRoute( uuid ) {
	var selectedRouteView = null;
	for ( y=0; y<routeResultLines.length; y++ ) {
		if( routeResultLines[y].uuid == uuid ) {
			selectedRouteView = routeResultLines[ y ].line;
		}
		routeResultLines[ y ].line.polyline.material = routeColorActive;
	}

	if( selectedRouteView ){ 
		selectedRouteView.polyline.material = routeColorSelected;
		viewer.zoomTo( selectedRouteView );
	}
	
}

function showInstructions( uuid ) {
	for ( y=0; y<routeResultLines.length; y++ ) {
		if( routeResultLines[y].uuid == uuid ) {
			
			jQuery("#routeDetailContainer").empty( );
			jQuery("#routeContainer").show( 400 );
			
			routeInInstruction = uuid;
	
			var route = routeResultLines[y];
			var properties = route.line.properties;		
			var instructions = properties.instructions.getValue();
			
			for( x=0; x < instructions.length; x++  ) {
				var instruction = instructions[x];
				var directionId = createUUID();
				
				var interval0 = instruction.interval[0];
				var interval1 = instruction.interval[1];
				var heading = null;
				var last_heading = null;
				if( instruction.heading ) heading = instruction.heading; 
				if( instruction.last_heading ) last_heading = instruction.last_heading;
				
				var signImage = "<img style='height: 20px;' src='/resources/ggimg/" + getSignName( instruction.sign ) + ".png'>";
				
				var table = '<div indexPosition="'+interval0+'" class="table-responsive route_direction"><table class="table" style="margin-bottom: 0px;width:100%">'; 
				table = table + "<tr><td class='layerTable' style='width:6%;border-top: 0px;'>" + signImage + "</td><td style='border-top: 0px;padding: 0px 0px 0px 10px;'>" + instruction.text + "</td></tr>";
				
				var distancia = instruction.distance / 1000;
				
				if ( instruction.time > 0 ) {
					var duracao = instruction.time / 60000; // Milissegundos
					var durStr = "min";
					if( duracao > 60) {
						duracao = duracao / 60;
						durStr = "h"
					}
					table = table + "<tr><td colspan='2' class='layerTable'><div style='float:left'>" + duracao.toFixed(2) + durStr + "</div><div style='float:right'>" + distancia.toFixed(2) + "Km</div></td></tr>";
				}
				table = table + "</table></div>";

				var layerText = '<div style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' + table + '</div></div>';
				jQuery("#routeDetailContainer").append( layerText );				
			
			}
			
			jQuery('div.route_direction').bind('mouseenter', function() {
			    showMarker( jQuery(this).attr('indexPosition'), uuid );
			}).bind('mouseleave', function() {
				//
			});
			
			return true;
		}
	}	
}

function showMarker( indexPosition, uuid ) {
	for ( y=0; y<routeResultLines.length; y++ ) {
		if( routeResultLines[y].uuid == uuid ) {
			var positions = routeResultLines[y].line.polyline.positions.getValue();
			var position = positions[indexPosition];
			
			var cartographic = Cesium.Ellipsoid.WGS84.cartesianToCartographic(position);
			var longitude = Cesium.Math.toDegrees(cartographic.longitude);
			var latitude = Cesium.Math.toDegrees(cartographic.latitude);    	    
			
			if( lastWaypoint ) viewer.entities.remove( lastWaypoint );
			lastWaypoint = viewer.entities.add({
				name : 'ROTA_WAYPOINT',
			    position : position,
			    billboard :{
			        image : '/resources/img/marker.png',
		            pixelOffset : new Cesium.Cartesian2(0, -10),
		            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.0, 1.5e7, 0.5),
		            heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
		            disableDepthTestDistance : Number.POSITIVE_INFINITY            
			    }
			});	
			return true;
		}
	}
	
}


function exportRouteToPDF( uuid ) {
	console.log('Nao Implementado ' + uuid );
}

function exportDirectionsToPDF() {
	console.log('Nao Implementado ' + routeInInstruction );
}

function editRoute( uuid ) {
	hideRouteMenu();
	for ( y=0; y<routeResultLines.length; y++ ) {
		if( routeResultLines[y].uuid == uuid ) {
			var route = routeResultLines[y];
			var properties = route.line.properties;	
			editingRoute = true;
			routeBeingEdited.uuid = uuid;
			gotoRoute( uuid );
			routeBeingEdited.snappedWayPoints = properties.snappedWayPoints;
			bindEditRouteRightClick();
			return true;
		}
	}	
}

function hideRouteMenu() {
	jQuery("#contextMenuRouteInit").css({
		display:'none'
	});	
	jQuery("#contextMenuRecalcRoute").css({
		display:'none'
	});	
	
	jQuery("#btnEndRoute").addClass( "disabled" );
	if ( clickedPointPin ) viewer.entities.remove( clickedPointPin );
	resetRoutesColor();
}

function cancelRouteEditing() {
	editingRoute = false;
	routeBeingEdited = {};
	hideRouteMenu();
}


function chainReloadRoute( ) {
	if( routesToUpdate.length === 0 ) return true;
	var routeToUpdate = routesToUpdate[0];
	routesToUpdate.shift();
	for ( y=0; y<routeResultLines.length; y++ ) {
		if ( routeResultLines[y].uuid == routeToUpdate ) {
			var route = routeResultLines[y];
			ajaxReloadRoute( route );
			return true;
		}
	}	
}

function ajaxReloadRoute( route ) {
	var uuid = route.uuid;
	var data = route.data;
	var isPrimary = route.primary;

	if ( !isPrimary ) {
		deleteRoute( uuid );
		chainReloadRoute();
		return true;
	}
	
	data.blockedAreas = [];
	for ( x=0; x<barrierPoints.length; x++  ) {
		var bp = barrierPoints[x];
		data.blockedAreas.push( { "latitude" : bp.latitude, "longitude" : bp.longitude, "raio" : bp.alcance } );
	}	

	var allowAlternatives = jQuery("#allowAlternatives").prop('checked');
	data.alternatives = allowAlternatives;
	
	var loadingId = createUUID();
    jQuery.ajax({
		url:"/computeroute", 
		type: "POST", 
		data: JSON.stringify( data ),
		beforeSend : function() { 
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Calculando rota...</td></tr>";
			jQuery("#routeMenuTable").append( loading );
		},
		success: function( obj ) {
			var theMessage;
			var tr = jQuery("#" + loadingId );
			
			deleteRoute( uuid );
			
			if ( obj.paths ) {
				var routes = obj.paths;
				var geoJsonRoute = getAsGeoJson( routes );
				loadRoute( geoJsonRoute, data, false );
				theMessage = "Concluído";
			} else {
				theMessage = obj.message;
	    		tr.css("background-color","#FF3700");
			}
			
	    	jQuery("#" + loadingId + "_td" ).text( theMessage );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	        
			
			chainReloadRoute();
		}, 
	    complete: function(xhr, textStatus) {
	    	//
	    }, 		
		dataType: "json",
		contentType: "application/json"
	});  	
	
}

function recalculateAllRoutes( data ) {
	if ( routeResultLines.length === 0 ) return true;
	var totalRoutes = routeResultLines.length;
	routesToUpdate = [];
	for( y=0; y<totalRoutes;y++ ) {
		routesToUpdate.push( routeResultLines[y].uuid );
	}
	chainReloadRoute();
}

function doRecalculateRoute( data, mustDelete ) {
	
	console.log('Recalculate Route');
	
	var loadingId = createUUID();
    jQuery.ajax({
		url:"/computeroute", 
		type: "POST", 
		data: JSON.stringify( data ), 
		success: function( obj ) {
			var theMessage;
			var tr = jQuery("#" + loadingId );

			viewer.entities.remove( clickedPointPin );
			if ( obj.paths ) {
				if ( mustDelete != null ) deleteRoute( mustDelete ); 
				var routes = obj.paths;
				var geoJsonRoute = getAsGeoJson( routes );
				loadRoute( geoJsonRoute, data, false );
				theMessage = "Concluído";
			} else {
				theMessage = obj.message;
	    		tr.css("background-color","#FF3700");
			}
			
	    	jQuery("#" + loadingId + "_td" ).text( theMessage );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	
	        
		}, 
		beforeSend : function() { 
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Calculando rota...</td></tr>";
			jQuery("#routeMenuTable").append( loading );
		},
	    complete: function(xhr, textStatus) {
	    	//
	    }, 
	    dataType: "json",
		contentType: "application/json"
	});  		
	
}

function recalculateRoute( type ) {
	hideRouteMenu();
	if( !editingRoute ) return true;
	
	var mustDelete = null;
	
	// apaga a rota sendo editada se tiver mudando o ponto de origem ou destino
	if( editingRoute && ( ( type === 'start' ) || ( type === 'end' ) || ( type === 'addwaypoint' ) ) ) {
		mustDelete = routeBeingEdited.uuid;
		//deleteRoute( routeBeingEdited.uuid ); 
	}	
	
	var sp = routeBeingEdited.snappedWayPoints.getValue();
	clickPoint = getLatLogFromMouse( routeMouseClickPosition );
	jQuery("#contextMenuRecalcRoute").css({
		display:'none'
	});
	
	if ( clickedPointPin ) viewer.entities.remove( clickedPointPin );
	clickedPointPin = putMarker( Cesium.Cartesian3.fromDegrees( parseFloat( clickPoint.longitude ), parseFloat( clickPoint.latitude) ), 'pin-start.png' );	

	routePoints = [];
	middlePoints = [];

	var p1 = {};
	p1.latitude = sp[0][1];
	p1.longitude = sp[0][0];
	
	var p2 = {};
	p2.latitude = sp[sp.length -1][1] + "";
	p2.longitude = sp[sp.length -1 ][0] + "";
	
	if ( sp.length > 2 ) {
		for( xy=1; xy<sp.length-1; xy++ ) {
			console.log(" > " + xy );
			var pm = {};
			pm.latitude = sp[xy][1];
			pm.longitude = sp[xy][0];
			middlePoints.push( pm );
		}
	}
	
	if( type === 'addwaypoint' ) {
		middlePoints.push( clickPoint );
		routePoints.push( p1 );
		routePoints = routePoints.concat( middlePoints );
		routePoints.push( p2 );
	}
	if( type === 'start' ) {
		routePoints.push( clickPoint );
		routePoints.push( p2 );
	}
	if( type === 'end' ) {
		routePoints.push( p1 );
		routePoints.push( clickPoint );
	}
	if( type === 'derivate' ) {
		routePoints.push( p1 );
		routePoints.push( clickPoint );		
	}
	if( type === 'newstart' ) {
		routePoints.push( clickPoint );
		routePoints.push( p2 );		
	}
	
	data = {};
	data.points = routePoints;
	
	var allowAlternatives = jQuery("#allowAlternatives").prop('checked');
	data.alternatives = allowAlternatives;

	var blockingHasPrecedence = jQuery("#blockRoutePrecedence").prop('checked');
	data.blockedAreas = [];
	if ( blockingHasPrecedence ) {
		for ( x=0; x<barrierPoints.length; x++  ) {
			var bp = barrierPoints[x];
			data.blockedAreas.push( { "latitude" : bp.latitude, "longitude" : bp.longitude, "raio" : bp.alcance } );
		}	
	}
	
	startPoint = null;
	endPoint = null;
	
	cancelRouteEditing();
	bindRouteRightClick();
	doRecalculateRoute( data, mustDelete );
}

function bindEditRouteRightClick() {
	
	mainEventHandler.setInputAction(function ( e ) {
		var position = e.position;
		routeMouseClickPosition = position;
		
		jQuery("#contextMenuRecalcRoute").css({
			top: position.y + 5, 
			left: position.x + 5, 
			display:'block'
		});
		
	}, Cesium.ScreenSpaceEventType.RIGHT_CLICK);

	mainEventHandler.setInputAction(function ( e ) {
		cancelRouteEditing();
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);			
	
}


function addToPanelRoute( route ) {
	var uuid = route.uuid;
	var properties = route.line.properties;
	var dist = parseFloat( properties.distance ) / 1000;
	var tempo = ( parseFloat( properties.time ) / 1000 ) / 3600 ;
	var primary = "Primária";
	if ( !route.primary ) {
		primary = "Alternativa";
	}
	
	var positions = route.line.polyline.positions.getValue();
	
	var l1 = getLatLogFromCartesian( positions[0] );
	var l2 = getLatLogFromCartesian( positions[ positions.length -1 ] );
	
	var p1 = convertDMS( parseFloat( l1.latitude ), parseFloat( l1.longitude ) ) ;
	var p2 = convertDMS( parseFloat( l2.latitude ), parseFloat( l2.longitude ) ) ;
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable"><i class="fa fa-map-signs"></i> &nbsp; <b>Rota '+primary+'</b>' +
	'<a title="Apagar Rota" href="#" onClick="deleteRoute(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'<a title="Exibir Instruções" style="margin-right: 10px;" href="#" onClick="showInstructions(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-arrow-circle-o-left"></i></a>' + 
	'<a title="Editar Rota" style="margin-right: 10px;" href="#" onClick="editRoute(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-edit"></i></a>' + 
	'<a title="Exportar Para PDF" style="margin-right: 10px;" href="#" onClick="exportRouteToPDF(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-file-pdf-o"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td class="layerTable">Distância</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+dist.toFixed(2)  +' Km</td></tr>';
	table = table + '<tr><td class="layerTable">Tempo</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+tempo.toFixed(2)+' Horas</td></tr>';
	table = table + '<tr><td class="layerTable">Origem</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+ p1.lat + ' ' + p1.latCard + ', ' + p1.lon + ' ' + p1.lonCard +'</td></tr>';
	
	table = table + '<tr><td class="layerTable">Destino</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+ p2.lat + ' ' + p2.latCard + ', ' + p2.lon + ' ' + p2.lonCard +'</td></tr>';

	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;">' + 
		'<img title="Localizar Hospitais" class="poiicon" src="/resources/pois/hospital-button.png" onclick="getPoi(\''+uuid+'\', \'HOSP\');">' + 
		'<img title="Sem Função" class="poiicon" src="/resources/pois/obras-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/rodoviaria-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/gasolina-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/airport-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/port-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/railway-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/helipad-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/estadio-button.png" >' +
		'<img title="Sem Função" class="poiicon" src="/resources/pois/police-button.png" >' +
	'</td></tr>';
	
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;"><button onclick="gotoRoute(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';
	table = table + '</table></div>';
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#routesContainer").append( layerText );
	
	var count = jQuery('#routesContainer').children().length;
	jQuery("#routesCounter").html( count );	
	
	jQuery("#layerContainer").show( "slow" );
	
}

function showRotaPoi( entity ) {
	var theName = entity.properties.name;
	var distance = parseFloat(entity.properties.distance);
	var operator = entity.properties.operator;
	var tipo = entity.properties.tipo;
	
	var poiData = "<tr id='poidataDetails'>" +
			   "<td class='layerTable'>" + theName + "</td>" +
			   "<td style='text-align: right;' class='layerTable'>" + distance.toFixed(2) + "m</td>" +
			"</tr>";
	try{
		jQuery("#poidataDetails").remove();
	} catch ( error ) { /*ignored*/ }
    jQuery("#queryMenuTable").append( poiData );
}

function receivePois( features ) {
	if( !features ) return true;
	
	for( x=0; x< features.length; x++ ) {
		var feature = features[x];
		var featureType = feature.geometry.type;
		var coordinates = feature.geometry.coordinates;
		var properties = feature.properties; 
		var position = Cesium.Cartesian3.fromDegrees(coordinates[0], coordinates[1]);
		var type = properties.tipo;

		var icon = "/resources/pois/hospital-button.png";

		var entity = viewer.entities.add({
			name : 'ROTA_POI',
			properties : properties,
		    position : position,
		    billboard :{
		        image : icon,
	            pixelOffset : new Cesium.Cartesian2(0, -10),
	            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.6, 1.5e7, 0.2),
	            heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
	            disableDepthTestDistance : Number.POSITIVE_INFINITY            
		    }
		});
			
	}
	
}

function getPoi( uuid, type ) {
	var criteria = "";
	var source = "";
    switch ( type ) {
    case 'HOSP':
        criteria = "amenity = 'hospital' or amenity = 'clinic' or tags->'healthcare'='clinic'";
        source = 'planet_osm_point';
        break;
    }
	
	if( criteria === "" ) return true;
	
	for ( y=0; y<routeResultLines.length; y++ ) {
		if( routeResultLines[y].uuid == uuid ) {
			
			var positions = routeResultLines[y].line.polyline.positions.getValue();
			var routeAsWKT = "LINESTRING(";
			var virg = "";
			
			for( xx=0; xx < positions.length;xx++ ) {
				var position = positions[xx];
				var latLon = getLatLogFromCartesian( position );
				var newCoord = latLon.longitude + " " + latLon.latitude;
				routeAsWKT = routeAsWKT + virg + newCoord;
				virg = ",";
			}
			routeAsWKT = routeAsWKT + ")";

			var data = {};
			data.routegeom = routeAsWKT;
			data.criteria = criteria;
			data.source = source;
			data.distance = 500;
			data.type = type;
			
			var loadingId = createUUID();
			
		    jQuery.ajax({
				url:"/getpoi", 
				type: "POST", 
				data: JSON.stringify(data),
				beforeSend : function( obj) {
					var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
		            "<div class='progress progress-sm active'>" +
		            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
		            "</div></div>" + 		
					"Procurando Pontos de Interesse...</td></tr>";
					jQuery("#routeMenuTable").append( loading );
				},
				success: function( obj ) {
					var theMessage;
					var tr = jQuery("#" + loadingId );					
					if ( obj.features ) {
						theMessage = "Concluído. " + obj.features.length + " pontos encontrados.";
						
						receivePois( obj.features );
						
					} else {
						theMessage = obj.message;
			    		tr.css("background-color","#FF3700");
					}
			    	jQuery("#" + loadingId + "_td" ).text( theMessage );
			        tr.fadeOut(5000, function(){
			            tr.remove();
			        });	        
				},
			    complete: function(xhr, textStatus) {
			    	//
			    }, 		
				dataType: "json",
				contentType: "application/json"		
		    });
			
			return true;
		}
	}
	
	
}

function loadRoute( geoJsonRoute, data, canGoTo ) {
	
	var promise = Cesium.GeoJsonDataSource.load( geoJsonRoute );
	
	promise.then(function(dataSource) {
		var entities = dataSource.entities.values;
		var routeColor = 0;
		var lastCoordinates = null;
		
		for (var i = 0; i < entities.length; i++) {
			var entity = entities[i];
			var positions = entity.polyline.positions.getValue();
			lastCoordinates = positions;
			
			var properties = entity.properties;
			routeColor = i;
			var isPrimary = true;
			if ( i > 0 ) isPrimary = false;
			
			if( routeColor > 2 ) routeColor = 2;
			
			var m1 = putMarker( positions[0], 'pin-start.png' );
			var m2 = putMarker( positions[ positions.length - 1 ], 'pin-end.png' );
			
			var line = viewer.entities.add({
				name : 'ROTA',
				properties : properties,
				polyline : {
			    	positions : positions,
		            material : routeColorActive,			    	
			    	clampToGround : true,
			    	width: 13,
			    	disableDepthTestDistance : Number.POSITIVE_INFINITY
			    }
			});
			
			
			var route = {};
			route.line = line;
			route.uuid = createUUID();
			route.m1 = m1;
			route.m2 = m2;
			route.primary = isPrimary;
			route.data = data;
			
			routeResultLines.push( route );	
			addToPanelRoute( route );
			
		}

		//if( canGoTo ) viewer.zoomTo( routeResultLines[ routeResultLines.length -1 ].line );
		
		console.log('TESTE: Follow Route : Sensor de exposição na rota DESATIVADO.')
		// Esta funcao esta no arquivo flightcontrol.js 
		// followRoute( lastCoordinates );

		
		dataSource = null;
	});
		
}


function putMarker( thePosition, icon ) {
	
	var entity = viewer.entities.add({
		name : 'ROTA_PINO',
	    position : thePosition,
	    billboard :{
	        image : '/resources/img/' + icon,
            pixelOffset : new Cesium.Cartesian2(0, -10),
            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.6, 1.5e7, 0.2),
            heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
            disableDepthTestDistance : Number.POSITIVE_INFINITY            
	    }
	});
	
	return entity;
	
}

function putHaste( thePosition, color, icon ) {
	// projectPosition( Cartesian, height, latOffset, lonOffset )
	var position = projectPosition( thePosition, 2000, 0.0, 0.0 );
	thePosition = projectPosition( thePosition, 0, 0.0, 0.0 ); 
	
	var entity = viewer.entities.add({
		name : 'ROTA_HASTE',
	    position : position,
	    billboard :{
	        image : '/resources/img/' + icon,
            pixelOffset : new Cesium.Cartesian2(0, -32),
            disableDepthTestDistance : Number.POSITIVE_INFINITY            
	        
	    },
	    polyline : {
	        positions : [thePosition, position],
	        width : 3,
	        material : Cesium.Color.DARKGRAY,
	    }
	    
	});	
	
	return entity;
}

function putPoint( thePosition ) {
	
	var point = viewer.entities.add({
		name : 'ROTA_PONTO',
    	position : thePosition,
		point : {
	    	clampToGround : true,
            pixelSize : 8,
            color : Cesium.Color.BROWN,
            outlineColor : Cesium.Color.YELLOW,
            outlineWidth : 3,		    	
	    }
	});
	return point;
}


function getAsGeoJson( geoms ) {
	var geoJsonObj = {};
	geoJsonObj.type = "FeatureCollection";
	geoJsonObj.features = [];
	for( x=0; x < geoms.length; x++ ) {
		var feature = {};
		feature.type = "Feature";
		feature.geometry = geoms[x].points;
		feature.properties = {};
		feature.properties.instructions = geoms[x].instructions;
		feature.properties.time = geoms[x].time;  // <<--- Milissegundos
		feature.properties.distance = geoms[x].distance; // <<--- Metros
		feature.properties.snappedWayPoints = geoms[x].snapped_waypoints.coordinates; // <<--- Inicio e Fim determinados pelo GraphHopper
		geoJsonObj.features.push( feature );
	}
	
	return geoJsonObj;
}
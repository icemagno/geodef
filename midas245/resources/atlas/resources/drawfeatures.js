var drawedPolygons = [];
var drawedLines = [];
var drawedPoints = [];
var radares = [];

function deletePolygon( uuid ) {
	for ( y=0; y<drawedPolygons.length; y++ ) {
		if( drawedPolygons[y].uuid == uuid ) {

			viewer.entities.remove( drawedPolygons[y].polygon );
			drawedPolygons.splice(y, 1);
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#drawedObjectsContainer').children().length;
				if ( count === 0 ) { jQuery("#drawedCounter").html( '' ); } else { jQuery("#drawedCounter").html( count ); }
			});			
			return true;
		
		}
	}
}

function deleteLine( uuid ) {
	
	for ( y=0; y<drawedLines.length; y++ ) {
		if( drawedLines[y].uuid == uuid ) {
			viewer.entities.remove( drawedLines[y].polyline );
			drawedLines.splice(y, 1);
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#drawedObjectsContainer').children().length;
				if ( count === 0 ) { jQuery("#drawedCounter").html( '' ); } else { jQuery("#drawedCounter").html( count ); }
			});			
			return true;
		
		}
	}
}

function deletePoint( uuid ) {
	for ( y=0; y<drawedPoints.length; y++ ) {
		if( drawedPoints[y].uuid == uuid ) {

			viewer.entities.remove( drawedPoints[y].point );
			drawedPoints.splice(y, 1);
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#drawedObjectsContainer').children().length;
				if ( count === 0 ) { jQuery("#drawedCounter").html( '' ); } else { jQuery("#drawedCounter").html( count ); }
			});			
			return true;
		
		}
	}
}

function changeMouseToHand() {
	jQuery('.cesium-viewer').awesomeCursor('hand-o-down', {
		outline: 'white',
		size: 20,
		hotspot: [10, 20],
	});
}	

function gotoPolygon( uuid ) {
	for ( y=0; y<drawedPolygons.length; y++ ) {
		if( drawedPolygons[y].uuid == uuid ) {
			viewer.zoomTo( drawedPolygons[y].polygon );
			return true;
		}
	}
}

function updateDrawData( viewModel ) {
	jQuery("#"+viewModel.uuid+"_AL").text( viewModel.polygon.polygon.height + "m" );
	jQuery("#"+viewModel.uuid+"_AU").text( viewModel.polygon.polygon.extrudedHeight + "m" );
}

function plusValueDF( uuid, who, what ) {
	
	if( who === 'POL' ) {
		for ( y=0; y<drawedPolygons.length; y++ ) {
			if( drawedPolygons[y].uuid == uuid ) {
				var polygon = drawedPolygons[y].polygon.polygon;
				
				if ( what === 'ALT' ) {
					polygon.height += 1;
					polygon.extrudedHeight +=1;
				}
				if ( what === 'ALU' ) {
					polygon.extrudedHeight +=1;
				}
				
				
				updateDrawData( drawedPolygons[y] );
				return true;
			}
		}
	}
	
}

function minusValueDF( uuid, who, what ) {
	
	if( who === 'POL' ) {
		for ( y=0; y<drawedPolygons.length; y++ ) {
			if( drawedPolygons[y].uuid == uuid ) {
				var polygon = drawedPolygons[y].polygon.polygon;
				var height = polygon.height -1;
				var extrudedHeight = polygon.extrudedHeight -1;
				
				if( height < 0 ) return true;
				if( extrudedHeight <= height ) return true;
				
				if ( what === 'ALT' ) {
					polygon.height = height;
					polygon.extrudedHeight = extrudedHeight;
				}
				if ( what === 'ALU' ) {
					polygon.extrudedHeight = extrudedHeight;
				}
				
				updateDrawData( drawedPolygons[y] );
				return true;
			}
		}
	}	
}

function gotoLine( uuid ) {
	for ( y=0; y<drawedLines.length; y++ ) {
		if( drawedLines[y].uuid == uuid ) {
			viewer.zoomTo( drawedLines[y].polyline );
			return true;
		}
	}	
}

function gotoPoint( uuid ) {
	for ( y=0; y<drawedPoints.length; y++ ) {
		if( drawedPoints[y].uuid == uuid ) {
			viewer.zoomTo( drawedPoints[y].point );
			return true;
		}
	}	
}


function hoverPoint( uuid ) {
	for ( y=0; y<drawedPoints.length; y++ ) {
		if( drawedPoints[y].uuid == uuid ) {
			
			//flight( drawedPoints[y].latitude, drawedPoints[y].longitude );
			hover( drawedPoints[y].latitude, drawedPoints[y].longitude );
			
			return true;
		}
	}	
}


function putRadar( uuid ) {
	for ( y=0; y<drawedPoints.length; y++ ) {
		if( drawedPoints[y].uuid == uuid ) {
			var radar = new Radar( drawedPoints[y].longitude, drawedPoints[y].latitude, drawedPoints[y].height, 0, 2000, false );
			radar.init();
			addRadarToPanel( radar );
			return true;
		}
	}	
}


function putDrone( uuid ) {
	for ( y=0; y<drawedPoints.length; y++ ) {
		if( drawedPoints[y].uuid == uuid ) {
			addDroneToPanel( );
	    	var drone = simulator( drawedPoints[y].longitude, drawedPoints[y].latitude, drawedPoints[y].height + 5000 );
			
			/*
            var cartographicCenter = new Cesium.Cartographic( Cesium.Math.toRadians(drawedPoints[y].longitude), Cesium.Math.toRadians(drawedPoints[y].latitude), 0 );
            var scanColor = Cesium.Color.LIMEGREEN;			
			addRadarScanPostStage(viewer, cartographicCenter, 1500, scanColor, 4000);
			*/
			
			
			return true;
		}
	}	
}


function addDroneToPanel( ){
	var uuid = createUUID();
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa fa-plane"></i> &nbsp; <b>Drone</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<a title="Apagar" href="#" onClick="deleteDrone(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;">Funcionalidade Experimental</td></tr>';	
	table = table + '<tr><td class="layerTable"><b>W</b></td><td colspan="2" class="layerTable" style="text-align: right;">Inicia Movimento</td></tr>';	
	table = table + '<tr><td class="layerTable"><b>S</b></td><td colspan="2" class="layerTable" style="text-align: right;">Interrompe Movimento</td></tr>';	
	table = table + '<tr><td class="layerTable"><b>Seta Para Cima</b></td><td colspan="2" class="layerTable" style="text-align: right;">Sobe</td></tr>';	
	table = table + '<tr><td class="layerTable"><b>Seta Para Baixo</b></td><td colspan="2" class="layerTable" style="text-align: right;">Desce</td></tr>';	
	table = table + '<tr><td class="layerTable"><b>Seta Para Direita</b></td><td colspan="2" class="layerTable" style="text-align: right;">Direita</td></tr>';	
	table = table + '<tr><td class="layerTable"><b>Seta Para Esquerda</b></td><td colspan="2" class="layerTable" style="text-align: right;">Esquerda</td></tr>';	
	table = table + '<tr><td colspan="3" class="layerTable"><div style="width:100%;height:170px;border:1px solid #cacaca;" id="secondCamera"></div></td></tr>';	
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table +	'</div></div>';
	
	jQuery("#viewshedResultsContainer").append( layerText );
	var count = jQuery('#viewshedResultsContainer').children().length;
	jQuery("#viewshedCounter").html( count );				
	jQuery("#layerContainer").show( "slow" );
	
}


function addRadarToPanel( radar ){
	var theRadar = {};
	theRadar.uuid = createUUID();
	theRadar.radar = radar;
	radares.push( theRadar );
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa fa-wifi"></i> &nbsp; <b>Radar</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<a title="Apagar" href="#" onClick="deleteRadar(\''+theRadar.uuid+'\');" class="text-red pull-right"><i class="fa fa-trash"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;">Funcionalidade Experimental</td></tr>';	
	
	var layerText = '<div id="'+theRadar.uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table +	'</div></div>';
	
	
	jQuery("#viewshedResultsContainer").append( layerText );
	var count = jQuery('#viewshedResultsContainer').children().length;
	jQuery("#viewshedCounter").html( count );				
	jQuery("#layerContainer").show( "slow" );
	
}


function deleteDrone( uuid ){
	stopSimulation();
	jQuery("#" + uuid).fadeOut(400, function(){
		jQuery("#" + uuid).remove();
		var count = jQuery('#viewshedResultsContainer').children().length;
		if ( count === 0 ) { jQuery("#viewshedCounter").html( '' ); } else { jQuery("#viewshedCounter").html( count ); }
	});
}

function deleteRadar( uuid ){
	for ( y=0; y<radares.length; y++ ) {
		if( radares[y].uuid == uuid ) {
			radares[y].radar.destroy();
			radares.splice(y, 1);
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#viewshedResultsContainer').children().length;
				if ( count === 0 ) { jQuery("#viewshedCounter").html( '' ); } else { jQuery("#viewshedCounter").html( count ); }
			});
			return true;
		}
	}
}


function showStreetImage( entity ){
	var url = entity.properties.url;
	var uuid = 'xyz12';
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa fa-image"></i> &nbsp; <b>Foto de Localidade</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<a title="Apagar" href="#" onClick="deleteStreetPhoto(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td class="layerTable">Latitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">xxx</td></tr>';
	table = table + '<tr><td class="layerTable">Longitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">xxx</td></tr>';
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;"><img src="'+url+'" style="border:1px solid #3c8dbc;width:100%;height:110px" id="pict' + uuid + '"></td></tr>';
	
	table = table + '</table></div>';
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';
	
	jQuery("#drawedObjectsContainer").append( layerText );
}

function getStreetImages( uuid ) {
	for ( y=0; y<drawedPoints.length; y++ ) {
		if( drawedPoints[y].uuid == uuid ) {
			var longitude = drawedPoints[y].longitude;
			var latitude = drawedPoints[y].latitude;
			var loadingId = createUUID();
		    jQuery.ajax({
				url:"/getImagesNearTo", 
				type: "GET", 
				data: { 'center' : longitude + ',' + latitude, 'radius' : 600, 'perpage' : 700},
				beforeSend : function() {

					var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
		            "<div class='progress progress-sm active'>" +
		            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
		            "</div></div>" + 		
					"Adquirindo Imagens...</td></tr>";
					jQuery("#drawMenuTable").append( loading );
					
					
				},
				error: function( obj ) {
					var tr = jQuery("#" + loadingId );
					tr.css("background-color","#FF3700");
			    	jQuery("#" + loadingId + "_td" ).text( 'Erro ao adquirir imagens.' );
			        tr.fadeOut(5000, function(){
			            tr.remove();
			        });	  					
				},
				success: function( obj ) {
					var theMessage;
					var tr = jQuery("#" + loadingId );
					
					if( obj.features ) {
						theMessage = "Concluído";
						var sequenceKeys = [];
							
						for( xx = 0; xx < obj.features.length; xx++ ) {
							var coordinates = obj.features[xx].geometry.coordinates;
							var key = obj.features[xx].properties.key;
							var sequence_key = obj.features[xx].properties.sequence_key;
							var imgUrl = "https://images.mapillary.com/"+key+"/thumb-320.jpg";
							
							var isPresent = sequenceKeys.includes( sequence_key );
							console.log( sequence_key + " " + isPresent );
							
							
							if ( !isPresent ) {
								sequenceKeys.push( sequence_key ); 
								
								var thePosition = Cesium.Cartesian3.fromDegrees(coordinates[0], coordinates[1]);
								var position = projectPosition( thePosition, 50, 0.0003, 0.0 );
								var entity = viewer.entities.add({
									properties : {
										url : imgUrl 
									},
									name : 'PHOTO_HASTE',
								    position : position,
								    billboard :{
								        image : imgUrl,
								        //scale : 0.1,
							            pixelOffset : new Cesium.Cartesian2(0, -5),
							            disableDepthTestDistance : Number.POSITIVE_INFINITY, 
							            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.2, 1.5e7, 0.4),
								    },
								    polyline : {
								        positions : [thePosition, position],
								        width : 2,
								        material : Cesium.Color.GREEN,
								    }
								    
								});
							}	
														
						}
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


function addToPanelLine( viewModel ) {
	var uuid = viewModel.uuid;

	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa fa-expand"></i> &nbsp; <b>Linha Desenhada</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<ul style="margin: 0px;" class="list-inline">' + 
	'<li><a href="#" onClick="deleteLine(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash"></i></a></li>' + 
	'</ul></td></tr>'; 
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;"><button onclick="gotoLine(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';
	
	table = table + '</table></div>';

	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#drawedObjectsContainer").append( layerText );

	var count = jQuery('#drawedObjectsContainer').children().length;
	jQuery("#drawedCounter").html( count );				
	
	jQuery("#layerContainer").show( "slow" );
	
}

function closeDrawToolBarMenu() {
	jQuery("#drawMenuBox").hide();
	restore();
}


function addToPanelPoint( viewModel ) {
	var uuid = viewModel.uuid;

	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa fa-circle"></i> &nbsp; <b>Ponto Desenhado</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<a title="Apagar Ponto" href="#" onClick="deletePoint(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash"></i></a>' + 
	'<a title="[EXPERIMENTAL] Sobrevoar" style="margin-right: 10px;" href="#" onClick="hoverPoint(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-plane"></i></a>' + 
	'<a title="[EXPERIMENTAL] Posicionar Radar" style="margin-right: 10px;" href="#" onClick="putRadar(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-wifi"></i></a>' + 
	'<a title="[EXPERIMENTAL] Posicionar Drone" style="margin-right: 10px;" href="#" onClick="putDrone(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-plane"></i></a>' + 
	//'<a title="[EXPERIMENTAL] Imagens Locais" style="margin-right: 10px;" href="#" onClick="getStreetImages(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-image"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td class="layerTable">Latitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+viewModel.latitude.toFixed(10)+'</td></tr>';
	table = table + '<tr><td class="layerTable">Longitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+viewModel.longitude.toFixed(10)+'</td></tr>';
	
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;"><button onclick="gotoPoint(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';
	
	table = table + '</table></div>';
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	
	jQuery("#drawedObjectsContainer").append( layerText );
	
	var count = jQuery('#drawedObjectsContainer').children().length;
	jQuery("#drawedCounter").html( count );				
	
	jQuery("#layerContainer").show( "slow" );
	
}


function addToPanelPoly( viewModel, draped ) {
	
	var uuid = viewModel.uuid;
	var height = viewModel.polygon.polygon.height; // <-- VieweModel.Entity.Polygon.Height
	var extrudedHeight = viewModel.polygon.polygon.extrudedHeight;
	
	var dim = "fa-object-group"; 
	var dimS = "3D";
	if ( draped ) {
			dim = "fa-clone";
			dimS = "2D";
	}
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa '+dim+'"></i> &nbsp; <b>Polígono ' + dimS + ' Desenhado</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	'<ul style="margin: 0px;" class="list-inline">' + 
	'<li><a title="Apagar Polígono" href="#" onClick="deletePolygon(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash"></i></a></li>' + 
	'</ul></td></tr>'; 
	
	if ( !draped ) {
		table = table + '<tr><td style="width: 100px;" class="layerTable">Altitude (Base)</td>'+
		'<td id="'+uuid+'_AL" class="layerTable" style="text-align: right;width: 70px;">'+height+'m</td><td style="text-align:right" class="layerTable">' + 
		'<a title="Menos Altitude" href="#" onClick="minusValueDF(\''+uuid+'\',\'POL\',\'ALT\');" class="text-light-blue pull-right"><i class="fa fa-minus"></i></a>' + 
		'<a title="Mais Altitude" style="margin-right: 10px;" href="#" onClick="plusValueDF(\''+uuid+'\',\'POL\',\'ALT\');" class="text-light-blue pull-right"><i class="fa fa-plus"></i></a></td></tr>';
		
		
		table = table + '<tr><td style="width: 100px;" class="layerTable">Teto</td>'+
		'<td id="'+uuid+'_AU" class="layerTable" style="text-align: right;width: 70px;">'+extrudedHeight+'m</td><td style="text-align:right" class="layerTable">' + 
		'<a title="Menos Altura" href="#" onClick="minusValueDF(\''+uuid+'\',\'POL\',\'ALU\');" class="text-light-blue pull-right"><i class="fa fa-minus"></i></a>' + 
		'<a title="Mais Altura" style="margin-right: 10px;" href="#" onClick="plusValueDF(\''+uuid+'\',\'POL\',\'ALU\');" class="text-light-blue pull-right"><i class="fa fa-plus"></i></a></td></tr>';
		
	}

	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;"><button onclick="gotoPolygon(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';

	table = table + '</table></div>';
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#drawedObjectsContainer").append( layerText );
	var count = jQuery('#drawedObjectsContainer').children().length;
	jQuery("#drawedCounter").html( count );				
	jQuery("#layerContainer").show( "slow" );
	
}


function drawPolygon( draped ) {
	var handler = new Cesium.DrawHandler( viewer,Cesium.DrawMode.Polygon, Cesium.ClampMode.Ground );
	changeMouseToHand();
	handler.activate();
	
	handler.drawEvt.addEventListener( function( result ){
		var polygonTemp = result.object.polygon;
		
		var polygon = null;
		if ( draped ) {
			polygon = viewer.entities.add({
			    polygon : {
			    	hierarchy : polygonTemp.hierarchy,
			    	material : Cesium.Color.INDIANRED,
			    	clampToGround : true
			    }
			});
		} else {
			polygon = viewer.entities.add({
			    polygon : {
			    	hierarchy : polygonTemp.hierarchy,
			    	height : 0,
			    	extrudedHeight : 50,
			    	material : Cesium.Color.INDIANRED, 
			    	outlineColor : Cesium.Color.BLACK,
			    	fill : true
			    }
			});
		}
			
		var thePolygon = {};
		thePolygon.uuid = createUUID();
		thePolygon.polygon = polygon; // <-- Eh Entity

		drawedPolygons.push( thePolygon );
        
		addToPanelPoly( thePolygon, draped );
		
		handler.clear();
	    restore();

	});	

	mainEventHandler.setInputAction(function ( movement ) {
		changeMouseToHand();
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	

}


function drawPoint() {
	
	var handler = new Cesium.DrawHandler( viewer,Cesium.DrawMode.Point, Cesium.ClampMode.Ground );
	handler.activate();
	changeMouseToHand();
	
	handler.drawEvt.addEventListener(function(result){

		var tempPoint = result.object;
	    
		var point = viewer.entities.add({
			name : 'POINT_DRAWN',
	    	position : tempPoint.position,
			point : {
		    	clampToGround : true,
	            pixelSize : 8,
	            color : Cesium.Color.BROWN,
	            outlineColor : Cesium.Color.YELLOW,
	            outlineWidth : 3,	
	            disableDepthTestDistance : Number.POSITIVE_INFINITY
		    }
		});
		
		var cartographic = Cesium.Cartographic.fromCartesian(tempPoint.position);
		var longitude = Cesium.Math.toDegrees(cartographic.longitude);
		var latitude = Cesium.Math.toDegrees(cartographic.latitude);
		var height = cartographic.height + 1.8;
		point.position = Cesium.Cartesian3.fromDegrees(longitude, latitude, height);

		//var longitudeString = longitude.toFixed(10);
		//var latitudeString = latitude.toFixed(10);    		
		
		var thePoint = {};
		thePoint.uuid = createUUID();
		thePoint.point = point; 
		thePoint.longitude = longitude;
		thePoint.latitude = latitude;
		thePoint.height = height;

		drawedPoints.push( thePoint );
		addToPanelPoint( thePoint );
		
		handler.clear();
	    restore();	    
	    
	    
	    
	    
	});	

	mainEventHandler.setInputAction(function ( movement ) {
		changeMouseToHand();
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	
}


function drawMarker() {
	
	// Nao achei funcionalidade para isso ...
	
	/*
	var handler = new Cesium.DrawHandler( viewer,Cesium.DrawMode.Marker, Cesium.ClampMode.Ground );
	handler.activate();
	changeMouseToHand();

	
	handler.drawEvt.addEventListener(function(result){
	    console.log(result); 
	    restore();
	});	

	
	mainEventHandler.setInputAction(function ( movement ) {
		changeMouseToHand();
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	*/
	
}

function restore() {
    jQuery('.cesium-viewer').css('cursor', '');
	mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	addMouseHoverListener();
}

function drawLine() {
	var handler = new Cesium.DrawHandler( viewer, Cesium.DrawMode.Line, Cesium.ClampMode.Ground );
	handler.activate();
	changeMouseToHand();

	handler.drawEvt.addEventListener(function(result){
		var tempPolyline = result.object;
	    
		var line = viewer.entities.add({
			polyline : {
		    	positions : tempPolyline.positions,
		    	material : Cesium.Color.INDIANRED,
		    	clampToGround : true,
		    	width: 2
		    }
		});
		
	
		var theLine = {};
		theLine.uuid = createUUID();
		theLine.polyline = line; 

		drawedLines.push( theLine );
		addToPanelLine( theLine );
		
		handler.clear();
	    restore();	    
    
	});	
	
	mainEventHandler.setInputAction(function ( movement ) {
		changeMouseToHand();
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	
	
}
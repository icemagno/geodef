
var drawingWhat = null;
var viewShedsOnMap = [];
var viewshed3D = null;
var pointHandler = null;

function addVSToPanel( viewModel ) {
	
	viewShedsOnMap.push( viewModel );
	
	var uuid = viewModel.uuid;
	var viewshed3D = viewModel.viewshed3D;

	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa fa-eye"></i> &nbsp; <b>Domínio de Terreno</b></td>' +
	'<td class="layerTable" style="width:90px;text-align: right;">' + 
	'<a title="Apagar" href="#" onClick="deleteVS(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'<a title="Posicionar Câmera no Ponto de Observação" style="margin-right: 10px;" href="#" onClick="lookAt(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-binoculars"></i></a></td></tr>'; 

	table = table + '<tr><td class="layerTable">Latitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+viewModel.latitude+'</td></tr>';
	table = table + '<tr><td class="layerTable">Longitude</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+viewModel.longitude+'</td></tr>';

	table = table + '<tr><td style="width: 100px;" class="layerTable">Direção</td>'+
	'<td id="'+uuid+'_DR" class="layerTable" style="text-align: right;width: 70px;">'+viewModel.direction.toFixed(0)+'\xB0</td><td style="text-align:right" class="layerTable">' + 
	'<a title="Menos" href="#" onClick="diminuiValor(\''+uuid+'\',\'DIR\');" class="text-light-blue pull-right"><i class="fa fa-minus"></i></a>' + 
	'<a title="Mais" style="margin-right: 10px;" href="#" onClick="somaValor(\''+uuid+'\',\'DIR\');" class="text-light-blue pull-right"><i class="fa fa-plus"></i></a></td></tr>';


	table = table + '<tr><td class="layerTable">Distância</td>'+
	'<td id="'+uuid+'_DI" class="layerTable" style="text-align: right;">'+viewModel.distance.toFixed(2)+'m</td><td style="text-align:right" class="layerTable">' + 
	'<a title="Menos" href="#" onClick="diminuiValor(\''+uuid+'\',\'DIST\');" class="text-light-blue pull-right"><i class="fa fa-minus"></i></a>' + 
	'<a title="Mais" style="margin-right: 10px;" href="#" onClick="somaValor(\''+uuid+'\',\'DIST\');" class="text-light-blue pull-right"><i class="fa fa-plus"></i></a></td></tr>';

	table = table + '<tr><td class="layerTable">Altitude</td>'+
	'<td id="'+uuid+'_HG" class="layerTable" style="text-align: right;">'+viewModel.height.toFixed(2)+'m</td><td style="text-align:right" class="layerTable">' + 
	'<a title="Menos" href="#" onClick="diminuiValor(\''+uuid+'\',\'HEIGHT\');" class="text-light-blue pull-right"><i class="fa fa-minus"></i></a>' + 
	'<a title="Mais" style="margin-right: 10px;" href="#" onClick="somaValor(\''+uuid+'\',\'HEIGHT\');" class="text-light-blue pull-right"><i class="fa fa-plus"></i></a></td></tr>';
	
	
	table = table + '<tr><td class="layerTable">F.O.V. Vertical</td>'+
	'<td id="'+uuid+'_VF" class="layerTable" style="text-align: right;">'+viewModel.verticalFov+'\xB0</td><td style="text-align:right" class="layerTable">' + 
	'<a title="Menos" href="#" onClick="diminuiValor(\''+uuid+'\',\'VFOV\');" class="text-light-blue pull-right"><i class="fa fa-minus"></i></a>' + 
	'<a title="Mais" style="margin-right: 10px;" href="#" onClick="somaValor(\''+uuid+'\',\'VFOV\');" class="text-light-blue pull-right"><i class="fa fa-plus"></i></a></td></tr>';


	table = table + '<tr><td class="layerTable">F.O.V. Horizontal</td>'+
	'<td id="'+uuid+'_HF" class="layerTable" style="text-align: right;">'+viewModel.horizontalFov+'\xB0</td><td style="text-align:right" class="layerTable">' + 
		'<a title="Menos" href="#" onClick="diminuiValor(\''+uuid+'\',\'HFOV\');" class="text-light-blue pull-right"><i class="fa fa-minus"></i></a>' + 
		'<a title="Mais" style="margin-right: 10px;" href="#" onClick="somaValor(\''+uuid+'\',\'HFOV\');" class="text-light-blue pull-right"><i class="fa fa-plus"></i></a></td></tr>';
	
	
	table = table +	'</table></div>';

	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table +	'</div></div>';

	jQuery("#viewshedResultsContainer").append( layerText );
	var count = jQuery('#viewshedResultsContainer').children().length;
	jQuery("#viewshedCounter").html( count );				
	jQuery("#layerContainer").show( "slow" );

}


function updateVSData( viewModel ) {
	jQuery("#"+viewModel.uuid+"_DR").text( viewModel.direction.toFixed(0) + "\xB0" );
	jQuery("#"+viewModel.uuid+"_HG").text( viewModel.height.toFixed(2) + "m" );
	jQuery("#"+viewModel.uuid+"_HF").text( viewModel.horizontalFov + "\xB0" );
	jQuery("#"+viewModel.uuid+"_DI").text( viewModel.distance.toFixed(2) + "m" );
	jQuery("#"+viewModel.uuid+"_VF").text( viewModel.verticalFov + "\xB0" );
}

function diminuiValor( uuid, what ) {

	for ( y=0; y<viewShedsOnMap.length; y++ ) {
		if( viewShedsOnMap[y].uuid == uuid ) {
			var vs3d = viewShedsOnMap[y].viewshed3D;
			if ( !vs3d ) return true;
			
			if( what == 'DIR' ) {
				var dd = vs3d.direction - 1;
				if( dd < 0 ) { dd = 359 };
				vs3d.direction = dd; 
				viewShedsOnMap[y].direction = dd; 
			}
			if( what == 'DIST' ) {
				vs3d.distance -= 1; 
				viewShedsOnMap[y].distance -= 1;
			}
			if( what == 'VFOV' ) {
				var vf = vs3d.verticalFov -1;
				if ( vf == 0 ) return true;
				vs3d.verticalFov = vf;
				viewShedsOnMap[y].verticalFov = vf;
			}
			if( what == 'HFOV' ) {
				var hf = vs3d.horizontalFov -1;
				if ( hf == 0 ) return true;
				vs3d.horizontalFov = hf; 
				viewShedsOnMap[y].horizontalFov = hf;
			}
			if( what == 'HEIGHT'  ) {
				var longitude = parseFloat( viewShedsOnMap[y].longitude ); 
				var latitude = parseFloat( viewShedsOnMap[y].latitude );
				var height = parseFloat( viewShedsOnMap[y].height - 1 );
				vs3d.viewPosition = [longitude, latitude, height];
				viewShedsOnMap[y].height -= 1;
			}
			
			updateVSData( viewShedsOnMap[y] );
		}	
	}
	
}

function somaValor( uuid, what ) {
	for ( y=0; y<viewShedsOnMap.length; y++ ) {
		if( viewShedsOnMap[y].uuid == uuid ) {
			var vs3d = viewShedsOnMap[y].viewshed3D;
			if ( !vs3d ) return true;
			
			if( what == 'DIR' ) {
				var dd = vs3d.direction + 1;
				if( dd  > 360 ) { dd = 1 };
				vs3d.direction = dd; 
				viewShedsOnMap[y].direction = dd; 
			}
			if( what == 'DIST' ) {
				vs3d.distance += 1; 
				viewShedsOnMap[y].distance += 1;
			}
			if( what == 'VFOV' ) {
				vs3d.verticalFov += 1; 
				viewShedsOnMap[y].verticalFov += 1;
			}
			if( what == 'HFOV' ) {
				vs3d.horizontalFov += 1; 
				viewShedsOnMap[y].horizontalFov += 1;
			}
			if( what == 'HEIGHT'  ) {
				var longitude = parseFloat( viewShedsOnMap[y].longitude ); 
				var latitude = parseFloat( viewShedsOnMap[y].latitude );
				var height = parseFloat( viewShedsOnMap[y].height + 1 );
				vs3d.viewPosition = [longitude, latitude, height];	
				viewShedsOnMap[y].height += 1;
			}
			updateVSData( viewShedsOnMap[y] );
		}	
	}
}


function lookAt( uuid ) {
	for ( y=0; y<viewShedsOnMap.length; y++ ) {
		if( viewShedsOnMap[y].uuid == uuid ) {
			var obj = viewShedsOnMap[y];
			var vs3d = obj.viewshed3D;
			
			var longitude = parseFloat( obj.longitude ); 
			var latitude = parseFloat( obj.latitude );
			var height = parseFloat( obj.height );	
			var pitch = parseFloat( vs3d.pitch );
			var direction = parseFloat( vs3d.direction );
			
			viewer.camera.flyTo({
			    destination : Cesium.Cartesian3.fromDegrees( longitude, latitude, height),
			    orientation : {
			        heading : Cesium.Math.toRadians( direction ),
			        pitch : Cesium.Math.toRadians( pitch ),
			        roll : 0.0
			    }
			});
			
		}
		
	}
}

function deleteVS( uuid ) {
	
	
	for ( y=0; y<viewShedsOnMap.length; y++ ) {
		if( viewShedsOnMap[y].uuid == uuid ) {
			
			if ( viewShedsOnMap[y].viewshed3D ) viewShedsOnMap[y].viewshed3D.destroy();
			if ( viewShedsOnMap[y].pointHandler ) viewShedsOnMap[y].pointHandler.clear();
			viewShedsOnMap.splice(y, 1);

			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#viewshedResultsContainer').children().length;
				if ( count === 0 ) { jQuery("#viewshedCounter").html( '' ); } else { jQuery("#viewshedCounter").html( count ); }
			});			
			
			return true;
			
		}	
	}
	
	
}

function bindEscKey() {
	jQuery(document).keyup(function(e) {
		if (e.key === "Escape") {
			if( drawingWhat === 'VIEWSHED' ) cancelViewShedTool();
			drawingWhat = null;
		}
	});		
}

function cancelViewShedTool() {
	// Restaura o evento de mouse original ( elementos de tela )
	addMouseHoverListener();
	// Deletar o viewshed.... 
	//if( viewshed3D ) viewshed3D.destroy();
	//if ( pointHandler ) pointHandler.clear();
	
	viewshed3D = null;
	pointHandler = null;
	
}

function viewShed() {
	viewshed3D = null;
	pointHandler = null;
	drawingWhat = 'VIEWSHED'; 
	
	bindEscKey();
	
	var newUuid = createUUID();
	
	var viewModel = {
		direction: 1.0,
		pitch: 1.0,
		distance: 1.0,
		verticalFov: 1.0,
		horizontalFov: 1.0,
		visibleAreaColor: '#ffffffff',
		invisibleAreaColor: '#ffffffff',
		uuid : newUuid,
		viewshed3D : null,
		pointHandler : null
	};		
	
	
	pointHandler = new Cesium.DrawHandler(viewer, Cesium.DrawMode.Point);
	viewshed3D = new Cesium.ViewShed3D(scene);
	scene.viewFlag = true;
	var viewPosition = null;
	
	viewshed3D.hintLineColor = Cesium.Color.ORANGE; 
	viewshed3D.hiddenAreaColor = Cesium.Color.ORANGERED.withAlpha(0.2); 
	viewshed3D.visibleAreaColor = Cesium.Color.LIME.withAlpha(0.2); 
	
	pointHandler.drawEvt.addEventListener(function (result) {
		var point = result.object;
		var position = point.position;
		viewPosition = position;

		var cartographic = Cesium.Cartographic.fromCartesian(position);
		var longitude = Cesium.Math.toDegrees(cartographic.longitude);
		var latitude = Cesium.Math.toDegrees(cartographic.latitude);
		var height = cartographic.height + 1.8;
		point.position = Cesium.Cartesian3.fromDegrees(longitude, latitude, height);

		var longitudeString = longitude.toFixed(10);
		var latitudeString = latitude.toFixed(10);    	    
		
		
		if (scene.viewFlag) {
			viewshed3D.viewPosition = [longitude, latitude, height];
			viewshed3D.build();
			scene.viewFlag = false;
			viewModel.longitude = longitudeString;
			viewModel.latitude = latitudeString;
			viewModel.height = height;
		}
	});	
	
	
	mainEventHandler.setInputAction(function (e) {
		if (!scene.viewFlag) {
			var position = e.endPosition;
			var last = scene.pickPosition(position);
			
			var distance = Cesium.Cartesian3.distance(viewPosition, last);
			if (distance > 0) {
				var cartographic = Cesium.Cartographic.fromCartesian(last);
				var longitude = Cesium.Math.toDegrees(cartographic.longitude);
				var latitude = Cesium.Math.toDegrees(cartographic.latitude);
				var height = cartographic.height;
				viewshed3D.setDistDirByPoint([longitude, latitude, height]);
			}
			
		}
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);				
		
	
	mainEventHandler.setInputAction(function (e) {
		scene.viewFlag = true;
		viewModel.direction = viewshed3D.direction;
		viewModel.pitch = viewshed3D.pitch;
		viewModel.distance = viewshed3D.distance;
		viewModel.horizontalFov = viewshed3D.horizontalFov;
		viewModel.verticalFov = viewshed3D.verticalFov;
		viewModel.viewshed3D = viewshed3D;
		viewModel.pointHandler = pointHandler;
		addVSToPanel( viewModel );
		// Restaura o evento de mouse original ( elementos de tela )
		addMouseHoverListener();
		// Cancela o evento do botao direito.
		mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.RIGHT_CLICK);
	}, Cesium.ScreenSpaceEventType.RIGHT_CLICK);				
		
	pointHandler.activate();
	
} 



function getMethods(obj) {
	  
	  for (var id in obj) {
	    try {
	      if ( typeof(obj[id]) == "function" ) {
	        console.log( id + ": " + obj[id].toString() );
	      }
	    } catch (err) {
	      console.log( id + ": inaccessible" );
	    }
	  }
	  
}
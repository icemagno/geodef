
var terrainSamplePositions = [];
var buildingsDataSources = [];

function deleteOsmBuildings( uuid ) {
	for ( y=0; y<buildingsDataSources.length; y++ ) {
		if( buildingsDataSources[y].uuid == uuid ) {
			viewer.dataSources.remove( buildingsDataSources[y].dataSource );
			buildingsDataSources.splice(y, 1);
			
			jQuery("#" + uuid).fadeOut(400, function(){
				jQuery("#" + uuid).remove();
				var count = jQuery('#diversosContainer').children().length;
				if ( count === 0 ) { jQuery("#diversosCounter").html( '' ); } else { jQuery("#diversosCounter").html( count ); }
			});			
			
			
			return true;
		}
	}
}

function gotoBuildings( uuid ) {
	
	for ( y=0; y<buildingsDataSources.length; y++ ) {
		if( buildingsDataSources[y].uuid == uuid ) {
			viewer.zoomTo( buildingsDataSources[y].dataSource );
		}
	}
}

function restore() {
    jQuery('.cesium-viewer').css('cursor', '');
	mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	addMouseHoverListener();
}

function changeMouseToHand() {
	jQuery('.cesium-viewer').awesomeCursor('hand-o-down', {
		outline: 'white',
		size: 20,
		hotspot: [10, 20],
	});
}	

function getBuildings() {
	changeMouseToHand();
	var handlerDis = new Cesium.MeasureHandler( viewer, Cesium.MeasureMode.Distance, Cesium.ClampMode.Ground );
	handlerDis.enableDepthTest = true;
	
	handlerDis.activate();

	mainEventHandler.setInputAction(function (e) {
		var pl = handlerDis.polyline;
		if( !pl ) return;
		
		var p1 = Cesium.Cartographic.fromCartesian( pl.positions[0] );
		var p2 = Cesium.Cartographic.fromCartesian( pl.positions[1] );

		var lonp1 = Cesium.Math.toDegrees( p1.longitude );
		var latp1 = Cesium.Math.toDegrees( p1.latitude );
		
		var lonp2 = Cesium.Math.toDegrees( p2.longitude );
		var latp2 = Cesium.Math.toDegrees( p2.latitude );

        handlerDis.deactivate();
		restore();
		handlerDis.clear();
		removeMouseClickListener();
		
		var l = lonp1;
		var b = latp2;
		
		var r = lonp2;
		var t = latp1;
		
		if( l < r ) {
			tt = r;
			r = l;
			l = tt;
		}
		
		if( b < t ) {
			tt = b;
			b = t;
			t = tt;
		}

		var url = "/buildings?l="+l+"&t="+t+"&r="+r+"&b="+b+"&count=5000";
		drawBuildings( url );
		
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);	
	
}


function drawBuildings( source ) {
	var loadingId = createUUID();
	var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
    "<div class='progress progress-sm active'>" +
    "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
    "</div></div>" + 		
	"<spam id='vsTableInfo'>Recebendo Construções...</spam></td></tr>";
	jQuery("#vsMenuTable").append( loading );
	
	
	var promise = Cesium.GeoJsonDataSource.load( source );
	promise.then(function(dataSource) {
		var ds = {};
		var uuid = createUUID();
		ds.uuid = uuid;
		ds.dataSource = dataSource;
		buildingsDataSources.push( ds );

		jQuery("#vsTableInfo").text('Analisando...');
		
		viewer.dataSources.add( dataSource );
		//viewer.zoomTo( dataSource );
		var entities = dataSource.entities.values;
		for (var i = 0; i < entities.length; i++) {
			var entity = entities[i];
			var height = parseFloat( entity.properties['height'].getValue() );
	        var position = entity.polygon.hierarchy.getValue().positions[0];
	        terrainSamplePositions.push( Cesium.Cartographic.fromCartesian(position) );			
		}
		
	    Cesium.when(Cesium.sampleTerrainMostDetailed( viewer.terrainProvider, terrainSamplePositions ), function() {
	        for (var i = 0; i < entities.length; i++) {
	    		jQuery("#vsTableInfo").text('Processando ' + i);
	            var entity = entities[i];
	            var terrainHeight = terrainSamplePositions[i].height;
	            entity.polygon.height = terrainHeight;
	            var height = parseFloat( entity.properties['height'].getValue() );
	            var extrudeVal = height + terrainHeight;
		        entity.polygon.material = Cesium.Color.LIGHTSEAGREEN;
		        entity.polygon.outlineColor = Cesium.Color.BLACK;
		        entity.polygon.fill = true;
		        entity.polygon.height = 0;
		        entity.polygon.extrudedHeight = extrudeVal;		            
	        }
	        
	        
	        jQuery("#"+ loadingId +"_td").text( 'Concluído.' );
	        jQuery("#"+ loadingId).fadeOut(5000, function(){
	        	jQuery("#"+ loadingId).remove();
	        });
	        
	    });
	    
		var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
		'<tr style="border-bottom:2px solid #3c8dbc"><td class="layerTable"><i class="fa fa-home"></i> &nbsp; <b>Construções 3D OpenStreeMap</b></td>' +
		'<td class="layerTable" style="text-align: right;">' + 
		'<ul style="margin: 0px;" class="list-inline">' + 
		'<li><a href="#" onClick="deleteOsmBuildings(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a></li>' + 
		'</ul></td></tr>'; 
		
		table = table + '<tr><td class="layerTable">Construções</td>'+
		'<td  class="layerTable" style="text-align: right;">'+entities.length+'</td></tr>';
		
		table = table + '<tr><td colspan="2" class="layerTable" style="text-align: right;"><button onclick="gotoBuildings(\''+uuid+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Localizar</button></td></tr>';

		
		table = table +	'</table></div>';

		var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
		table +
		'</div></div>';

		jQuery("#diversosContainer").append( layerText );
		jQuery("#layerContainer").show( "slow" );
		jQuery("#sysLayerPanel").prop( "checked", true );		

		var count = jQuery('#diversosContainer').children().length;
		if ( count === 0 ) { jQuery("#diversosCounter").html( '' ); } else { jQuery("#diversosCounter").html( count ); }
		
		
	}).otherwise(function(error){
		jQuery("#"+ loadingId).css("background-color","#FF3700");
        jQuery("#"+ loadingId +"_td").text( 'Nenhuma Construção nesta Área.' );
        jQuery("#"+ loadingId).fadeOut(5000, function(){
        	jQuery("#"+ loadingId).remove();
        });
	});
	
}


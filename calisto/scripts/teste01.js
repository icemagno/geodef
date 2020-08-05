function run(){
	
	var url = "http://sisgeodef.defesa.mil.br:36215/pointcloud?l=-46.66499&b=-23.63099&r=-46.66300&t=-23.62900&count=500000";
	var promise = Cesium.GeoJsonDataSource.load( url );
	promise.then(function( dataSource ) {
		var entities = dataSource.entities.values;
		if( entities != null ){
			var terrainSamplePositions = [];
			var points = viewer.scene.primitives.add( new Cesium.PointPrimitiveCollection() );
			var minAlt = 99999;
			for (var i = 0; i < entities.length; i++) {
				var entity = entities[i];
				var position = entity.position._value;
				var cartesian = Cesium.Cartesian3.fromElements( position.x, position.y, position.z );
				
				try {
					terrainSamplePositions.push( Cesium.Cartographic.fromCartesian( cartesian ) );
					var cartographic = Cesium.Cartographic.fromCartesian( cartesian );
			    	var longitude = Cesium.Math.toDegrees(cartographic.longitude);
			    	var latitude = Cesium.Math.toDegrees(cartographic.latitude);
			    	var height = cartographic.height;
					
					var data = entity.properties['data'].getValue();
					var intensity = data[0];
					var zNorm = ( intensity - 292) / (1164 - 292) ;
					if( zNorm < 0 ) zNorm = 0;
					
					if( height < minAlt ) minAlt = height;
					
			        var position = cartesian;
					points.add({
					  position : position,
					  pixelSize: 1.0,
					  color : Cesium.Color.GAINSBORO.withAlpha( zNorm ),
					  //heightReference: Cesium.HeightReference.CLAMP_TO_GROUND,
				      //disableDepthTestDistance: Number.POSITIVE_INFINITY,				  
				      //translucencyByDistance : new Cesium.NearFarScalar(1.5e2, 1.0, 8.0e6, 0.0),
					}).customId = [longitude, latitude, height];
			    	
				} catch (e) {
					console.log( e );
				}				
				
			}
			
			console.log( "Altura mínima: " + minAlt );
			
	        Cesium.when(Cesium.sampleTerrainMostDetailed( viewer.terrainProvider, terrainSamplePositions ), function() {
				
		        for (var i = 0; i < terrainSamplePositions.length; i++) {
		            //var cartographic = terrainSamplePositions[i];
					//var terrainHeight = cartographic.height;
					var height = points.get(i).customId[2];
		        	
					var newHeight = ( height - minAlt ) + 1;
					
					var newPosition = Cesium.Cartesian3.fromDegrees( points.get(i).customId[0], points.get(i).customId[1], newHeight );	

					points.get(i).position = newPosition;
		            
		            
		        }
		    });
			
			

		} else {
			console.log( "Erro" );
		}
		
	}).otherwise(function(error){
		console.log( error );
	});
	
	
}	
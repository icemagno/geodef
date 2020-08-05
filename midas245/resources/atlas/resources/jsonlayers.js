
function drawBox() {
	
	var outlineOnly = viewer.entities.add({
	    name : 'Yellow box outline',
	    position: Cesium.Cartesian3.fromDegrees(-43.5647040303, -22.5056940557, 3000.0),
	    box : {
	        dimensions : new Cesium.Cartesian3(5000.0, 5000.0, 5000.0),
	        fill : false,
	        outline : true,
	        outlineColor : Cesium.Color.YELLOW
	    }
	});	
	viewer.zoomTo( outlineOnly );
}





function teste() {
		var url = "http://sisgeodef.defesa.mil.br:36212/geoserver/odisseu/wms?service=WMS&version=1.1.0&request=GetMap&layers=odisseu%3Aalteracao_fisiografica_antropica_a&bbox=-44.2477722167969%2C-23.0004043579102%2C-41.0677490234375%2C-19.9946517944336&width=768&height=725&srs=EPSG%3A4326&format=application%2Fjson%3Btype%3Dtopojson";
		//var url = "http://sisgeodef.defesa.mil.br:36212/geoserver/odisseu/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=odisseu%3Aalteracao_fisiografica_antropica_a&maxFeatures=50&outputFormat=application%2Fjson";
	
		Cesium.GeoJsonDataSource.clampToGround = true;
		
		var promise = Cesium.GeoJsonDataSource.load( url, { clampToGround : true } );
	    promise.then(function(dataSource) {
	    	
	        viewer.dataSources.add(dataSource);
	        viewer.zoomTo(dataSource);
	        
	        
	        //Get the array of entities
	        var entities = dataSource.entities.values;

	        var colorHash = {};
	        for (var i = 0; i < entities.length; i++) {
	            //For each entity, create a random color based on the state name.
	            //Some states have multiple entities, so we store the color in a
	            //hash so that we use the same color for the entire state.
	            var entity = entities[i];
	            var name = entity.nome;
	            var color = colorHash[name];
	            if (!color) {
	                color = Cesium.Color.fromRandom({
	                    alpha : 1.0
	                });
	                colorHash[name] = color;
	            }

	            //Set the polygon material to our random color.
	            entity.polygon.material = color;
	            //Remove the outlines.
	            entity.polygon.outline = false;

	            //Extrude the polygon based on the state's population.  Each entity
	            //stores the properties for the GeoJSON feature it was created from
	            //Since the population is a huge number, we divide by 50.
	            entity.polygon.extrudedHeight = 50;
	        }
	    }).otherwise(function(error){
	        //Display any errrors encountered while loading.
	        window.alert(error);
	    });

	
	
	
}


function drawFavelas() {
	var dataSource = new Cesium.GeoJsonDataSource();
	var promise = Cesium.GeoJsonDataSource.load('/resources/data/favelas.json');
	promise.then(function(dataSource) {
		var entities = dataSource.entities.values;
		for (var i = 0; i < entities.length; i++) {
			var entity = viewer.entities.add({
			    polygon : {
			    	hierarchy : entities[i].polygon.hierarchy.getValue(),
			    	material : Cesium.Color.INDIANRED.withAlpha(0.6),
			    	clampToGround : true
			    }
			});	
		}
	}).otherwise(function(error){
		//
	});
}


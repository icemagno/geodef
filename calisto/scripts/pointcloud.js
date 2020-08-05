function run()

	var url = "http://sisgeodef.defesa.mil.br:36215/pointcloud?l={l}&r={r}&t={t}&b={b}";
	var cloudProvider = new MagnoPointCloudProvider({
		debugTiles : false,
		viewer : viewer,
		activationLevel : 17,
		tileWidth : 256,
		tileHeight : 256,
		sourceUrl : url,
		featuresPerTile : 2000,
		whenFeaturesAcquired : function( entities ){
			console.log( entities.length + " points received." );
		}
	});
	viewer.imageryLayers.addImageryProvider( cloudProvider );
	
}
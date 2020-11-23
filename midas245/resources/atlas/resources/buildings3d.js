var isOsmBuildingsActive = false;


function getBuildings() {
	
	var url = "/buildings?l={l}&r={r}&t={t}&b={b}";

	var buildingsProvider = new MagnoBuildingsProvider({
		debugTiles : false,
		viewer : viewer,
		activationLevel : 17,
		sourceUrl : url,
		featuresPerTile : 100,
		whenFeaturesAcquired : function( entities ){
			console.log( entities.length + " buildings received." );
		}
	});
	
	viewer.imageryLayers.addImageryProvider( buildingsProvider );
	
}



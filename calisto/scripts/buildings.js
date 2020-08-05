function run(){

	var url = "http://sisgeodef.defesa.mil.br:36215/buildings?l={l}&r={r}&t={t}&b={b}";

	var buildingsProvider = new MagnoBuildingsProvider({
	  debugTiles : false,
	  viewer : viewer,
	  activationLevel : 17,
	  sourceUrl : url,
	  featuresPerTile : 200,
	  whenFeaturesAcquired : function( entities ){
		console.log( entities.length + " buildings received." );
	  }
	});

	viewer.imageryLayers.addImageryProvider( buildingsProvider );

}	
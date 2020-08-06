function run(){
	console.log('Marine Traffic Provider Loaded!');

	var magnoMarineTrafficProvider = new MagnoMarineTrafficProvider({
		debugTiles : true,
		activationLevel : 7,
		whenFeaturesAcquired : function( entities ){
			console.log( entities.length + " buildings received." );
		}
	});

	viewer.imageryLayers.addImageryProvider( magnoMarineTrafficProvider );

	
}

$( document ).ready(function() {
	run();
});


function run(){
	console.log('Marine Traffic Provider Loaded!');

	var magnoMarineTrafficProvider = new MagnoMarineTrafficProvider({
		whenFeaturesAcquired : function( shipPackageData ){
			if( shipPackageData.ships.length > 0 ) console.log( shipPackageData );
		}
	});

	viewer.imageryLayers.addImageryProvider( magnoMarineTrafficProvider );

	
}

$( document ).ready(function() {
	run();
});


var isOsmBuildingsActive = false;
var buildingsLayer = null;
var buildingsProvider = null;

function cancelOsmBuildings(){
	isOsmBuildingsActive = false;
	$("#toolOSM3D").removeClass("btn-danger");
	$("#toolOSM3D").addClass("btn-warning");
	buildingsProvider.flushData();
	viewer.imageryLayers.remove( buildingsLayer, true );
	buildingsLayer = null;
}


function startOsmBuildings(){
	if( isOsmBuildingsActive ){
		cancelOsmBuildings();
	} else {
		isOsmBuildingsActive = true;
		$("#toolOSM3D").addClass("btn-danger");
		$("#toolOSM3D").removeClass("btn-warning");
		getBuildings();
	}
}


function getBuildings() {

	var url = "/buildings?l={l}&r={r}&t={t}&b={b}";
	buildingsProvider = new MagnoBuildingsProvider({
		debugTiles : false,
		viewer : viewer,
		activationLevel : 17,
		sourceUrl : url,
		featuresPerTile : 100,
		whenFeaturesAcquired : function( entities ){
			console.log( entities.length + " buildings received." );
		}
	});
	buildingsLayer = viewer.imageryLayers.addImageryProvider( buildingsProvider );
}



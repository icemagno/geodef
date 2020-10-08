
var baselayerCollection = [];
var currentBaseLayerAlphaValue = 1;

function doChangeBaseLayer( layerName ){
	var newProvider = baselayerCollection[ layerName ];
	var layers = viewer.imageryLayers;
	var currentProvider = layers.get(0);
	layers.remove( currentProvider );
	layers.addImageryProvider( newProvider, 0 );
	newProvider.alpha = currentBaseLayerAlphaValue;
}

function initControlSideBar(){

	populateBaseLayerCollection();

	$("#mainLayerSlider").slider({});
	$("#mainLayerSlider").on("slide", function(slideEvt) {
		var valu = slideEvt.value / 100;
		viewer.imageryLayers.get(0).alpha = valu;
		currentBaseLayerAlphaValue = valu;
	});	
	
	$("#optionsRadios1").click( function(){
		doChangeBaseLayer('osm');
	});

	$("#optionsRadios2").click( function(){
		doChangeBaseLayer('mosaico');
	});

	$("#optionsRadios3").click( function(){
		doChangeBaseLayer('rapideye');
	});

	$("#optionsRadios4").click( function(){
		doChangeBaseLayer('ortoimagens');
	});
	
};


function populateBaseLayerCollection(){
	baselayerCollection['mosaico'] = getProvider( mapproxy, 'bdgex', false, 'png' );
	baselayerCollection['rapideye'] = getProvider( mapproxy, 'rapideye', false, 'jpeg' );
	baselayerCollection['osm'] = baseOsmProvider;
	baselayerCollection['ortoimagens'] = getProvider( mapproxy, 'ortoimagens', false, 'png' );
}

function getProvider(  sourceUrl, sourceLayers, canQuery, imageType ) {
	if( !imageType ) imageType = 'png8';	
	var provider = createImageryProvider( sourceUrl, sourceLayers, canQuery, currentBaseLayerAlphaValue, imageType );
	return provider;
}

var jsonGlob = {};
var point = [];
var billboard = [];
var polyline = [];
var surface = [];
var volume = [];


function getPointAsGeoJson( points ) {

}

function exportLayerToPDF( uuid ) {
	for( x=0; x < stackedProviders.length;x++ ) {
		var ll = stackedProviders[x];
		if ( ll.uuid == uuid ) {
			console.log( ll.layer.properties );
			return;
		}
	}
}


function openMapCalisto(){
	window.open( "http://sisgeodef.defesa.mil.br:36280/pdf/" );
}

function exportStandardMap(){
	var uuid = createUUID();
	var promise =  scene.outputSceneToFile();
	Cesium.when(promise,function(base64data){
		var name = uuid;
		jQuery.ajax({
			type: "POST",
			url: "/createchart",
			data: {
				imgBase64: base64data,
				imgName : name
			}
		}).done(function(o) {
			window.open( o );
			
		});		
	});	
}


function exportAsKML() {
	Cesium.exportKml({
		entities: viewer.entities,
		//kmz: true
	})
	.then(function(result) {
		// The XML string is in result.kml
		// The XMZ string is in result.kmz

		var externalFiles = result.externalFiles
		for(var file in externalFiles) {
			console.log( file );
		}

		console.log( result.kml );  
		//downloadBlob('export.kmz', result.kmz);
	});	
}

function exportAll(  ) {

	jsonGlob = {"type" : "FeatureCollection", "features" : []};

	var features = [];

	for (var i = 0; i < point.length; i++) {

		var typePoint = {"type" : "Feature", "properties" : {}, "geometry" : {}};
		typePoint.geometry = {"type" : "Point", "coordinates" : {}};

		if( Cesium.defined(point[i].position._value) ) {
			// Convert coordinates from cartesian to degrees
			var cartesian = new Cesium.Cartesian3(point[i].position._value.x, point[i].position._value.y, point[i].position._value.z);
			var cartographic = Cesium.Cartographic.fromCartesian(cartesian);
			var longitude = Cesium.Math.toDegrees(cartographic.longitude);
			var latitude = Cesium.Math.toDegrees(cartographic.latitude);
			var z = cartographic.height;
			var coordXYZ = [Number(longitude), Number(latitude), Number(z)];

			// Adding wanted properties
			typePoint.properties.color = {};
			typePoint.properties.color.red = point[i].point.color._value.red;
			typePoint.properties.color.green = point[i].point.color._value.green;
			typePoint.properties.color.blue = point[i].point.color._value.blue;
			typePoint.properties.color.alpha = point[i].point.color._value.alpha;

			typePoint.properties.height = point[i].point.pixelSize._value;

			features.push(typePoint);
		}
	}

	for (i = 0; i < billboard.length; i++) {

		var typeBillboard = {"type" : "Feature", "properties" : {}, "geometry" : {}};
		typeBillboard.geometry = {"type" : "Point", "coordinates" : {}};

		if(Cesium.defined(billboard[i].position._value)) {
			var cartesianBil = new Cesium.Cartesian3(billboard[i].position._value.x, billboard[i].position._value.y, billboard[i].position._value.z);
			var cartographicBil = Cesium.Cartographic.fromCartesian(cartesianBil);
			var longitudeBil = Cesium.Math.toDegrees(cartographicBil.longitude);
			var latitudeBil = Cesium.Math.toDegrees(cartographicBil.latitude);
			var zBil = cartographicBil.height;
			var coordXYZBil = [Number(longitudeBil), Number(latitudeBil), Number(zBil)];

			typeBillboard.properties.height = billboard[i].billboard.height._value;
			typeBillboard.properties.image = billboard[i].billboard.image._value;

			typeBillboard.geometry.coordinates = coordXYZBil;
			features.push(typeBillboard);
		}
	}

	for (i = 0; i < polyline.length; i++) {
		var j = 0;

		var coordLine = [];
		var type = {"type" : "Feature", "properties" : {}, "geometry" : {}};
		type.geometry = {"type" : "LineString", "coordinates" : []};
		while (j < polyline[i].polyline.positions._value.length) {

			// Convert coordinates from cartesian to degrees
			var cartesianPol = new Cesium.Cartesian3(polyline[i].polyline.positions._value[j].x, polyline[i].polyline.positions._value[j].y, polyline[i].polyline.positions._value[j].z);
			var cartographicPol = Cesium.Cartographic.fromCartesian(cartesianPol);
			var longitudePol = Cesium.Math.toDegrees(cartographicPol.longitude);
			var latitudePol = Cesium.Math.toDegrees(cartographicPol.latitude);
			var coordXYPol = [Number(longitudePol), Number(latitudePol)];
			coordLine.push(coordXYPol);
			j++;
		}

		// add any properties
		type.properties.color = {};
		type.properties.color.red = polyline[i].polyline.material.color._value.red;
		type.properties.color.green = polyline[i].polyline.material.color._value.green;
		type.properties.color.blue = polyline[i].polyline.material.color._value.blue;
		type.properties.color.alpha = polyline[i].polyline.material.color._value.alpha;

		type.properties.width = polyline[i].polyline.width._value;

		type.geometry.coordinates = coordLine;
		features.push(type);
	}

	for (i = 0; i < surface.length; i++) {
		var k = 0;

		var coordSurf = [];
		var arraySurf = [];
		var typeSurf = {"type" : "Feature", "properties" : {}, "geometry" : {}};
		typeSurf.geometry = {"type" : "Polygon", "coordinates" : [[]]};
		while (k < surface[i].polygon.hierarchy._value.length) {

			var cartesianSurf = new Cesium.Cartesian3(surface[i].polygon.hierarchy._value[k].x, surface[i].polygon.hierarchy._value[k].y, surface[i].polygon.hierarchy._value[k].z);
			var cartographicSurf = Cesium.Cartographic.fromCartesian(cartesianSurf);
			var longitudeSurf = Cesium.Math.toDegrees(cartographicSurf.longitude);
			var latitudeSurf = Cesium.Math.toDegrees(cartographicSurf.latitude);
			var coordXYSurf = [Number(longitudeSurf), Number(latitudeSurf)];
			coordSurf.push(coordXYSurf);
			k++;
		}

		// adding first vertex once more to have a closed surface
		var cartesianSurfa = new Cesium.Cartesian3(volume[i].polygon.hierarchy._value[0].x, volume[i].polygon.hierarchy._value[0].y, volume[i].polygon.hierarchy._value[0].z);
		var cartographicSurfa = Cesium.Cartographic.fromCartesian(cartesianSurfa);
		var longitudeSurfa = Cesium.Math.toDegrees(cartographicSurfa.longitude);
		var latitudeSurfa = Cesium.Math.toDegrees(cartographicSurfa.latitude);
		var coordXYSurfa = [Number(longitudeSurfa), Number(latitudeSurfa)];
		coordSurf.push(coordXYSurfa);

		typeSurf.properties.color = {};
		typeSurf.properties.color.red = surface[i].polygon.material.color._value.red;
		typeSurf.properties.color.green = surface[i].polygon.material.color._value.green;
		typeSurf.properties.color.blue = surface[i].polygon.material.color._value.blue;
		typeSurf.properties.color.alpha = surface[i].polygon.material.color._value.alpha;

		arraySurf.push(coordSurf);
		typeSurf.geometry.coordinates = arraySurf;
		features.push(typeSurf);
	}

	for (i = 0; i < volume.length; i++) {
		var l = 0;

		var coordVol = [];
		var arrayVol = [];
		var typeVol = {"type" : "Feature", "properties" : {}, "geometry" : {}};
		typeVol.geometry = {"type" : "Polygon", "coordinates" : [[]]};
		while (l < volume[i].polygon.hierarchy._value.length) {

			var cartesianVol = new Cesium.Cartesian3(volume[i].polygon.hierarchy._value[l].x, volume[i].polygon.hierarchy._value[l].y, volume[i].polygon.hierarchy._value[l].z);
			var cartographicVol = Cesium.Cartographic.fromCartesian(cartesianVol);
			var longitudeVol = Cesium.Math.toDegrees(cartographicVol.longitude);
			var latitudeVol = Cesium.Math.toDegrees(cartographicVol.latitude);
			var coordXYVol = [Number(longitudeVol), Number(latitudeVol)];
			coordVol.push(coordXYVol);
			l++;
		}

		var cartesianVolu = new Cesium.Cartesian3(volume[i].polygon.hierarchy._value[0].x, volume[i].polygon.hierarchy._value[0].y, volume[i].polygon.hierarchy._value[0].z);
		var cartographicVolu = Cesium.Cartographic.fromCartesian(cartesianVolu);
		var longitudeVolu = Cesium.Math.toDegrees(cartographicVolu.longitude);
		var latitudeVolu = Cesium.Math.toDegrees(cartographicVolu.latitude);
		var coordXYVolu = [Number(longitudeVolu), Number(latitudeVolu)];
		coordVol.push(coordXYVolu);

		typeVol.properties.color = {};
		typeVol.properties.color.red = volume[i].polygon.material.color._value.red;
		typeVol.properties.color.green = volume[i].polygon.material.color._value.green;
		typeVol.properties.color.blue = volume[i].polygon.material.color._value.blue;
		typeVol.properties.color.alpha = volume[i].polygon.material.color._value.alpha;

		typeVol.properties.extrudedHeight = volume[i].polygon.extrudedHeight._value;

		arrayVol.push(coordVol);
		typeVol.geometry.coordinates = arrayVol;
		features.push(typeVol);
	}



	jsonGlob.features = features;


	var final = JSON.stringify(jsonGlob);
	console.log(final);
	// Download the final file

}
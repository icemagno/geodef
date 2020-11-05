
function exportPolygon( entity ){
	var k = 0;
	var coordSurf = [];
	var arraySurf = [];
	var typeSurf = {"type" : "Feature", "properties" : {}, "geometry" : {}};
	typeSurf.geometry = {"type" : "Polygon", "coordinates" : [[]]};
	
	while ( k < entity.polygon.hierarchy._value.length) {

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

	return typeSurf;
}
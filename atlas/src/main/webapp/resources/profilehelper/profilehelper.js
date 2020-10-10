

function doProfile( line, steps ){
	var segments = [];
    var positions = line.positions;
    var result = [];
	for( x=0; x < positions.length-1; x++ ){
		segments.push( processLineSegment( positions[x], positions[x+1], steps ) );
	}
    for( y=0; y < segments.length; y++ ){
    	var points = segments[y];
    	for( z=0; z < points.length; z++ ){
    		var point = points[z];
    		result.push( point );
    	}
	}
    return result; 
}


function processLineSegment( startPoint, endPoint, pointSum ){
    var scartographic = Cesium.Cartographic.fromCartesian(startPoint);
    var slongitude = Cesium.Math.toDegrees(scartographic.longitude);
    var slatitude = Cesium.Math.toDegrees(scartographic.latitude);
    //var sheight = scartographic.height;
    var ecartographic = Cesium.Cartographic.fromCartesian(endPoint);
    var elongitude = Cesium.Math.toDegrees(ecartographic.longitude);
    var elatitude = Cesium.Math.toDegrees(ecartographic.latitude);
    //var eheight = ecartographic.height;
    var addXTT = Cesium.Math.lerp(slongitude, elongitude, 1.0/pointSum) - slongitude;
    var addYTT = Cesium.Math.lerp(slatitude, elatitude, 1.0/pointSum) - slatitude;
    
    var p1;
    var result = [];
    for(var i = 0; i <= pointSum; i++){
        var longitude = slongitude + i * addXTT;
        var latitude = slatitude + i * addYTT;
        p1 = new Cesium.Cartesian3.fromDegrees(longitude, latitude);
        result.push( p1 );
    }
    return result;
}


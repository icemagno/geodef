
function projectPosition( thePosition, height, latOffset, lonOffset ) {
	var cartographic = Cesium.Cartographic.fromCartesian( thePosition );
	var longitude = Cesium.Math.toDegrees(cartographic.longitude);
	var latitude = Cesium.Math.toDegrees(cartographic.latitude);
	var newHeight = cartographic.height + height;
	var position = Cesium.Cartesian3.fromDegrees(longitude + lonOffset, latitude + latOffset, newHeight);	
	return position;
}


function getSignName(sign) {
    if (sign === -98)
        return "u_turn";
    else if (sign === -8)
        return "u_turn_left";
    else if (sign === -7)
        return "keep_left";
    else if (sign === -3)
        return "sharp_left";
    else if (sign === -2)
        return "left";
    else if (sign === -1)
        return "slight_left";
    else if (sign === 0)
        return "continue";
    else if (sign === 1)
        return "slight_right";
    else if (sign === 2)
        return "right";
    else if (sign === 3)
        return "sharp_right";
    else if (sign === 4)
        return "marker-icon-red";
    else if (sign === 5)
        return "marker-icon-blue";
    else if (sign === 6)
        return "roundabout";
    else if (sign === 7)
        return "keep_right";
    else if (sign === 8)
        return "u_turn_right";
    else if (sign === 101)
        return "pt_start_trip";
    else if (sign === 102)
        return "pt_transfer_to";
    else if (sign === 103)
        return "pt_end_trip";
    else
    // throw "did not find sign " + sign;
        return "unknown";
};



function color2(color){
	var red = parseInt(color.charAt(0) + color.charAt(1),16)/255.0;
	var green = parseInt(color.charAt(2) + color.charAt(3),16)/255.0;
	var blue = parseInt(color.charAt(4) + color.charAt(5),16)/255.0;

	return new Cesium.Color(red,green,blue);
}

function getRandomColor(){
	return "#"+("00000"+((Math.random()*16777215+0.5)>>0).toString(16)).slice(-6);
}

function getLatLogFromCartesian( cartesian ) {
	var result = {};
	var cartographic = Cesium.Cartographic.fromCartesian( cartesian );
	result.longitude = Cesium.Math.toDegrees(cartographic.longitude);
	result.latitude = Cesium.Math.toDegrees(cartographic.latitude);
	result.height = cartographic.height;
	return result;
}


function getLatLogFromMouse( position ) {
	
    var mousePosition = new Cesium.Cartesian2(position.x, position.y);
    var ellipsoid = viewer.scene.globe.ellipsoid;
    var cartesian = viewer.camera.pickEllipsoid(mousePosition, ellipsoid);		
	
	var result = {};
	cartographic = Cesium.Ellipsoid.WGS84.cartesianToCartographic(cartesian);
	var longitudeString = Cesium.Math.toDegrees(cartographic.longitude).toFixed(10);
	var latitudeString = Cesium.Math.toDegrees(cartographic.latitude).toFixed(10);    	    

	mapPointerLatitude = latitudeString.slice(-15);
	mapPointerLongitude = longitudeString.slice(-15);
	
	result.latitude = mapPointerLatitude;
	result.longitude = mapPointerLongitude;
	return result;
	
}

// PRIVATE
function toDegreesMinutesAndSeconds(coordinate) {
    var absolute = Math.abs(coordinate);
    var degrees = Math.floor(absolute);
    var minutesNotTruncated = (absolute - degrees) * 60;
    var minutes = Math.floor(minutesNotTruncated);
    var seconds = Math.floor((minutesNotTruncated - minutes) * 60);

    if( minutes < 10 ) minutes = "0" + minutes;
    if( seconds < 10 ) seconds = "0" + seconds;
    
    return degrees + "\xB0 " + minutes + "\' " + seconds + "\"";
}

function convertDMS(lat, lng) {
    var latitude = toDegreesMinutesAndSeconds(lat);
    var latitudeCardinal = lat >= 0 ? "N" : "S";

    var longitude = toDegreesMinutesAndSeconds(lng);
    var longitudeCardinal = lng >= 0 ? "E" : "W";

    var ret = {};
    ret.lat = latitude;
    ret.lon = longitude;
    ret.latCard = latitudeCardinal;
    ret.lonCard = longitudeCardinal;
    
    return ret;
}


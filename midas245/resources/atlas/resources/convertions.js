
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


function latLonToUTM(lon, lat) {
    var latitude, longitude, utmZone, utmEast, utmNorth, defaultUtm, letra;

    var arrayUTM = [
        {
            nome: 'Airy',
            raioEquatorial: 6377563,
            eccQuadrado: 0.00667054,
            latitudeMax: 60,
            latitudeMin: 51,
            longitudeMax: 2,
            longitudeMin: -6
        },
        {
            nome: 'Australian National',
            raioEquatorial: 6378160,
            eccQuadrado: 0.006694542,
            latitudeMax: -12,
            latitudeMin: -48,
            longitudeMax: 156,
            longitudeMin: 108
        },
        {
            nome: 'Bessel 1841l',
            raioEquatorial: 6377397,
            eccQuadrado: 0.006674372,
            latitudeMax: 160,
            latitudeMin: 120,
            longitudeMax: 45,
            longitudeMin: 30
        },
        {
            nome: 'Bessel 1841 (Nambia)',
            raioEquatorial: 6377484,
            eccQuadrado: 0.006674372,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'Clarke 1866',
            raioEquatorial: 6378206,
            eccQuadrado: 0.006768658,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'Clarke 1880',
            raioEquatorial: 6378249,
            eccQuadrado: 0.006803511,
            latitudeMax: 35,
            latitudeMin: -35,
            longitudeMax: 40,
            longitudeMin: -20
        },
        {
            nome: 'Everest',
            raioEquatorial: 6377276,
            eccQuadrado: 0.006637847,
            latitudeMax: 30,
            latitudeMin: -12,
            longitudeMax: 140,
            longitudeMin: 70
        },
        {
            nome: 'Fischer 1960 (Mercury)',
            raioEquatorial: 6378166,
            eccQuadrado: 0.006693422,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'Fischer 1968',
            raioEquatorial: 6378150,
            eccQuadrado: 0.006693422,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'GRS 1967',
            raioEquatorial: 6378160,
            eccQuadrado: 0.006694605,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'GRS 1980',
            raioEquatorial: 6378137,
            eccQuadrado: 0.00669438,
            latitudeMax: 80,
            latitudeMin: 15,
            longitudeMax: -60,
            longitudeMin: -170
        },
        {
            nome: 'Helmert 1906',
            raioEquatorial: 6378200,
            eccQuadrado: 0.006693422,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'Hough',
            raioEquatorial: 6378270,
            eccQuadrado: 0.00672267,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'International',
            raioEquatorial: 6378388,
            eccQuadrado: 0.00672267,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'Krassovsky',
            raioEquatorial: 6378245,
            eccQuadrado: 0.006693422,
            latitudeMax: 80,
            latitudeMin: 45,
            longitudeMax: 180,
            longitudeMin: 30
        },
        {
            nome: 'Modified Airy',
            raioEquatorial: 6377340,
            eccQuadrado: 0.00667054,
            latitudeMax: 55,
            latitudeMin: 51,
            longitudeMax: 11,
            longitudeMin: 6
        },
        {
            nome: 'Modified Everest',
            raioEquatorial: 6377304,
            eccQuadrado: 0.006637847,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'Modified Fischer 1960',
            raioEquatorial: 6378155,
            eccQuadrado: 0.006693422,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'South American 1969',
            raioEquatorial: 6378160,
            eccQuadrado: 0.006694542,
            latitudeMax: 15,
            latitudeMin: -60,
            longitudeMax: -20,
            longitudeMin: -80
        },
        {
            nome: 'WGS 60',
            raioEquatorial: 6378165,
            eccQuadrado: 0.006693422,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'WGS 66',
            raioEquatorial: 6378145,
            eccQuadrado: 0.006694542,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'WGS-72',
            raioEquatorial: 6378135,
            eccQuadrado: 0.006694318,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        },
        {
            nome: 'WGS-84',
            raioEquatorial: 6378137,
            eccQuadrado: 0.00669438,
            latitudeMax: null,
            latitudeMin: null,
            longitudeMax: null,
            longitudeMin: null
        }
    ];

    var position = function (latitude, longitude) {
        setLatitude(latitude);
        setLongitude(longitude);
        setDefault();
    };

    var setDefault = function () {
        defaultUtm = 22; // wgs 84
    };

    var setLatitude = function (lat) {
        var tmpLat = lat;
        latitude = tmpLat;
    };

    var setLongitude = function (lon) {
        //var tmplon = (long/360000);
        var tmplon = lon;
        longitude = tmplon;
    };

    var getUtmLetter = function (lat) {
        // Esta rotina determina a designação de letra correta para UTM, para uma dada latitude
        // retorna 'Z' se a latitude estiver fora dos limites da UTM de 84N a 80S
        // Original de Chuck Gantz- chuck.gantz@globalstar.com
        //jQueryLat = (Lat/360000);
        if ((84 >= lat) && (lat >= 72))
            letra = 'X';
        else if ((72 > lat) && (lat >= 64))
            letra = 'W';
        else if ((64 > lat) && (lat >= 56))
            letra = 'V';
        else if ((56 > lat) && (lat >= 48))
            letra = 'U';
        else if ((48 > lat) && (lat >= 40))
            letra = 'T';
        else if ((40 > lat) && (lat >= 32))
            letra = 'S';
        else if ((32 > lat) && (lat >= 24))
            letra = 'R';
        else if ((24 > lat) && (lat >= 16))
            letra = 'Q';
        else if ((16 > lat) && (lat >= 8))
            letra = 'P';
        else if ((8 > lat) && (lat >= 0))
            letra = 'N';
        else if ((0 > lat) && (lat >= -8))
            letra = 'M';
        else if ((-8 > lat) && (lat >= -16))
            letra = 'L';
        else if ((-16 > lat) && (lat >= -24))
            letra = 'K';
        else if ((-24 > lat) && (lat >= -32))
            letra = 'J';
        else if ((-32 > lat) && (lat >= -40))
            letra = 'H';
        else if ((-40 > lat) && (lat >= -48))
            letra = 'G';
        else if ((-48 > lat) && (lat >= -56))
            letra = 'F';
        else if ((-56 > lat) && (lat >= -64))
            letra = 'E';
        else if ((-64 > lat) && (lat >= -72))
            letra = 'D';
        else if ((-72 > lat) && (lat >= -80))
            letra = 'C';
        else
            letra = 'Z'; // flag de erro para mostrar
        // que a Latitude está fora dos limites UTM
    };

    var generateUTM = function () {
        var elipsoideRef = defaultUtm;
        var deg2rad = 3.14159265359 / 180.0;

        var a = arrayUTM[elipsoideRef].raioEquatorial;
        var eccSquared = arrayUTM[elipsoideRef].eccQuadrado;
        var k0 = 0.9996;

        var LongTmp1 = Math.floor(((longitude + 180) / 360));
        var LongTemp = (longitude + 180) - (LongTmp1 * 360) - 180;

        var LatRad = latitude * deg2rad;
        var LongRad = longitude * deg2rad;

        var ZoneNumber = Math.floor(((LongTemp + 180) / 6)) + 1;

        if (latitude >= 56.0 && latitude < 64.0 && LongTemp >= 3.0 && LongTemp < 12.0) {
            ZoneNumber = 32;
        }

        // zonas especiais para Svalbard
        if (latitude >= 72.0 && latitude < 84.0) {
            if (LongTemp >= 0.0 && LongTemp < 9.0) {
                ZoneNumber = 31;
            } else if (LongTemp >= 9.0 && LongTemp < 21.0) {
                ZoneNumber = 33;
            } else if (LongTemp >= 21.0 && LongTemp < 33.0) {
                ZoneNumber = 35;
            } else if (LongTemp >= 33.0 && LongTemp < 42.0) {
                ZoneNumber = 37;
            }
        }

        var LongOrigin = (ZoneNumber - 1) * 6 - 180 + 3;  //+3 coloca a origem no meio da zona 
        var LongOriginRad = LongOrigin * deg2rad;

        getUtmLetter(latitude);
        utmZone = ZoneNumber;

        var eccPrimeSquared = (eccSquared) / (1 - eccSquared);

        var N = a / Math.sqrt(1 - eccSquared * Math.sin(LatRad) * Math.sin(LatRad));
        var T = Math.tan(LatRad) * Math.tan(LatRad);
        var C = eccPrimeSquared * Math.cos(LatRad) * Math.cos(LatRad);
        var A = Math.cos(LatRad) * (LongRad - LongOriginRad);

        var M = (a *
                (
                        (
                                (1 - eccSquared / 4) -
                                (3 * eccSquared * eccSquared / 64) -
                                (5 * eccSquared * eccSquared * eccSquared / 256)
                                ) * LatRad -
                        (
                                (3 * eccSquared / 8) +
                                (3 * eccSquared * eccSquared / 32) +
                                (45 * eccSquared * eccSquared * eccSquared / 1024)
                                ) * Math.sin(2 * LatRad) +
                        (
                                (15 * eccSquared * eccSquared / 256) +
                                (45 * eccSquared * eccSquared * eccSquared / 1024)
                                ) * Math.sin(4 * LatRad) -
                        (
                                (35 * eccSquared * eccSquared * eccSquared / 3072)
                                ) * Math.sin(6 * LatRad)
                        ));

        utmEast = (k0 * N * (A + (1 - T + C) * A * A * A / 6 + (5 - 18 * T + T * T + 72 * C - 58 * eccPrimeSquared) * A * A * A * A * A / 120) + 500000.0);
        utmNorth = (k0 * (M + N * Math.tan(LatRad) * (A * A / 2 + (5 - T + 9 * C + 4 * C * C) * A * A * A * A / 24 + (61 - 58 * T + T * T + 600 * C - 330 * eccPrimeSquared) * A * A * A * A * A * A / 720)));
        utmNorth = Math.round(utmNorth);
        utmEast = Math.round(utmEast);

        if (latitude < 0)
            utmNorth += 10000000.0;
    };

    position(lat, lon);
    generateUTM();

    if (utmZone && letra && utmNorth && utmEast)
        return utmZone + '' + letra + ' ' + utmNorth + ' ' + utmEast;

    return '';
}

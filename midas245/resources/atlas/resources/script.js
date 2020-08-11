var ws = null;
var configuration = null;
var stompClient = null;

function loadScript(url, callback){

    var script = document.createElement("script")
    script.type = "text/javascript";

    if (script.readyState){  //IE
        script.onreadystatechange = function(){
            if (script.readyState == "loaded" || script.readyState == "complete"){
                script.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        script.onload = function(){
            callback();
        };
    }

    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
}

function getBox( callBack ){

	// Cesium.ClampMode.Ground
	// Cesium.ClampMode.Raster
	// Cesium.ClampMode.Space
	
	var handlerPolygon = new Cesium.DrawHandler( viewer, Cesium.DrawMode.Polygon, Cesium.ClampMode.Space );
	handlerPolygon.enableDepthTest = false;
	
	handlerPolygon.drawEvt.addEventListener(function(result) {
		var polygon = result.object;
		var positions = polygon.positions;
		var flatPoints = [];
		var result = {};
		result.cartesian = positions;
	   
		for(var i = 0, j = positions.length; i < j; i++) {
			var position = positions[i];
			var cartographic = Cesium.Cartographic.fromCartesian(position);
			var lon = Cesium.Math.toDegrees(cartographic.longitude);
			var lat = Cesium.Math.toDegrees(cartographic.latitude);
			var height = cartographic.height;
			var aPoint = {lat,lon,height};
			flatPoints.push( aPoint );
		}
		
		result.cartographic = flatPoints;
		
		handlerPolygon.clear();
		handlerPolygon.deactivate();
		if( callBack != null ) callBack( result );	
	});	
	
	handlerPolygon.movingEvt.addEventListener(function(result){
		console.log('Moving ... ');
		console.log( result );
	});	
	
	handlerPolygon.activate();

}

function importModule( module ){
	var url = 'http://sisgeodef.defesa.mil.br:36280/scripts/' + module + '.js?_d=' + createUUID();
	loadScript( url, function(){
		console.log('Módulo ' + module + ' carregado.');
	});
}

function getUrlParam(parameter, defaultvalue){
    var urlparameter = defaultvalue;
    if(window.location.href.indexOf(parameter) > -1){
        urlparameter = getUrlVars()[parameter];
        }
    return urlparameter;
}

function getUrlVars() {
    var vars = {};
    var parts = window.location.href.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(m,key,value) {
        vars[key] = value;
    });
    return vars;
}

function connect() {
    var socket = new SockJS('/ws');
    stompClient = Stomp.over(socket);
    stompClient.heartbeat.outgoing = 2000;
    stompClient.heartbeat.incoming = 2000;    
    stompClient.debug = null;
	stompClient.connect({}, function(frame) {
		
		stompClient.subscribe('/drone/create', function(notification) {
			var payload =  JSON.parse( notification.body );
			if( payload.uuid == myDroneID ) return;
			newDroneFromExternal( payload );
		});
		
		
		stompClient.subscribe('/drone/update', function(notification) {
			var payload =  JSON.parse( notification.body );
			if( payload.uuid == myDroneID ) return;
			updateDroneFromExternal( payload );
		});
		
		stompClient.subscribe('/drone/remove', function(notification) {
			var payload =  JSON.parse( notification.body );
			if( payload.uuid == myDroneID ) return;
			removeDroneFromExternal( payload );
		});
		
	}, function( theMessage ) {
		console.log( theMessage );
	});    
    
}

function socketBroadcast( channel, data ){
	stompClient.send( channel, {}, data );
}


function createUUID() {
    // http://www.ietf.org/rfc/rfc4122.txt
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";

    var uuid = s.join("");
    return uuid;
}







function doProfile( line ){
    //var b = new Cesium.BillboardCollection({scene: viewer.scene});
    //scene.primitives.add(b);
	var segments = [];
    var positions = line.positions;
    
	for( x=0; x < positions.length-1; x++ ){
		segments.push( processLineSegment( positions[x], positions[x+1], 10 ) );
	}

    console.log( segments );
    
    for( y=0; y < segments.length; y++ ){
    	var points = segments[y];
    	for( z=0; z < points.length; z++ ){
    		var point = points[z];
    		
    		var citizensBankPark = viewer.entities.add({
    		    position : point,
    		    point : {
    		        pixelSize : 5,
    		        color : Cesium.Color.RED,
    		        outlineColor : Cesium.Color.WHITE,
    		        outlineWidth : 2
    		    }
    		});
    		
    		/*
	        var billboard = b.add({
	            position : point,
	            pixelOffset : new Cesium.Cartesian2(0, 0),
	            eyeOffset : new Cesium.Cartesian3(0.0, 0.0, 0.0),
	            horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
	            verticalOrigin : Cesium.VerticalOrigin.CENTER,
	            scale : 1.0,
	            image: '/resources/drawhelper/img/glyphicons_242_google_maps.png',
	            color : new Cesium.Color(1.0, 1.0, 1.0, 1.0),
	        });
	        */
    	}
    	
    }
    
    
}


function processLineSegment( startPoint, endPoint, pointSum ){
    var scartographic = Cesium.Cartographic.fromCartesian(startPoint);
    var slongitude = Cesium.Math.toDegrees(scartographic.longitude);
    var slatitude = Cesium.Math.toDegrees(scartographic.latitude);
    var sheight = scartographic.height;
    var ecartographic = Cesium.Cartographic.fromCartesian(endPoint);
    var elongitude = Cesium.Math.toDegrees(ecartographic.longitude);
    var elatitude = Cesium.Math.toDegrees(ecartographic.latitude);
    var eheight = ecartographic.height;
    var addXTT = Cesium.Math.lerp(slongitude, elongitude, 1.0/pointSum) - slongitude;
    var addYTT = Cesium.Math.lerp(slatitude, elatitude, 1.0/pointSum) - slatitude;
    
    // console.log( 'Processando linha: ' + slatitude + ',' + slongitude + ' ate ' + elatitude + ',' + elongitude );
    var p1,p2;
    var result = [];
    
    for(var i = 0; i <= pointSum; i++){
        var longitude = slongitude + i * addXTT;
        var latitude = slatitude + i * addYTT;
        p1 = new Cesium.Cartesian3.fromDegrees(longitude, latitude);
        result.push( p1 );
        
        if( p2 ){
        	var juli = Math.round( Cesium.Cartesian3.distance( p1, p2 ) * 100000 );
        	console.log( juli );
        } 
        
        p2 = p1;
    }
    return result;
}


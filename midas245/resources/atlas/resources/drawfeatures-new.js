

function drawLine(){
	drawHelper.startDrawingPolyline({
		callback: function(positions) {
			
            loggingMessage('Polyline created with ' + positions.length + ' points');
            var polyline = new DrawHelper.PolylinePrimitive({
                positions: positions,
                width: 5,
                geodesic: true
            });
            scene.primitives.add(polyline);
            polyline.setEditable();
            polyline.addListener('onEdited', function(event) {
                loggingMessage('Polyline edited, ' + event.positions.length + ' points');
            });
			
			
		}
	});
}

function drawCircle(){
	drawHelper.startDrawingCircle({
		callback: function(center, radius) {

            loggingMessage('Circle created: center is ' + center.toString() + ' and radius is ' + radius.toFixed(1) + ' meters');
            var circle = new DrawHelper.CirclePrimitive({
                center: center,
                radius: radius,
                material: Cesium.Material.fromType(Cesium.Material.RimLightingType)
            });
            scene.primitives.add(circle);
            circle.setEditable();
            circle.addListener('onEdited', function(event) {
                loggingMessage('Circle edited: radius is ' + event.radius.toFixed(1) + ' meters');
            });
			
			
		}
	});
}

function drawBox(){
	drawHelper.startDrawingExtent({
		callback: function(extent) {
			
            var extent = extent;
            loggingMessage('Extent created (N: ' + extent.north.toFixed(3) + ', E: ' + extent.east.toFixed(3) + ', S: ' + extent.south.toFixed(3) + ', W: ' + extent.west.toFixed(3) + ')');
            
			var extentPrimitive = new DrawHelper.ExtentPrimitive({
                extent: extent,
                material: Cesium.Material.fromType(Cesium.Material.StripeType)
            });
			
            var thePrimitive = scene.groundPrimitives.add(extentPrimitive);
			
            extentPrimitive.setEditable();
            extentPrimitive.addListener('onEdited', function(event) {
                loggingMessage('Extent edited: extent is (N: ' + event.extent.north.toFixed(3) + ', E: ' + event.extent.east.toFixed(3) + ', S: ' + event.extent.south.toFixed(3) + ', W: ' + event.extent.west.toFixed(3) + ')');
            });
			
		}
	});
}

function drawPoint(){

var billboards = scene.primitives.add(new Cesium.BillboardCollection({scene: viewer.scene}));

	drawHelper.startDrawingMarker({
		callback: function( position ) {
			
            loggingMessage('Marker created at ' + position.toString() );
			
            var b = new Cesium.BillboardCollection({scene: viewer.scene});
            scene.primitives.add(b);
            var billboard = b.add({
                position : position,
                pixelOffset : new Cesium.Cartesian2(0, 0),
                eyeOffset : new Cesium.Cartesian3(0.0, 0.0, 0.0),
                horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
                verticalOrigin : Cesium.VerticalOrigin.CENTER,
                scale : 1.0,
                image: './img/glyphicons_242_google_maps.png',
                color : new Cesium.Color(1.0, 1.0, 1.0, 1.0),
				//heightReference : Cesium.HeightReference.CLAMP_TO_GROUND
            });
            billboard.setEditable();
			
			// Nao estah disparando o evento
            billboard.addListener('onEdited', function(event) {
                loggingMessage('Marker edited');
            });
			
			
		}
	});

}


function drawPolygon( draped ) {
	console.log('is me');
	if( draped ) {
		draw2DPolygon();
	} else {
		draw3DPolygon();
	}	
}

function draw3DPolygon() {
	//
}

function draw2DPolygon() {
	
	drawHelper.startDrawingPolygon({
		
		callback: function( positions ) {
            var polygon = new DrawHelper.PolygonPrimitive({
                positions: positions,
                material : Cesium.Material.fromType('Checkerboard')
            });
            scene.primitives.add(polygon);
            polygon.setEditable();
            polygon.addListener('onEdited', function(event) {
                loggingMessage('Polygon edited, ' + event.positions.length + ' points');
            });
		}
	});
	
}


function loggingMessage( message ){
	console.log( message );
}



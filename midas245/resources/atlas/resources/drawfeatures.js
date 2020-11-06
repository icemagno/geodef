


function addFeatureToStack( feature, attributes, type ){
	var uuid = createUUID();
	var data = {
		uuid : uuid,
		attributes : attributes,
		feature : feature,
		type : type
	}
	drawedEditableFeatures.push( data );
	addFeatureCard( data );
}

function drawLine(){
	drawHelper.startDrawingPolyline({
		callback: function(positions) {

            var material = new Cesium.Material.fromType("Color");
            material.uniforms.color = Cesium.Color.fromRandom({
                alpha: 1.0,
            });
            var colorData = { 
            	rgba : material.uniforms.color.toBytes(),
            	css : material.uniforms.color.toCssHexString()
            };
			
			
            loggingMessage('Polyline created with ' + positions.length + ' points');
            var polyline = new DrawHelper.PolylinePrimitive({
                positions: positions,
                width: 5,
                geodesic: true,
                material: material
            });
            
            scene.groundPrimitives.add(polyline);
            polyline.setEditable();
            polyline.addListener('onEdited', function(event) {
                loggingMessage('Polyline edited, ' + event.positions.length + ' points');
            });
            
            addFeatureToStack( polyline, { color : colorData }, 'LINE' );
            
		}
	});
}

function drawCircle(){
	drawHelper.startDrawingCircle({
		callback: function(center, radius) {

            var material = new Cesium.Material.fromType("Color");
            material.uniforms.color = Cesium.Color.fromRandom({
                alpha: 1.0,
            });
            var colorData = { 
            	rgba : material.uniforms.color.toBytes(),
            	css : material.uniforms.color.toCssHexString()
            };
			
            loggingMessage('Circle created: center is ' + center.toString() + ' and radius is ' + radius.toFixed(1) + ' meters');
            var circle = new DrawHelper.CirclePrimitive({
                center: center,
                radius: radius,
                material: material
            });
            scene.groundPrimitives.add(circle);
            circle.setEditable();
            circle.addListener('onEdited', function(event) {
                loggingMessage('Circle edited: radius is ' + event.radius.toFixed(1) + ' meters');
            });
			
            addFeatureToStack( circle, { color : colorData }, 'CIRCLE' );
		}
	});
}

function drawBox(){
	drawHelper.startDrawingExtent({
		callback: function(extent) {

            var extent = extent;
            loggingMessage('Extent created (N: ' + extent.north.toFixed(3) + ', E: ' + extent.east.toFixed(3) + ', S: ' + extent.south.toFixed(3) + ', W: ' + extent.west.toFixed(3) + ')');
            
            var material = new Cesium.Material.fromType("Color");
            material.uniforms.color = Cesium.Color.fromRandom({
                alpha: 1.0,
            });
            var colorData = { 
            	rgba : material.uniforms.color.toBytes(),
            	css : material.uniforms.color.toCssHexString()
            };
            
			var extentPrimitive = new DrawHelper.ExtentPrimitive({
                extent: extent,
                material: material
            });
			
            var thePrimitive = scene.groundPrimitives.add(extentPrimitive);
			
            addFeatureToStack( thePrimitive, { color : colorData }, 'BOX' );
            
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
			
            var material = new Cesium.Material.fromType("Color");
            material.uniforms.color = Cesium.Color.fromRandom({
                alpha: 1.0,
            });            
            var imageFile = '/resources/drawhelper/img/glyphicons_242_google_maps.png';
            
            var colorData = { 
            	rgba : material.uniforms.color.toBytes(),
            	css : material.uniforms.color.toCssHexString(),
            	image: imageFile
            };
            
            
            var billboard = drawedFeaturesBillboards.add({
                position : position,
                pixelOffset : new Cesium.Cartesian2(0, 0),
                eyeOffset : new Cesium.Cartesian3(0.0, 0.0, 0.0),
                horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
                verticalOrigin : Cesium.VerticalOrigin.CENTER,
                scale : 1.0,
                image: imageFile,
                color : material.uniforms.color,
            });
            billboard.setEditable();
			
            addFeatureToStack( billboard, { color : colorData }, 'POINT' );
            
            billboard.addListener('onEdited', function(event) {
                loggingMessage('Marker edited: (Cartesian2) X=' + event.positions.x  + ' Y=' + event.positions.y );
            });
			
			
		}
	});

}


function drawPolygon( draped ) {
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
			
			
            var material = new Cesium.Material.fromType("Color");
            material.uniforms.color = Cesium.Color.fromRandom({
                alpha: 1.0,
            });
            var colorData = { 
            	rgba : material.uniforms.color.toBytes(),
            	css : material.uniforms.color.toCssHexString()
            };
			
			
            var polygon = new DrawHelper.PolygonPrimitive({
                positions: positions,
                material : material
            });
            scene.groundPrimitives.add(polygon);
            
            addFeatureToStack( polygon, { color : colorData }, 'POLYGON' );
            
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



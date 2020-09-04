/*
function onChanged(collection, added, removed, changed){
	var msg = 'Added ids';
	for(var i = 0; i < added.length; i++) {
		msg += '\n' + added[i].id;
	}
	console.log(msg);
}
*/

var viewshed3D;

function getviewshed(){


	var pointHandler = new Cesium.DrawHandler(viewer, Cesium.DrawMode.Point);
	viewshed3D = new Cesium.ViewShed3D(scene);
	scene.viewFlag = true;
	var viewPosition = null;
	
	viewshed3D.hintLineColor = Cesium.Color.RED; 
	viewshed3D.hiddenAreaColor = Cesium.Color.WHITE.withAlpha(0.0); 
	viewshed3D.visibleAreaColor = Cesium.Color.WHITE.withAlpha(0.0); 
	viewshed3D._segmentCount = 100;

	pointHandler.drawEvt.addEventListener(function (result) {
		var point = result.object;
		var position = point.position;
		viewPosition = position;

		var cartographic = Cesium.Cartographic.fromCartesian(position);
		var longitude = Cesium.Math.toDegrees(cartographic.longitude);
		var latitude = Cesium.Math.toDegrees(cartographic.latitude);
		var height = cartographic.height + 1.8;
		point.position = Cesium.Cartesian3.fromDegrees(longitude, latitude, height);

		var longitudeString = longitude.toFixed(10);
		var latitudeString = latitude.toFixed(10);    	    
		
		if (scene.viewFlag) {
			viewshed3D.viewPosition = [longitude, latitude, height];
			viewshed3D.build();
			scene.viewFlag = false;
		}
		
	});	
	
	
	mainEventHandler.setInputAction(function (e) {
		if (!scene.viewFlag) {
			var position = e.endPosition;
			var last = scene.pickPosition(position);
			
			var distance = Cesium.Cartesian3.distance(viewPosition, last);
			if (distance > 0) {
				var cartographic = Cesium.Cartographic.fromCartesian(last);
				var longitude = Cesium.Math.toDegrees(cartographic.longitude);
				var latitude = Cesium.Math.toDegrees(cartographic.latitude);
				var height = cartographic.height;
				viewshed3D.setDistDirByPoint([longitude, latitude, height]);
			}
			
		}
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);		



	mainEventHandler.setInputAction(function (e) {
		scene.viewFlag = true;
		mainEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.RIGHT_CLICK);
		
		
		pointHandler.clear();
		viewshed3D.clear();
	
		
		console.log("Processando...");
		showBarrier();
		//showViewShed();
		console.log("Feito.");

		viewshed3D.destroy();
		

		
	}, Cesium.ScreenSpaceEventType.RIGHT_CLICK);


	//viewer.entities.collectionChanged.addEventListener(onChanged);

	pointHandler.activate();

}


function showViewShed(){
	var primCollection = scene.primitives.add( new Cesium.PointPrimitiveCollection() );
	var vsp = viewshed3D.getViewshedParameter();
	var points = vsp.point3DList;
	var pointsLength = points.length;
	for( var x=0; x < pointsLength; x++ ) {
		var fa = points[x].pntArray;
		var faLength = fa.length;
		for( var y =0; y < faLength; y++ ){
			var thePoint = fa[y];
			var cartesian = Cesium.Cartesian3.fromDegrees( thePoint.x, thePoint.y, thePoint.z );	
			primCollection.add({
			  position : cartesian,
			  pixelSize: 5.0,
			  color : Cesium.Color.RED,
			});
		}
	}
}

function showBarrier(){
	var tp = viewshed3D._targetPoints;
	var tpLength = tp.length;
		
	var primCollection = scene.primitives.add( new Cesium.PointPrimitiveCollection() );
	for( var x=0; x < tpLength; x++ ) {
		var fa = tp[x].pntArray;
		var faLength = fa.length;
		
		for( var y =0; y < faLength; y++ ){
			var p3d = fa[y];
			var bp = viewshed3D.getBarrierPoint( p3d );
			if( bp ){
				var cartesian = Cesium.Cartesian3.fromDegrees( bp.x, bp.y, bp.z );
				primCollection.add({
				  position : cartesian,
				  pixelSize: 5.0,
				  color : Cesium.Color.RED,
				});
/*				
				var entity = viewer.entities.add({
					position: cartesian,
					point : {
						pixelSize : 5,
						clampToGround : true,
						color : Cesium.Color.BROWN,
						outlineColor : Cesium.Color.YELLOW,
						outlineWidth : 1,		    	
					}				
				});

*/
			}
		}
		
	}	
}
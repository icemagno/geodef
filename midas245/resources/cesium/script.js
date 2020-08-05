function run(){
	console.log('Sight Line Loaded!');
	
	var sightline = new Cesium.Sightline(scene);
	sightline.couldRemove = false;

	var handlerPoint = new Cesium.DrawHandler(viewer, Cesium.DrawMode.Point);
	var widget = viewer.cesiumWidget;
	
	sightline.build();
	
	
	document.getElementById("chooseView").onclick = function() {
		if(handlerPoint.active) {
			return;
		}
		scene.viewFlag = true;
		viewer.entities.removeAll();
		if(sightline.couldRemove) {
			sightline.removeAllTargetPoint();
		}
		handlerPoint.activate();
	};	
	
	document.getElementById("addPoint").onclick = function() {
		scene.viewFlag = false;
		handlerPoint.activate();
	};

	document.getElementById("clear").onclick = function() {
		handlerPoint.clear();
		viewer.entities.removeAll();
		if(sightline.couldRemove){
			sightline.removeAllTargetPoint();
			sightline.couldRemove = false;
		}
	}	
	
	handlerPoint.drawEvt.addEventListener( function(result){
		var point = result.object;
		point.show = true;
		var position = result.object.position;

		var cartographic = Cesium.Cartographic.fromCartesian(position);
		var longitude = Cesium.Math.toDegrees(cartographic.longitude);
		var latitude = Cesium.Math.toDegrees(cartographic.latitude);
		var height = cartographic.height;

		if(scene.viewFlag) {
			sightline.viewPosition = [longitude, latitude, height];
			scene.viewFlag = false;
		}else {
			var pName = "point" + new Date();
			sightline.addTargetPoint({
				position : [longitude, latitude, height],
				name : pName
			});
			sightline.couldRemove = true;
			
			setTimeout(function () {
				sightline.getBarrierPoint(pName, function (e) {
					console.log(e);
					
					/*
					viewer.entities.add({
						name : 'ROTA_PONTO',
						position : thePosition,
						point : {
							clampToGround : true,
							pixelSize : 8,
							color : Cesium.Color.BROWN,
							outlineColor : Cesium.Color.YELLOW,
							outlineWidth : 3,		    	
						}
					});
					*/
					
					
				})
			},50);			
			
		}
	});
	
	
	
}

$( document ).ready(function() {
	run();
});


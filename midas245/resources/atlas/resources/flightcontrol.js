var myDroneID = createUUID();
var start = null;
var stop = null;
var simulating = false;
var canMove = false;
var followThePlane = false;

var theSecondCamera = null;
var r = 0;
var hpRoll = new Cesium.HeadingPitchRoll();
var hpRange = new Cesium.HeadingPitchRange();
var speed = 1;
var deltaRadians = Cesium.Math.toRadians(1.0);
var mainDrone = {};
var unsubscribePreUpdate = null;
var unsubscribePreRender = null;
var fixedFrameTransform = Cesium.Transforms.localFrameToFixedFrameGenerator('north', 'west');
var externalDrones = [];
var airplanes = [];




function followRoute( positions ) {
	var altitude =  getUrlParam('flightAltitude',200 );
	
	
	start = Cesium.JulianDate.fromDate( new Date(2019, 2, 25, 16) );
	
	var ap1 = Cesium.LagrangePolynomialApproximation;
	var ap2 = Cesium.HermitePolynomialApproximation;
	var ap3 = Cesium.LinearApproximation;
	
	var sample = new Cesium.SampledPositionProperty();
	sample.setInterpolationOptions({
		interpolationDegree : 2,
		interpolationAlgorithm : ap1 
	});

	jQuery( positions ).each(function( index, cartPosition ) {
		var cartographicPosition = Cesium.Cartographic.fromCartesian( cartPosition );
		
		var floatPosition = Cesium.Cartesian3.fromDegrees( Cesium.Math.toDegrees( cartographicPosition.longitude ), 
				Cesium.Math.toDegrees( cartographicPosition.latitude ), cartographicPosition.height + altitude);
		
		var time = Cesium.JulianDate.addSeconds(start, index*10, new Cesium.JulianDate() );
		stop = time;
		sample.addSample(time, floatPosition);
	});

	var entity = viewer.entities.add({
		position: sample,
		orientation : new Cesium.VelocityOrientationProperty( sample ),
		availability : new Cesium.TimeIntervalCollection([new Cesium.TimeInterval({
			start : start,
			stop : stop
		})]),	
		
		point : {
            pixelSize : 5,
            clampToGround : true,
            color : Cesium.Color.BROWN,
            outlineColor : Cesium.Color.YELLOW,
            outlineWidth : 1,		    	
	    },
		/*
	    model : {
	        uri : '/resources/models/an225.gltf',
	        minimumPixelSize : 64
	    },
	    */	
	    /*
		path : {
			show : true,
			leadTime : 0,
			trailTime : 60,
			width : 10,
			resolution : 1,
			material : new Cesium.PolylineGlowMaterialProperty({
				glowPower : 0.3,
				taperPower : 0.3,
				color : Cesium.Color.PALEGOLDENROD
			})
		},
		*/
	});
	
	/*
	var camera = viewer.camera;
	camera.position = new Cesium.Cartesian3(0.25, 0.0, 0.0);
	camera.direction = new Cesium.Cartesian3(1.0, 0.0, 0.0);
	camera.up = new Cesium.Cartesian3(0.0, 0.0, 1.0);
	camera.right = new Cesium.Cartesian3(0.0, -1.0, 0.0);
	*/
	
	viewer.clock.startTime = start.clone();
	viewer.clock.stopTime = stop.clone();
	viewer.clock.currentTime = start.clone();
	viewer.clock.clockRange = Cesium.ClockRange.LOOP_STOP; 
	viewer.clock.multiplier = 2.0;
	viewer.clock.shouldAnimate = true;			
	
	var dome = null;
	viewer.scene.postUpdate.addEventListener(function(scene, time) {
		var position = entity.position.getValue(time);
		if (!Cesium.defined(position)) {
			return;
		}
		var transform;
		if (!Cesium.defined(entity.orientation)) {
			transform = Cesium.Transforms.eastNorthUpToFixedFrame(position);
		} else {
			var orientation = entity.orientation.getValue(time);
			if (!Cesium.defined(orientation)) {
				return;
			}
			transform = Cesium.Matrix4.fromRotationTranslation(Cesium.Matrix3.fromQuaternion(orientation), position);
		}
		

		var cartographicPosition = Cesium.Cartographic.fromCartesian( position );
		var longitude = Cesium.Math.toDegrees( cartographicPosition.longitude );
		var latitude = Cesium.Math.toDegrees( cartographicPosition.latitude );
		var height = cartographicPosition.height;

		var hpr = Cesium.Transforms.fixedFrameToHeadingPitchRoll(transform);
		
		/*
		var setHprQuaternion2 = new Cesium.Quaternion();
		var setHprTranslation = new Cesium.Cartesian3();
		var setHprScale = new Cesium.Cartesian3();
		var setHprCenter = new Cesium.Cartesian3();
		var setHprTransform = new Cesium.Matrix4();
		var setHprRotation = new Cesium.Matrix3();
	    var translation = Cesium.Matrix4.getTranslation(transform, setHprTranslation);
	    var scale = Cesium.Matrix4.getScale(transform, setHprScale);
	    var center = Cesium.Matrix4.multiplyByPoint(transform, Cesium.Cartesian3.ZERO, setHprCenter);
	    var backTransform = Cesium.Transforms.eastNorthUpToFixedFrame(center, undefined, setHprTransform);
	    var rotationFixed = Cesium.Matrix4.getRotation(backTransform, setHprRotation);
	    var quaternionFixed = Cesium.Quaternion.fromRotationMatrix(rotationFixed, setHprQuaternion2);
		*/
		
		/*
		var hpr = Cesium.HeadingPitchRoll.fromQuaternion( quaternionFixed );
		*/
		var heading = Cesium.Math.toDegrees( hpr.heading );
		if( dome == null ) {
			dome = new Dome( longitude, latitude, height, height + 50, false );
		} else {
			dome.updatePosition( longitude, latitude, height );
		}
		
		
		
		/*
		// Save camera state
		var offset = Cesium.Cartesian3.clone(camera.position);
		var direction = Cesium.Cartesian3.clone(camera.direction);
		var up = Cesium.Cartesian3.clone(camera.up);
		// Set camera to be in model's reference frame.
		camera.lookAtTransform(transform);
		// Reset the camera state to the saved state so it appears fixed in the model's frame.
		Cesium.Cartesian3.clone(offset, camera.position);
		Cesium.Cartesian3.clone(direction, camera.direction);
		Cesium.Cartesian3.clone(up, camera.up);
		Cesium.Cartesian3.cross(direction, up, camera.right);

		var rollV = Cesium.Math.toDegrees( camera.roll );
		var pitchV = Cesium.Math.toDegrees( camera.pitch ) ;
		var headingV = 360 - Cesium.Math.toDegrees( camera.heading );
		var altitudeV = camera.positionCartographic.height;
		*/
		
	});

}



//Cria path a partir de uma rota.
function interpola( positions ){
	
	start = Cesium.JulianDate.fromDate( new Date(2019, 2, 25, 16) );
	
	var ap1 = Cesium.LagrangePolynomialApproximation;
	var ap2 = Cesium.HermitePolynomialApproximation;
	var ap3 = Cesium.LinearApproximation;
	
	var sample = new Cesium.SampledPositionProperty();
	sample.setInterpolationOptions({
		interpolationDegree : 3,
		interpolationAlgorithm : ap3 
	});

	jQuery( positions ).each(function( index, cartPosition ) {
		var cartographicPosition = Cesium.Cartographic.fromCartesian( cartPosition );
		
		var floatPosition = Cesium.Cartesian3.fromDegrees( Cesium.Math.toDegrees( cartographicPosition.longitude ), 
				Cesium.Math.toDegrees( cartographicPosition.latitude ), cartographicPosition.height + 500 );
		
		var time = Cesium.JulianDate.addSeconds(start, index*10, new Cesium.JulianDate() );
		stop = time;
		sample.addSample(time, cartPosition);
	});

	viewer.clock.startTime = start.clone();
	viewer.clock.stopTime = stop.clone();
	viewer.clock.currentTime = start.clone();
	viewer.clock.clockRange = Cesium.ClockRange.LOOP_STOP; 
	viewer.clock.multiplier = 2.0;
	viewer.clock.shouldAnimate = true;		
	var target = viewer.entities.add({
		position: sample,
		orientation : new Cesium.VelocityOrientationProperty( sample ),
		availability : new Cesium.TimeIntervalCollection([new Cesium.TimeInterval({
			start : start,
			stop : stop
		})]),	
		
		point : {
            pixelSize : 5,
            clampToGround : true,
            //color : Cesium.Color.BROWN,
            outlineColor : Cesium.Color.YELLOW,
            outlineWidth : 2,		    	
	    },
	    
		/*
	    model : {
	        uri : '/resources/models/an225.gltf',
	        minimumPixelSize : 64
	    },
	    */		    
		path : {
			show : true,
			leadTime : 0,
			trailTime : 60,
			width : 10,
			resolution : 1,
			material : new Cesium.PolylineGlowMaterialProperty({
				glowPower : 0.3,
				taperPower : 0.3,
				color : Cesium.Color.PALEGOLDENROD
			})
		},
	});

	
	var drone = null;
	viewer.scene.postUpdate.addEventListener(function(scene, time) {
		var position = target.position.getValue(time);
		var orientation = target.orientation.getValue(time);

		if ( !Cesium.defined(position) ) return;
		if ( !Cesium.defined(orientation) ) return;

		var cartographicPosition = Cesium.Cartographic.fromCartesian( position );
		var longitude = Cesium.Math.toDegrees( cartographicPosition.longitude );
		var latitude = Cesium.Math.toDegrees( cartographicPosition.latitude );
		var height =  500 + cartographicPosition.height;
		
		var hpr = Cesium.HeadingPitchRoll.fromQuaternion( orientation );
		var heading = 360 - Cesium.Math.toDegrees( hpr.heading );

		//console.log( orientation );
		//console.log( hpr.heading );
		
		//console.log( longitude + ", " + latitude + " : " + height + " : " + heading );
		
		if( drone == null ) {
			drone = new Drone( longitude, latitude, height, heading, -45, height + 50, false );
		} else {
			drone.updatePosition( longitude, latitude, height, heading , -45 );
		}
		
		jQuery("#rosaVentos").rotate( heading );
		
	});
		

}


function flightRadarFromApolo(){
	// http://10.5.115.134/mclm/getAircraftsInBBOX?maxlat=-20&maxlon=-40&minlat=-24&minlon=-45

	jQuery.ajax({
		url: "/aircrafts", 
		type: "GET", 
		beforeSend : function() {
			//
		},
		error: function( obj ) {
			//
		},		
		success: function( obj ) {

			for (var key in obj) {
				var plane = obj[key];
				if ( Array.isArray( plane ) ){

					//console.log( plane );

					var lon = plane[1];
					var lat = plane[2];
					var alt = plane[4] * 0.3048;
					var thePosition = Cesium.Cartesian3.fromDegrees(lat, lon, alt);					
					var heading = Cesium.Math.toRadians(0.0 + plane[3]);
					var pitch = Cesium.Math.toRadians(0.0);
					var roll = Cesium.Math.toRadians(0.0);
					var hpr = new Cesium.HeadingPitchRoll(heading, pitch, roll);
					var theOrientation = Cesium.Transforms.headingPitchRollQuaternion(thePosition, hpr);

					/*
					var yellowBall = viewer.entities.add( new Cesium.Entity({
						name: key,
						label: {
							text: plane[9],
							style: Cesium.LabelStyle.FILL,
							fillColor: new Cesium.Color(255, 255, 0, 1),
							outlineWidth: 1,
							font: '18px Consolas',
							eyeOffset: new Cesium.Cartesian3(0.0, 250.0, 0.0)
						},
						position: thePosition,
						show: true,
						ellipsoid: {
							radii: new Cesium.Cartesian3(100.0, 100.0, 100.0),
							material: Cesium.Color.YELLOW.withAlpha(1)
						}
					}));
					 */

					var found = false;
					for( var xy=0; xy<airplanes.length; xy++  ) {
						var planTemp = airplanes[xy];
						if( planTemp.name == key   ){
							planTemp.position = thePosition;
							planTemp.orientation = theOrientation;
							found = true;
							break;
						}
					}

					if( !found ){
						var airPlane = new Cesium.Entity({
							name : key,
							position: thePosition,
							orientation: theOrientation,
							show: true,
							model: {
								uri: '/resources/models/a319.glb',
								minimumPixelSize : 128,
								maximumScale : 500,
								color: Cesium.Color.RED

							},
							label: {
								text: plane[9],
								style: Cesium.LabelStyle.FILL,
								fillColor: Cesium.Color.BLACK,
								outlineWidth: 1,
								font: '10px Consolas',
								eyeOffset: new Cesium.Cartesian3(0.0, 170.0, 0.0)
							}
						});
						airplanes.push( airPlane );
						viewer.entities.add( airPlane );
					}


				}
			}

		}, 
		complete: function(xhr, textStatus) {
			//
		}, 		
		dataType: "json",
		contentType: "application/json"
	});  	



}


function flight( latitude, longitude  ) {
	start = Cesium.JulianDate.fromDate(new Date(2015, 2, 25, 16));
	stop = Cesium.JulianDate.addSeconds(start, 360, new Cesium.JulianDate());
	viewer.clock.startTime = start.clone();
	viewer.clock.stopTime = stop.clone();
	viewer.clock.currentTime = start.clone();
	viewer.clock.clockRange = Cesium.ClockRange.LOOP_STOP; //Loop at the end
	viewer.clock.multiplier = 2.0;
	viewer.clock.shouldAnimate = true;

	var position = computeCirclularFlight( parseFloat( longitude ), parseFloat( latitude ), 0.02);

	var entity = viewer.entities.add({
		availability : new Cesium.TimeIntervalCollection([new Cesium.TimeInterval({
			start : start,
			stop : stop
		})]),
		position : position,
		orientation : new Cesium.VelocityOrientationProperty(position),
		point : {
			pixelSize : 5,
			color : Cesium.Color.RED,
		}
	});

	entity.position.setInterpolationOptions({
		interpolationDegree : 2,
		interpolationAlgorithm : Cesium.LagrangePolynomialApproximation
	});

}



function hover( latitude, longitude  ) {
	
	console.log( latitude + "," + longitude );
	
	start = Cesium.JulianDate.fromDate(new Date(2015, 2, 25, 16));
	stop = Cesium.JulianDate.addSeconds(start, 360, new Cesium.JulianDate());

	viewer.clock.startTime = start.clone();
	viewer.clock.stopTime = stop.clone();
	viewer.clock.currentTime = start.clone();
	viewer.clock.clockRange = Cesium.ClockRange.LOOP_STOP; //Loop at the end
	viewer.clock.multiplier = 2.0;
	viewer.clock.shouldAnimate = true;

	var position = computeCirclularFlight( parseFloat( longitude ), parseFloat( latitude ), 0.02);

	var entity = viewer.entities.add({
		availability : new Cesium.TimeIntervalCollection([new Cesium.TimeInterval({
			start : start,
			stop : stop
		})]),
		position : position,
		orientation : new Cesium.VelocityOrientationProperty(position),
		point : {
			pixelSize : 1,
			color : Cesium.Color.RED,
		}
	});

	entity.position.setInterpolationOptions({
		interpolationDegree : 2,
		interpolationAlgorithm : Cesium.LagrangePolynomialApproximation
	});

	var camera = viewer.camera;
	camera.position = new Cesium.Cartesian3(0.25, 0.0, 0.0);
	camera.direction = new Cesium.Cartesian3(1.0, 0.0, 0.0);
	camera.up = new Cesium.Cartesian3(0.0, 0.0, 1.0);
	camera.right = new Cesium.Cartesian3(0.0, -1.0, 0.0);

	viewer.scene.postUpdate.addEventListener(function(scene, time) {
		var position = entity.position.getValue(time);
		if (!Cesium.defined(position)) {
			return;
		}
		var transform;
		if (!Cesium.defined(entity.orientation)) {
			transform = Cesium.Transforms.eastNorthUpToFixedFrame(position);
		} else {
			var orientation = entity.orientation.getValue(time);
			if (!Cesium.defined(orientation)) {
				return;
			}
			transform = Cesium.Matrix4.fromRotationTranslation(Cesium.Matrix3.fromQuaternion(orientation), position);
		}
		// Save camera state
		var offset = Cesium.Cartesian3.clone(camera.position);
		var direction = Cesium.Cartesian3.clone(camera.direction);
		var up = Cesium.Cartesian3.clone(camera.up);
		// Set camera to be in model's reference frame.
		camera.lookAtTransform(transform);
		// Reset the camera state to the saved state so it appears fixed in the model's frame.
		Cesium.Cartesian3.clone(offset, camera.position);
		Cesium.Cartesian3.clone(direction, camera.direction);
		Cesium.Cartesian3.clone(up, camera.up);
		Cesium.Cartesian3.cross(direction, up, camera.right);

		var rollV = Cesium.Math.toDegrees( camera.roll );
		var pitchV = Cesium.Math.toDegrees( camera.pitch ) ;
		var headingV = 360 - Cesium.Math.toDegrees( camera.heading );
		var altitudeV = camera.positionCartographic.height;

		attitude.setRoll( rollV );
		attitude.setPitch( pitchV );	
		heading.setHeading ( Cesium.Math.toDegrees( camera.heading ) );
		altimeter.setAltitude( altitudeV  );	
		jQuery("#compassPointer").rotate( headingV );
		jQuery("#rosaVentos").rotate( headingV );

		jQuery("#mapHeading").text( 'Y: ' + headingV.toFixed(0) + "\xB0 " );
		jQuery("#mapAttRoll").text( 'Z: ' + rollV.toFixed(0) + "\xB0 " );
		jQuery("#mapAttPitch").text( 'X: ' + pitchV.toFixed(0) + "\xB0 " );

		jQuery("#mapAltitude").text( 'Cam: ' + altitudeV.toFixed(0) + "m" );

	});

}



function computeCirclularFlight(lon, lat, radius) {
	var property = new Cesium.SampledPositionProperty();
	var startAngle = Cesium.Math.nextRandomNumber() * 360.0;
	var endAngle = startAngle + 360.0;

	var increment = 5;//(Cesium.Math.nextRandomNumber() * 2.0 - 1.0) * 50.0 + 5.0;

	for (var i = startAngle; i < endAngle; i += increment) {
		var radians = Cesium.Math.toRadians(i);
		var timeIncrement = i - startAngle;
		var time = Cesium.JulianDate.addSeconds(start, timeIncrement, new Cesium.JulianDate());
		var position = Cesium.Cartesian3.fromDegrees(lon + (radius * 1.5 * Math.cos(radians)), lat + (radius * Math.sin(radians)), /*Cesium.Math.nextRandomNumber() * 600 + 500*/ 1000);

		//Also create a point for each sample we generate.
		/*
        viewer.entities.add({
            position : position,
            point : {
                pixelSize : 8,
                color : Cesium.Color.TRANSPARENT
            }
        });
		 */
		property.addSample(time, position);
	}
	return property;
}


function computeFlight( arrayOfCartesian3 ) {
	var property = new Cesium.SampledPositionProperty();

	for ( var i = 0; i < arrayOfCartesian3.length; i++ ) {
		var time = Cesium.JulianDate.addSeconds( start, i, new Cesium.JulianDate() );
		var position = arrayOfCartesian3[i];

		//Also create a point for each sample we generate.
		viewer.entities.add({
			position : position,
			point : {
				pixelSize : 8,
				color : Cesium.Color.TRANSPARENT
			}
		});
		property.addSample(time, position);
	}

	return property;
}


function stopSimulation(){
	canMove = false;
	var user = mainConfiguration.user.fullName;
	var payload = {};
	payload.user = user;
	payload.uuid = myDroneID;	
	socketBroadcast( "/drone/remove", JSON.stringify( payload ) );
	unsubscribePreUpdate();
	unsubscribePreRender();
	document.removeEventListener('keydown', moveAirplane );
	mainDrone.drone.destroy();
	viewer.entities.remove( mainDrone.path );
	scene.primitives.remove( mainDrone.planeModel );
	simulating = false;
	theSecondCamera = null;
}

function removeDroneFromExternal( payload ){
	for( var xx=0; xx < externalDrones.length;xx++  ){
		var externalDrone = externalDrones[xx];
		if( externalDrone.uuid == payload.uuid ){
			scene.primitives.remove( externalDrone.theDrone );
			externalDrones.splice( xx, 1 );

			showToast( payload.user + ' removeu seu drone.' , 'info', 'Contato Perdido');

			return;
		}
	}	
}

function newDroneFromExternal( payload ){
	// preciso criar logo senao o "Update" vai criar duplicado.
	var externalDrone = {};
	externalDrone.uuid = payload.uuid;
	externalDrones.push( externalDrone );

	var position = Cesium.Cartesian3.fromDegrees( payload.longitude, payload.latitude, payload.height );
	var pheading = Cesium.Math.toRadians( payload.heading );
	var pitch = Cesium.Math.toRadians( payload.pitch );
	var roll = Cesium.Math.toRadians( 0 );	
	var hpr = new Cesium.HeadingPitchRoll( pheading, pitch, roll );
	//var orientation = Cesium.Transforms.headingPitchRollQuaternion(position, hpr);
	var planePrimitive = scene.primitives.add(Cesium.Model.fromGltf({
		url : '/resources/models/air.glb',
		modelMatrix : Cesium.Transforms.headingPitchRollToFixedFrame(position, hpr, Cesium.Ellipsoid.WGS84, fixedFrameTransform),
		minimumPixelSize : 128
	}));
	planePrimitive.readyPromise.then( function(model) {
		externalDrone.theDrone = planePrimitive;
		showToast('Drone de ' + payload.user , 'info', 'Novo Drone Detectado');
	});

}

function updateDroneFromExternal( payload ){
	var position = Cesium.Cartesian3.fromDegrees( payload.longitude, payload.latitude, payload.height );
	var pheading = Cesium.Math.toRadians( payload.heading );
	var pitch = Cesium.Math.toRadians( payload.pitch );
	var roll = Cesium.Math.toRadians( payload.roll );	
	var hpr = new Cesium.HeadingPitchRoll( pheading, pitch, roll );

	for( var xx=0; xx < externalDrones.length;xx++  ){
		var externalDrone = externalDrones[xx];
		if( externalDrone.uuid == payload.uuid ){
			if( externalDrone.theDrone ) {
				Cesium.Transforms.headingPitchRollToFixedFrame(position, hpr, Cesium.Ellipsoid.WGS84, fixedFrameTransform, externalDrone.theDrone.modelMatrix)
			}
			return; // Se achou, sai.
		}
	}

	// Nao achou o drone. Provavelmente entramos depois. 
	// Cria um entao...
	newDroneFromExternal( payload );

}

function simulator( longitude, latitude, height ){
	if( simulating ) return;
	simulating = true;

	var canvas = viewer.canvas;
	canvas.setAttribute('tabindex', '0'); 
	canvas.addEventListener('click', function() {
		canvas.focus();
	});
	canvas.focus();	    	

	var scene = viewer.scene;

	var pathPosition = new Cesium.SampledPositionProperty();
	var entityPath = viewer.entities.add({
		position : pathPosition,
		name : 'path',
		path : {
			show : true,
			leadTime : 0,
			trailTime : 60,
			width : 10,
			resolution : 1,
			material : new Cesium.PolylineGlowMaterialProperty({
				glowPower : 0.3,
				taperPower : 0.3,
				color : Cesium.Color.PALEGOLDENROD
			})
		}
	});

	var camera = viewer.camera;
	var center = new Cesium.Cartesian3();
	var position = Cesium.Cartesian3.fromDegrees( longitude, latitude, height );
	var speedVector = new Cesium.Cartesian3();

	var planePrimitive = scene.primitives.add(Cesium.Model.fromGltf({
		url : '/resources/models/air.glb',
		modelMatrix : Cesium.Transforms.headingPitchRollToFixedFrame(position, hpRoll, Cesium.Ellipsoid.WGS84, fixedFrameTransform),
		minimumPixelSize : 128
	}));

	planePrimitive.readyPromise.then(function(model) {

		model.activeAnimations.addAll({
			multiplier : 0.05,
			loop : Cesium.ModelAnimationLoop.REPEAT
		});

		Cesium.Matrix4.multiplyByPoint(model.modelMatrix, model.boundingSphere.center, center);
		var heading = Cesium.Math.toRadians( 0.0 );
		var pitch = Cesium.Math.toRadians( -35.0 );
		hpRange.heading = heading;
		hpRange.pitch = pitch;
		hpRange.range = 1500;
		createSecondCamera( position, hpRange );	
		theSecondCamera.lookAt( position, hpRange );

		var drone = new Drone( longitude, latitude, height-20, Cesium.Math.toDegrees( heading ), Cesium.Math.toDegrees( pitch ), 8500, false );
		mainDrone.drone = drone;
		mainDrone.path = entityPath;
		mainDrone.planeModel = planePrimitive;

		// Divulga o novo drone
		var user = mainConfiguration.user.fullName;
		var payload = {};
		payload.user = user;
		payload.uuid = myDroneID;
		payload.longitude = longitude;
		payload.latitude = latitude;
		payload.height = height;
		payload.heading = Cesium.Math.toDegrees( heading );
		payload.pitch = Cesium.Math.toDegrees( 0 );
		payload.distance = 8500;
		payload.range = hpRange.range; 
		socketBroadcast( "/drone/create", JSON.stringify( payload ) );
	});




	unsubscribePreUpdate = viewer.scene.preUpdate.addEventListener(function(scene, time) {
		if( !canMove ) return;

		speedVector = Cesium.Cartesian3.multiplyByScalar(Cesium.Cartesian3.UNIT_X, 9, speedVector);
		position = Cesium.Matrix4.multiplyByPoint(planePrimitive.modelMatrix, speedVector, position);
		pathPosition.addSample(Cesium.JulianDate.now(), position);
		Cesium.Transforms.headingPitchRollToFixedFrame(position, hpRoll, Cesium.Ellipsoid.WGS84, fixedFrameTransform, planePrimitive.modelMatrix);

		var cartographic = Cesium.Cartographic.fromCartesian(position);
		var longitude = Cesium.Math.toDegrees(cartographic.longitude);
		var latitude = Cesium.Math.toDegrees(cartographic.latitude);
		var height = cartographic.height;

		Cesium.Matrix4.multiplyByPoint(planePrimitive.modelMatrix, planePrimitive.boundingSphere.center, position);
		hpRange.heading = hpRoll.heading;
		hpRange.pitch = hpRoll.pitch + Cesium.Math.toRadians( -35.0 ); 

		var heading = Cesium.Math.toDegrees(hpRange.heading);
		var pitch = Cesium.Math.toDegrees(hpRange.pitch);

		theSecondCamera.lookAt(position, hpRange);
		mainDrone.drone.updatePosition( longitude, latitude, height-20, heading, pitch );	 


		// Atualiza a posicao deste drone nos outros browsers
		var user = mainConfiguration.user.fullName;
		var payload = {};
		payload.user = user;
		payload.uuid = myDroneID;
		payload.longitude = longitude;
		payload.latitude = latitude;
		payload.height = height;
		payload.heading = Cesium.Math.toDegrees( hpRoll.heading );
		payload.pitch = Cesium.Math.toDegrees( hpRoll.pitch );
		payload.roll = Cesium.Math.toDegrees( hpRoll.roll );
		socketBroadcast( "/drone/update", JSON.stringify( payload ) );

	});		    

	unsubscribePreRender = viewer.scene.preRender.addEventListener(function(scene, time) {
		//updatePanelFooter( position );

		var cartographic = Cesium.Cartographic.fromCartesian(position);
		var longitude = Cesium.Math.toDegrees(cartographic.longitude);
		var latitude = Cesium.Math.toDegrees(cartographic.latitude);
		var height = cartographic.height;

		attitude.setRoll( Cesium.Math.toDegrees( hpRoll.roll ) );
		attitude.setPitch( Cesium.Math.toDegrees( hpRoll.pitch ) );	
		heading.setHeading ( Cesium.Math.toDegrees(hpRoll.heading) );
		altimeter.setAltitude( height );	
		jQuery("#compassPointer").rotate( Cesium.Math.toDegrees(hpRoll.heading) );		
	});		


	document.addEventListener('keydown', moveAirplane );	
	return mainDrone;
}

function createSecondCamera( position, hpRange ){
	//var cartographic = Cesium.Cartographic.fromCartesian(position);
	//var longitude = Cesium.Math.toDegrees(cartographic.longitude);
	//var latitude = Cesium.Math.toDegrees(cartographic.latitude);	    

	/*
	var baseOsmProvider = new Cesium.createOpenStreetMapImageryProvider({
		url : 'https://a.tile.openstreetmap.org/'
	});
	 */	
	var providers = [];
	providers.push( createImageryProvider( mapproxy, 'rapideye', false, 1.0, 'jpeg' ) );
	//providers.push( createImageryProvider( volcano, 'volcano:hillshade', false, 1.0, 'jpeg' ) );
	//providers.push( createImageryProvider( mapproxy, 'bdgex', false, 1.0, 'png' ) );
	var indx = Math.floor(Math.random() * providers.length );

	var sCviewer = new Cesium.Viewer('secondCamera', {
		terrainProvider : terrainProvider,
		timeline: false,
		animation: false,
		baseLayerPicker: false,
		skyAtmosphere: false,
		fullscreenButton : false,
		geocoder : false,
		homeButton : false,
		infoBox : false,
		sceneModePicker : false,
		selectionIndicator : false,
		navigationHelpButton : false,
		requestRenderMode : true,
		imageryProvider: providers[indx],
		scene3DOnly : true,
		shouldAnimate : false
	});

	theSecondCamera = sCviewer.camera;
	var scene = sCviewer.scene;    
	var controller = scene.screenSpaceCameraController;


	scene.highDynamicRange = false;
	scene.globe.enableLighting = false;
	scene.globe.baseColor = Cesium.Color.WHITE;
	scene.screenSpaceCameraController.enableLook = false;
	scene.screenSpaceCameraController.enableCollisionDetection = false;
	scene.globe.maximumScreenSpaceError = 1;
	scene.globe.depthTestAgainstTerrain = true;
	scene.pickTranslucentDepth = true;
	scene.useDepthPicking = true;

	jQuery(".cesium-viewer-bottom").hide();
	jQuery(".navigation-controls").hide();    
	jQuery("#secondCamera .cesium-viewer-navigationContainer").hide();    


}

function moveAirplane( e ){
	//console.log( e.keyCode );
	// w = 87
	// s = 83

	switch (e.keyCode) {
	case 87:
		canMove = true;
		followThePlane = true;
		break;
	case 83:
		canMove = false;
		break;
	case 40:
		if (e.shiftKey) {
			// speed down
			// speed = Math.max(--speed, 1);
		} else {
			// pitch down
			hpRoll.pitch -= deltaRadians;
			if (hpRoll.pitch < -Cesium.Math.TWO_PI) {
				hpRoll.pitch += Cesium.Math.TWO_PI;
			}
		}
		break;
	case 38:
		if (e.shiftKey) {
			// speed up
			//speed = Math.min(++speed, 100);
		} else {
			// pitch up
			hpRoll.pitch += deltaRadians;
			if (hpRoll.pitch > Cesium.Math.TWO_PI) {
				hpRoll.pitch -= Cesium.Math.TWO_PI;
			}
		}
		break;
	case 39:
		if (e.shiftKey) {
			// roll right
			hpRoll.roll += deltaRadians;
			if (hpRoll.roll > Cesium.Math.TWO_PI) {
				hpRoll.roll -= Cesium.Math.TWO_PI;
			}
		} else {
			// turn right
			hpRoll.heading += deltaRadians;
			if (hpRoll.heading > Cesium.Math.TWO_PI) {
				hpRoll.heading -= Cesium.Math.TWO_PI;
			}
		}
		break;
	case 37:
		if (e.shiftKey) {
			// roll left until
			hpRoll.roll -= deltaRadians;
			if (hpRoll.roll < 0.0) {
				hpRoll.roll += Cesium.Math.TWO_PI;
			}
		} else {
			// turn left
			hpRoll.heading -= deltaRadians;
			if (hpRoll.heading < 0.0) {
				hpRoll.heading += Cesium.Math.TWO_PI;
			}
		}
		break;
	default:
	}
}



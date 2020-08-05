
class Radar {
    constructor( longitude, latitude , height, pitch, distance, goto ) {
    	this.viewshed3D = new Cesium.ViewShed3D(scene);
        this.viewshed3D.hintLineColor = Cesium.Color.ORANGE;
        this.viewshed3D.hiddenAreaColor = Cesium.Color.ORANGERED.withAlpha(0.2); 
        this.viewshed3D.visibleAreaColor = Cesium.Color.LIME.withAlpha(0.2);
    	this.viewshed3D.viewPosition = [longitude, latitude, height];
    	this.viewshed3D.direction = 0;
    	this.viewshed3D.pitch = pitch ;
    	this.viewshed3D.distance = distance;
    	this.viewshed3D.horizontalFov = 90;
    	this.viewshed3D.verticalFov = 30;	
    	this.viewshed3D.build();
    	
    	if( goto ) {
	    	viewer.camera.flyTo({
	    	    destination : Cesium.Cartesian3.fromDegrees( longitude, latitude, 4000 ),
	    	});
    	}
    	
    	
    }
    
    init() {
    	var me = this;
    	this.radarEvt = setInterval(
    			function(){
    	    		var dir = me.viewshed3D.direction;
    	    		dir++;
    	    		if( dir === 360 ) dir = 0;
    	    		me.viewshed3D.direction = dir;
    	    	}, 50);
    }
    
    destroy() {
    	clearInterval( this.radarEvt );
    	this.viewshed3D.destroy()
    }
}



class Drone {
	updatePosition( longitude, latitude, height, heading, pitch ){
		this.viewshed3D.viewPosition = [longitude, latitude, height];
		this.viewshed3D.direction = heading;
		this.viewshed3D.pitch = pitch;
	}
	
	getSensor(){
		return this.viewshed3D;
	}
	
    constructor( longitude, latitude , height, direction, pitch, distance, goto ) {
    	this.viewshed3D = new Cesium.ViewShed3D(scene);
        this.viewshed3D.hintLineColor = Cesium.Color.ORANGE;
        this.viewshed3D.hiddenAreaColor = Cesium.Color.ORANGERED.withAlpha(0.2); 
        this.viewshed3D.visibleAreaColor = Cesium.Color.LIME.withAlpha(0.2);
    	this.viewshed3D.viewPosition = [longitude, latitude, height];
    	this.viewshed3D.direction = 0;
    	this.viewshed3D.pitch = pitch;
    	this.viewshed3D.distance = distance;
    	this.viewshed3D.horizontalFov = 90;
    	this.viewshed3D.verticalFov = 50;	
    	this.viewshed3D.build();
    	
    	if( goto ) {
	    	viewer.camera.flyTo({
	    	    destination : Cesium.Cartesian3.fromDegrees( longitude, latitude, height ),
			    orientation : {
			        heading : Cesium.Math.toRadians( direction ),
			        pitch : Cesium.Math.toRadians( pitch ),
			        roll : 0.0
			    }	    	    
	    	});
    	}
    	
    	
    }
    
    init() {
    	var me = this;
    	console.log('Fazer o drone voar...');
    }
    
    destroy() {
    	this.viewshed3D.destroy()
    }
}


class Dome {
	updatePosition( longitude, latitude, height ){
		this.viewshed3D.viewPosition = [longitude, latitude, height];
		this.viewshed3D.direction = 0;
		//this.viewshed3D.pitch = 90;
	}
	
	getSensor(){
		return this.viewshed3D;
	}
	
    constructor( longitude, latitude , height, distance, goto ) {
    	this.viewshed3D = new Cesium.ViewShed3D(scene);
        this.viewshed3D.hintLineColor = Cesium.Color.ORANGE;
        this.viewshed3D.hiddenAreaColor = Cesium.Color.ORANGERED.withAlpha(0.2); 
        this.viewshed3D.visibleAreaColor = Cesium.Color.LIME.withAlpha(0.2);
    	this.viewshed3D.viewPosition = [longitude, latitude, height];
    	this.viewshed3D.direction = 0;
    	this.viewshed3D.pitch = 90;
    	this.viewshed3D.distance = distance;
    	this.viewshed3D.horizontalFov = 179;
    	this.viewshed3D.verticalFov = 179;	
    	this.viewshed3D.build();
    	
    	if( goto ) {
	    	viewer.camera.flyTo({
	    	    destination : Cesium.Cartesian3.fromDegrees( longitude, latitude, height )
	    	});
    	}
    	
    	
    }
    
    init() {
    	var me = this;
    }
    
    destroy() {
    	this.viewshed3D.destroy()
    }
}


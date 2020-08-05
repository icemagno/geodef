var tileset  = null;

function loadPC( ) {
	// http://sisgeodef.defesa.mil.br:36300/congonhas-ept/ept-tileset/tileset.json
	/*
	[ 
		[ 
			[ -46.664501741602315, -23.631073219184234, 786.28 ], 
			[ -46.664476297403048, -23.629060588877895, 786.28 ], 
			[ -46.661445339672817, -23.629093084640861, 864.46 ], 
			[ -46.661470737591024, -23.631105718044537, 864.46 ]
		] 
	]	
	*/
	
	/*
	var west = -46.66144534;
	var south = -23.62906059;
	var east = -40;
	var north = -20;	
	
	var homeLocation = Cesium.Rectangle.fromDegrees(west, south, east, north);
	
	var positions = Cesium.Cartesian3.fromDegreesArrayHeights([
		-46.664501741602315, -23.631073219184234, 786.28, 
		-46.664476297403048, -23.629060588877895, 786.28,
		-46.661445339672817, -23.629093084640861, 864.46,
		-46.661470737591024, -23.631105718044537, 864.46]);
	
	polygon = viewer.entities.add({
	    polygon : {
	    	hierarchy : positions,
	    	material : Cesium.Color.INDIANRED.withAlpha(0.6),
	    	clampToGround : true
	    }
	});	
	*/
	
	//***************************************************************************
	scene.globe.depthTestAgainstTerrain = true;
	
	tileset = scene.primitives.add(new Cesium.Cesium3DTileset({
	     url : 'http://sisgeodef.defesa.mil.br:36280/congonhas/tileset.json',
	     debugShowBoundingVolume : true,
	     //skipLevelOfDetail : true,
	     //baseScreenSpaceError : 1024,
	     //skipScreenSpaceErrorFactor : 16,
	     //skipLevels : 1,
	     //immediatelyLoadDesiredLevelOfDetail : false,
	     //loadSiblings : false,
	     //cullWithChildrenBounds : true
	}));	
	
	
	tileset.style = new Cesium.Cesium3DTileStyle({
	    pointSize: 3
	});
	
	
/*
	tileset.readyPromise.then(function() {
		
		var heightOffset = 2625;
		var boundingSphere = tileset.boundingSphere;
		var cartographic = Cesium.Cartographic.fromCartesian(boundingSphere.center);
		
		var surface = Cesium.Cartesian3.fromRadians(cartographic.longitude, cartographic.latitude, 0.0);
		var offset = Cesium.Cartesian3.fromRadians(cartographic.longitude, cartographic.latitude, heightOffset);
		
		var translation = Cesium.Cartesian3.subtract(offset, surface, new Cesium.Cartesian3());
		tileset.modelMatrix = Cesium.Matrix4.fromTranslation(translation);		

		viewer.camera.viewBoundingSphere(tileset.boundingSphere, new Cesium.HeadingPitchRange(0, -0.5, 0));
		
		//updateTileset(tileset.root);
		
	})
	.otherwise(function(error){
	    console.log(error)
	});
	
*/
	
	viewer.zoomTo(tileset).otherwise(function (error) {
        console.log(error);
    });
    
	
	
}

function updateTileset(root) {
	
    if (root.contentReady) {
        updateTile(root);
    } else {
        var listener = tileset.tileLoad.addEventListener(function(tile) {
            if (tile === root) {
                updateTile(tile);
                listener();
            }
        });
    }

    var children = root.children;
    var length = children.length;
    for (var i = 0; i < length; ++i) {
        updateTileset(children[i]);
    }
 
}

function updateTile (tile) {
    var boundingVolume = tile.boundingVolume;
    if ( Cesium.defined(tile.contentBoundingVolume) ) {
        boundingVolume = tile.contentBoundingVolume;
    }
    
    var content = tile.content;
    
    //console.log( tileset.root.content._pointCloud._rtcCenter );    
    //console.log( tile.content._pointCloud._rtcCenter );    
    
    // ------------ 
	var heightOffset = 2625;
	var boundingSphere = boundingVolume.boundingSphere;
	var cartographic = Cesium.Cartographic.fromCartesian(boundingSphere.center);

	console.log( cartographic );
	
	var surface = Cesium.Cartesian3.fromRadians(cartographic.longitude, cartographic.latitude, 0.0);
	var offset = Cesium.Cartesian3.fromRadians(cartographic.longitude, cartographic.latitude, heightOffset);
	
	var translation = Cesium.Cartesian3.subtract(offset, surface, new Cesium.Cartesian3());
	
	console.log( translation );
	
	//tileset.modelMatrix = Cesium.Matrix4.fromTranslation(translation);		
    // ----------------
    
    
    /*
    var model = content._pointCloud;
    var center = model._rtcCenter;
    var carto = Cesium.Cartographic.fromCartesian(center);

    //var height = boundingVolume.minimumHeight;
    var height = carto.height;

    var normal = scene.globe.ellipsoid.geodeticSurfaceNormal(center, new Cesium.Cartesian3() );
    var offset = Cesium.Cartesian3.multiplyByScalar(normal, height, new Cesium.Cartesian3() );
    
    var promise = Cesium.when.defer();
    
    console.log( 'Carto: ' + carto );
    console.log( 'Center: ' + center );
    console.log( 'Normal ' + normal );
    console.log( 'Height : ' + height );
    console.log( 'Offset : ' + offset );
    

    promise = Cesium.sampleTerrainMostDetailed(scene.terrainProvider, [carto]).then(function(results) {
        var result = results[0];
        console.log( result );
        if (!Cesium.defined(result)) {
            return carto;
        }
        return result;
    });
    */
    
    /*
    if (scene.terrainProvider === ellipsoidTerrainProvider) {
        var result = carto;
        result.height = 0;
        promise.resolve(result);
    } else {
        promise = Cesium.sampleTerrainMostDetailed(scene.terrainProvider, [carto]).then(function(results) {
            var result = results[0];
            if (!Cesium.defined(result)) {
                return carto;
            }
            return result;
        });
    }
    */

	/*
    promise.then(function(result) {
        result = Cesium.Cartographic.toCartesian(result);
        var position = Cartesian3.subtract(result, offset, new Cartesian3());
        model._rtcCenter = Cartesian3.clone(position, model._rtcCenter);
    });
    */
}
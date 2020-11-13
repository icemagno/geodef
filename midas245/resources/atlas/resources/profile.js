var profileGeometries = {};

function showProfileCard( data ){
	var elevationDatas = data.elevationDatas;
	var profilePoints = data.profilePoints;
	
	$("body").addClass("sidebar-collapse");
	$("#terrainProfileContainer").remove();
	
	var profileCard = '<div id="terrainProfileContainer" style="width: 70%; position: absolute; bottom: 10px; height: 200px; right: 230px;" class="box box-info">' +
    '<div class="box-header with-border">'+
    '<h3 class="box-title">Perfil de Elevação de Terreno</h3><h3 style="margin-left:100px" id="terrainProfileDescription" class="box-title"></h3><div class="box-tools pull-right">' +
    '<button type="button" title="Salvar como Camada" id="terrainProfileSaveBtn" style="margin-right:10px" class="btn btn-primary"><i style="font-size: 18px;" class="fa fa-save"></i></button>' +
    '<button type="button" title="Fechar" id="terrainProfileCloseBtn" class="btn"><i style="font-size: 18px;" class="fa fa-times"></i></button>' +
    '</div></div><div style="padding: 0px;" class="box-body chart-responsive"><div class="chart" id="line-chart" style="height: 150px;width:100%"></div></div></div>';	
	
	$("#cesiumContainer").append( profileCard ) ;


	var line = new Morris.Line({
      element: 'line-chart',
      data: elevationDatas,
      hoverCallback: function (index, options, content, row) {
    	  var coordHDMS = convertDMS(elevationDatas[index].latitude,elevationDatas[index].longitude);
    	  var description = coordHDMS.lat + " " + coordHDMS.latCard + ' || ' + coordHDMS.lon + " " + coordHDMS.lonCard + " || " + elevationDatas[index].height.toFixed(2) + "m";
    	  $("#terrainProfileDescription").text( description );
    	  viewer.camera.flyTo({destination: Cesium.Cartesian3.fromDegrees(elevationDatas[index].longitude, elevationDatas[index].latitude, 15000), duration: 1});
    	  
    	  for(x=0; x<profilePoints.length;x++  ){
    		  profilePoints[x].point.pixelSize = 4
    	  }
    	  profilePoints[index].point.pixelSize = 15;
      },      
      xkey: 'x',
      ykeys: ['height'],
      labels: ['Altura(m)'],
      lineColors: ['#3c8dbc'],
      hideHover: 'auto',
      parseTime: false
    });	
	

    $('#line-chart').resize(function () {
    	line.redraw();
	});    
    
    $("#terrainProfileCloseBtn").click( function(){
    	$("#terrainProfileContainer").remove();	
    });

    $("#terrainProfileSaveBtn").click( function(){
    	saveTerrainProfile();
    });

}

function modelCallback(modelGraphics, time, externalFiles) {
    var resource = modelGraphics.uri.getValue(time);
    console.log( resource );
}

function saveTerrainProfile(){
    console.log( profileGeometries );

    /*
    var entityCollection = new Cesium.EntityCollection();

    Cesium.exportKml({
        entities: entityCollection,
        kmz: true,
        modelCallback: modelCallback,
    }).then(function(result) {
        // The XML string is in result.kml
        var externalFiles = result.externalFiles
        for(var file in externalFiles) {
         // file is the name of the file used in the KML document as the href
         // externalFiles[file] is a blob with the contents of the file
        }
    });
    */
}


function calcLineTerrainProfile(){

	drawHelper.startDrawingPolyline({
		callback: function(positions) {
			
            var polyline = new DrawHelper.PolylinePrimitive({
                positions: positions,
                width: 2,
                geodesic: true
            });	
            scene.primitives.add( polyline );
            
            profileGeometries.line = polyline;
            

            var result = doProfile( polyline, 60 ); // Numero de pontos a serem gerados na interpolacao
            var cartographics = [];
            for( x=0; x < result.length; x++ ){
            	var cartesian = result[x];
        		var cartographic = Cesium.Cartographic.fromCartesian( cartesian );
                cartographics.push( cartographic );
            }
            
            
            var promise = Cesium.sampleTerrainMostDetailed( terrainProvider, cartographics );
            Cesium.when( promise , function( positions ) {
            	
            	var elevationDatas = [];
            	var profilePoints = [];
            	
            	for( x=0; x < positions.length; x++ ){
            		var position = positions[x];
                    var longitude = Cesium.Math.toDegrees( position.longitude );
                    var latitude = Cesium.Math.toDegrees( position.latitude );
                    var height = position.height;
                    
                    var elevationData = {  };
                    elevationData.x = x;
                    elevationData.height = height;
                    elevationData.latitude = latitude;
                    elevationData.longitude = longitude;
                    elevationDatas.push( elevationData );
                    
                    var profilePoint = viewer.entities.add({
            		    position : result[x],
            		    point : {
            		        pixelSize : 4,
            		        color : Cesium.Color.RED,
            		        outlineColor : Cesium.Color.WHITE,
            		        outlineWidth : 1
            		    }
            		});
                    profilePoints.push( profilePoint );
            	}
                
                profileGeometries.points = profilePoints;

            	var resultData = {};
            	resultData.elevationDatas = elevationDatas;
            	resultData.profilePoints = profilePoints;
            	showProfileCard( resultData );
            	
            });
            
		}
	});
	
}
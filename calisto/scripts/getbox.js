

function run(){
	
	getBox( function( points ){
		var cartographics = points.cartographic;
		if( cartographics.length < 3 ) return;
		
		console.log( cartographics );
		
		var lineString = "LINESTRING(";
		var sep = "";
		for( x=0; x<cartographics.length; x++ ){
			lineString = lineString + sep + cartographics[x].lon + " " +cartographics[x].lat;
			sep = ",";
		}	
		lineString = lineString + "," + cartographics[0].lon + " " +cartographics[0].lat + ")";
		
	    jQuery.ajax({
			//url:"http://sisgeodef.defesa.mil.br:36003/ibge/municipios", 
			url:"/metoc/municipios", 
			type: "POST", 
			data : {'lineString':lineString},
			success: function( obj ) {
				
				
				console.log( obj );
				var promise = Cesium.GeoJsonDataSource.load( obj, {
					clampToGround: false,
				});

				promise.then(function(dataSource) {
					// viewer.dataSources.add( dataSource );
					var entities = dataSource.entities.values;
					for (var i = 0; i < entities.length; i++) {
						var entity = entities[i];
						var municipio = entity.properties['nm_municip'].getValue();
						
						// https://apiprevmet3.inmet.gov.br/previsao/5300108
						// https://apitempo.inmet.gov.br/estacao/diaria/2020-07-01/2020-07-31/A422
						// https://apitempo.inmet.gov.br/estacoes/T
						// https://apitempo.inmet.gov.br/estacoes/M
						// https://tempo.inmet.gov.br/TabelaEstacoes/A422
						
						var center = Cesium.BoundingSphere.fromPoints( entity.polygon.hierarchy.getValue().positions ).center;
						var entity = viewer.entities.add({
							position : center,
							/*
							label: {
								text: municipio,
								font: "9px Helvetica",
								fillColor: Cesium.Color.WHITE,
								outlineColor: Cesium.Color.BLACK,
								outlineWidth: 1,
								style: Cesium.LabelStyle.FILL_AND_OUTLINE,	
								horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
								eyeOffset : new Cesium.Cartesian3(0.0, 600.0, 0.0),
								pixelOffsetScaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.0, 1.5e7, 0.7),
								heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
								disableDepthTestDistance : Number.POSITIVE_INFINITY,								
								
							},
							*/
							billboard :{
								image : '/resources/img/pin-start.png',
								pixelOffset : new Cesium.Cartesian2(0, -10),
								scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.6, 1.5e7, 0.2),
								heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
								disableDepthTestDistance : Number.POSITIVE_INFINITY            
							}
						});
	   
						
						
					}
					
				});
				
				
			},
		    error: function(xhr, textStatus) {
		    	//
		    }, 		
	    });
		
		
	});
		
}

var pickHandle = null;


function loadPrevisaoDoTempo(){
	getBox( function( points ) {
		var cartographics = points.cartographic;
		if( cartographics.length < 3 ) return;
		
		var lineString = "LINESTRING(";
		var sep = "";
		for( x=0; x<cartographics.length; x++ ){
			lineString = lineString + sep + cartographics[x].lon + " " +cartographics[x].lat;
			sep = ",";
		}	
		lineString = lineString + "," + cartographics[0].lon + " " +cartographics[0].lat + ")";
		
		processaMunicipios( lineString );
		processaAerodromos( lineString );
	});
}

function processaAerodromos( lineString ){
	var loadingId = createUUID();
	
    jQuery.ajax({
		url:"/metoc/aerodromos", 
		type: "POST", 
		data : {'lineString':lineString},
		beforeSend : function() { 
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Aguarde...</td></tr>";
			jQuery("#metocMenuTable").append( loading );
		},		
		success: function( obj ) {
			var tr = jQuery("#" + loadingId );
			var promise = Cesium.GeoJsonDataSource.load( obj, {
				clampToGround: true,
			});

			promise.then(function(dataSource) {

				var entities = dataSource.entities.values;
				for (var i = 0; i < entities.length; i++) {
					var entity = entities[i];
					
					
			    	var platPoint = viewer.entities.add({
			    		name : 'AERODROMO_METOC',
			            position : entity.position,
			            properties : entity.properties,
					    ellipse: {
					    	outline : true,
					    	extrudedHeight : 210,
					    	heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
					    	height : 15,
					        semiMajorAxis: 500,
					        semiMinorAxis: 500,
			                material: new Cesium.ImageMaterialProperty({ 
			                	color :  Cesium.Color.RED, //.withAlpha(0.9)
			                }),   
					    },
			            label : {
			                text : entity.properties['aerocode'].getValue(),
			                //style : Cesium.LabelStyle.FILL_AND_OUTLINE,
			                fillColor : Cesium.Color.BLACK,
			                //outlineColor : Cesium.Color.BLACK,	                
			                font: '12px Consolas',
			                //outlineWidth : 1,
			                showBackground : false,
			                backgroundColor : Cesium.Color.WHITE,
			                horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
			                eyeOffset : new Cesium.Cartesian3(0.0, 1500.0, 0.0),
			                pixelOffsetScaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.3, 1.5e7, 0.5),
			                heightReference : Cesium.HeightReference.RELATIVE_TO_GROUND,
			                disableDepthTestDistance : Number.POSITIVE_INFINITY,
			            }					    
					    
			    	});
					
				}
		        tr.fadeOut(5000, function(){
		            tr.remove();
		        });					
			});
			
			
		},
	    error: function(xhr, textStatus) {
	    	var tr = jQuery("#" + loadingId );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });			    	
	    }, 		
    });
	
}


function processaMunicipios( lineString ){
	var loadingId = createUUID();
    jQuery.ajax({
		url:"/metoc/municipios", 
		type: "POST", 
		data : {'lineString':lineString},
		beforeSend : function() { 
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Aguarde...</td></tr>";
			jQuery("#metocMenuTable").append( loading );
		},		
		success: function( obj ) {
			var municipios = {};
			var tr = jQuery("#" + loadingId );
			var promise = Cesium.GeoJsonDataSource.load( obj, {
				clampToGround: false,
			});

			promise.then(function(dataSource) {
				var entities = dataSource.entities.values;
				
				for (var i = 0; i < entities.length; i++) {
					var entity = entities[i];
					var nmMunicipio = entity.properties['nm_municip'].getValue();
					var geocode = entity.properties['cd_geocodm'].getValue();
					var center = Cesium.BoundingSphere.fromPoints( entity.polygon.hierarchy.getValue().positions ).center;
					var newCenter = projectPosition( center, 5000, 0, 0 );
					
					
					var municipio = {};
					municipio.geocode = geocode;
					municipio.nome = nmMunicipio;
					municipio.center = newCenter;
					municipios[ geocode ] = municipio;
					
				}
				
				getTempoMunicipios( municipios );
				
		        tr.fadeOut(5000, function(){
		            tr.remove();
		        });						
			});
			
			
		},
	    error: function(xhr, textStatus) {
	    	var tr = jQuery("#" + loadingId );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });			    	

	    }, 		
    });
	
}


function getTempoMunicipios( municipios ){
	var icones = {};
	// https://apiprevmet3.inmet.gov.br/previsao/5300108
	// https://apitempo.inmet.gov.br/estacao/diaria/2020-07-01/2020-07-31/A422
	// https://tempo.inmet.gov.br/TabelaEstacoes/A422	
	
	var keys = Object.keys( municipios );
	for( xx=0; xx<keys.length;xx++ ) {
		var geoc = keys[xx];
	    jQuery.ajax({
			url:"/metoc/municipio/" + geoc, 
			type: "GET", 
			success: function( obj ) {
				var geocodeKey = Object.keys( obj )[0];
				var previsoes = obj[ geocodeKey ];
				municipios[ geocodeKey ].previsoes = previsoes;
				var dias = Object.keys( previsoes );
				var dataMaisProxima = dias[0];
				var previsaoDefault = previsoes[ dataMaisProxima ].manha;
				if( previsaoDefault != null ){
					var codIcone = previsaoDefault.cod_icone;
					if( icones[ codIcone ] == null ){
						var image = new Image();
						image.src = previsaoDefault.icone;
						icones[ codIcone ] = image;
					}
					
					viewer.entities.add({
						name : 'MUNICIPIO_PREVISAO',
						properties : municipios[ geocodeKey ],
						position : municipios[ geocodeKey ].center,
						billboard :{
							image : icones[ codIcone ] ,
							pixelOffset : new Cesium.Cartesian2(0, -10),
							scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.6, 1.5e7, 0.2),
							heightReference : Cesium.HeightReference.RELATIVE_TO_GROUND,
							disableDepthTestDistance : Number.POSITIVE_INFINITY            
						}
					});					
					
					
				} else {
					console.log( "ERRO : Sem previsao padrao para " + dataMaisProxima );
					console.log( previsoes[ dias[0] ] );
				}
				
			
			},
		    error: function(xhr, textStatus) {
		    	//
		    }, 				
		});	
	    
	}
	
 
}


function showMetarAerodromo( entity ) {
	var icao = entity.properties["aerocode"].getValue();
	var loadingId = createUUID();
	jQuery(".queryRowDetails").remove();
	
    jQuery.ajax({
		url:"/metoc/aerodromo/" + icao, 
		type: "GET", 
		beforeSend : function() { 
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Aguarde...</td></tr>";
			jQuery("#queryMenuTable").append( loading );
		},		
		success: function( obj ) {
			var tr = jQuery("#" + loadingId );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });
	        
	        if( obj.aisweb == null ) return;
	        
	        if( obj.aisweb.met ){
	        	var metar = obj.aisweb.met.metar;
	        	var taf = obj.aisweb.met.taf;
	        	var queryData = "";
	        	
	        	if( metar != "" ){
	        		queryData = queryData + "<tr class='queryRowDetails'>" +
	        			"<td colspan='2' style='text-align: center;background-color:#f0f0f0' class='layerTable'><b>METAR</b></td>" +
	     		   "</tr>";	
	        		queryData = queryData + "<tr class='queryRowDetails'><td colspan='2' class='layerTable'>"+ metar +"</td></tr>";		        		
	        	}
	        	if( taf != "" ){
	        		queryData = queryData + "<tr class='queryRowDetails'>" +
	        			"<td colspan='2' style='text-align: center;background-color:#f0f0f0' class='layerTable'><b>TAF</b></td>" +
	     		   "</tr>";	
	        		queryData = queryData + "<tr class='queryRowDetails'><td colspan='2' class='layerTable'>"+ taf +"</td></tr>";		        		
	        	}
	        	
	           	jQuery("#queryMenuTable").append( queryData );	        	
	        	
	        }
	        
		},
	    error: function(xhr, textStatus) {
			var tr = jQuery("#" + loadingId );
			tr.css("background-color","#FF3700");
	    	jQuery("#" + loadingId + "_td" ).text( 'Erro ao adquirir METAR.' );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	
	    }, 				
	});			
	
	
}

function showPrevisaoMunicipio( entity ){
	var municipio = entity.properties;
	var nome = municipio.nome.getValue();
	var previsoes = municipio.previsoes.getValue(); 
	var geocode = municipio.geocode.getValue();
	var queryData = "";

	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td colspan='2' style='text-align: center;' class='layerTable'><b>"+ nome +"</b></td>" +
	"</tr>";	
	
	
	var dias = Object.keys( previsoes );
	for( xy=0; xy<dias.length;xy++ ) {
		var diaKey = dias[xy];
		var diaValue = previsoes[ diaKey ];
		
		queryData = queryData + "<tr class='queryRowDetails'>" +
		   "<td colspan='2' style='text-align: center;background-color:#f0f0f0' class='layerTable'><b>"+ diaKey +"</b></td>" +
		"</tr>";	
		
		var tabela = "<table style='width:100%;border:0px;margin:0px;padding:0px'>";
		
		if ( diaValue.manha != null ){
			tabela = tabela + "<tr><td>Manhã</td><td>Tarde</td><td>Noite</td></tr>";
			
			tabela = tabela + "<tr><td style='border-right:1px solid #cacaca'><img title='"+ diaValue.manha.resumo +"' style='width: 42px;' src='"+ diaValue.manha.icone +
				"'></td><td style='border-right:1px solid #cacaca'><img title='"+ diaValue.tarde.resumo +"'style='width: 42px;' src='"+ diaValue.tarde.icone +
				"'></td><td><img style='width: 42px;' title='"+ diaValue.noite.resumo +"' src='"+ diaValue.noite.icone + "'></td></tr>";

			tabela = tabela + "<tr><td>"+diaValue.manha.temp_max+"&deg;<img style='width: 10px;margin-right:10px' title='"+diaValue.manha.temp_max_tende+"' src='"+ diaValue.manha.temp_max_tende_icone + "'>" + 
			diaValue.manha.temp_min+ "&deg;<img style='width: 10px;' title='"+diaValue.manha.temp_min_tende+"' src='"+ diaValue.manha.temp_min_tende_icone + "'></td>" +
			"<td>"+diaValue.tarde.temp_max+"&deg;<img style='width: 10px;margin-right:10px' title='"+diaValue.tarde.temp_max_tende+"' src='"+ diaValue.tarde.temp_max_tende_icone + "'>" + 
			diaValue.tarde.temp_min+ "&deg;<img style='width: 10px;' title='"+diaValue.tarde.temp_min_tende+"' src='"+ diaValue.tarde.temp_min_tende_icone + "'></td>" +
			"<td>"+diaValue.noite.temp_max+"&deg;<img style='width: 10px;margin-right:10px' title='"+diaValue.noite.temp_max_tende+"' src='"+ diaValue.noite.temp_max_tende_icone + "'>" + 
			diaValue.noite.temp_min+ "&deg;<img style='width: 10px;' title='"+diaValue.noite.temp_min_tende+"' src='"+ diaValue.noite.temp_min_tende_icone + "'></td>" +
			"</tr>";
			

			tabela = tabela + "<tr><td>"+diaValue.manha.dir_vento+ " " + diaValue.manha.int_vento + 
			"</td><td>"+diaValue.tarde.dir_vento+ " " + diaValue.tarde.int_vento +
			"</td><td>"+diaValue.noite.dir_vento+ " " + diaValue.noite.int_vento + "</td></tr>";
			
			tabela = tabela + "<tr><td>"+diaValue.manha.umidade_max+ "% / " + diaValue.manha.umidade_min + "%" +  
			"</td><td>"+diaValue.tarde.umidade_max+ "% / " + diaValue.tarde.umidade_min + "%" + 
			"</td><td>"+diaValue.noite.umidade_max+ "% / " + diaValue.noite.umidade_min + "%</td></tr>";
			
			
		} else {
			tabela = tabela + "<tr><td>Durante o dia<br>"+diaValue.resumo+"</td></tr>";
		}
		
		tabela = tabela + "</table>";
		
		queryData = queryData + "<tr class='queryRowDetails'>" +
		   "<td colspan='2' style='text-align: center' class='layerTable'>"+ tabela +"</td>" +
		"</tr>";	
		
	}
	
	
	jQuery(".queryRowDetails").remove();
   	jQuery("#queryMenuTable").append( queryData );
	
	
}

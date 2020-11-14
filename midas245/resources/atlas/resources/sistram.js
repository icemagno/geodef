var receivedPlataformas = [];
var receivedNavios = [];
var platPerimeter = null;
var isPlataformaSolutionActive = false;
var plataformaEventHandler = null;

// http://sisgeodef.defesa.mil.br:36207/gt-ope-alpha/v1/scan?lon=-40.81010333333333&lat=-22.703833333333332&raio=10
function scan( lat, lon, raio ) {
	
	for( x=0; x < receivedNavios.length; x++ ) {
		viewer.entities.remove( receivedNavios[x] );
	}
	
	var scanUrl = "/sistram/scan"; 
	var loadingId = createUUID();
    jQuery.ajax({
		url: scanUrl, 
		type: "GET", 
		data: { 'lat':lat, 'lon':lon, 'raio':raio},
		beforeSend : function() {
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Verificando...</td></tr>";
			jQuery("#plataformasMenuTable").append( loading );
		},
		error: function( obj ) {
			var tr = jQuery("#" + loadingId );
			tr.css("background-color","#FF3700");
	    	jQuery("#" + loadingId + "_td" ).text( 'Erro ao adquirir navios.' );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	  					
		},
		success: function( obj ) {
			
			var theMessage;
			var tr = jQuery("#" + loadingId );
			
			if( obj.data ) {
				theMessage = obj.data.length + " embarcações encontradas.";
			        
				for( x=0; x<obj.data.length; x++ ) {
					var navio = obj.data[x];
					var lat = navio.lat;
					var lon = navio.lon;
					var rumo = navio.rumo;

        			var heading = Cesium.Math.toRadians( 0.0 + rumo );
        			var pitch = Cesium.Math.toRadians(0.0);
        			var roll = Cesium.Math.toRadians(0.0);				    
				    
					var position = Cesium.Cartesian3.fromDegrees( parseFloat(lon), parseFloat(lat), 0 );
					var hpr = new Cesium.HeadingPitchRoll( heading, pitch, roll );
					var rotation = new Cesium.ConstantProperty( Cesium.Transforms.headingPitchRollQuaternion(position, hpr) );

					
			    	var navioPoint = viewer.entities.add({
			    		name : 'NAVIO_SISTRAM',
			            position : position,
			            properties : navio,
					    ellipse: {
					    	//stRotation : heading,
					    	outline : true,
					    	extrudedHeight : 100,
					    	heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
					    	height : 10,
					        semiMajorAxis: 200,
					        semiMinorAxis: 200,
			                material: new Cesium.ImageMaterialProperty({ 
			                	image: '/resources/img/plataformas/navio.jpg',
			                	color : Cesium.Color.TOMATO
			                }),   
					    },
			            label : {
			                text : navio.nome_navio,
			                //style : Cesium.LabelStyle.FILL_AND_OUTLINE,
			                fillColor : Cesium.Color.BLACK,
			                //outlineColor : Cesium.Color.BLACK,	                
			                font: '12px Consolas',
			                //outlineWidth : 1,
			                horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
			                eyeOffset : new Cesium.Cartesian3(0.0, 500.0, 0.0),
			                pixelOffsetScaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.0, 1.5e7, 0.7),
			                heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
			                disableDepthTestDistance : Number.POSITIVE_INFINITY,
			            }
			        });					
					
			    	receivedNavios.push( navioPoint );
			    	
				}
					
				
			} else {
				theMessage = "Nenhum navio encontrado.";
	    		tr.css("background-color","#FF3700");						
			}
	    	jQuery("#" + loadingId + "_td" ).text( theMessage );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });
	        	        
		}, 
	    complete: function(xhr, textStatus) {
	    	//
	    }, 		
		dataType: "json",
		contentType: "application/json"
	});  	
}

function cancelPlataformaSolution(){
	viewer._container.style.cursor = "default";
	plataformaEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_CLICK);
	plataformaEventHandler = null;
	removePlataformas();
	isPlataformaSolutionActive = false;
	$("#toolGtOpA").removeClass("btn-danger");
	$("#toolGtOpA").addClass("btn-warning");
	closePlataformasToolBarMenu();
}

function startPlataformaSolution(){
	isPlataformaSolutionActive = true;
	$("#toolGtOpA").removeClass("btn-warning");
	$("#toolGtOpA").addClass("btn-danger");	
	$("#plataformasMenuBox").show(300);
	plataformas();
}

function plataformas() {
	bindToQuery();

	// Atualmente so ignora a nova busca se ja tiver sido feita.
	// Eh necessario uma rotina para apagar as plataformas
	if( receivedPlataformas.length > 0 ) {
		return true;
	}
	
	
	var plataformasUrl = "/sistram/plataformas"; 
	var loadingId = createUUID();
    $.ajax({
		url: plataformasUrl, 
		type: "GET", 
		beforeSend : function() {
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Recebendo Plataformas...</td></tr>";
			jQuery("#plataformasMenuTable").append( loading );
		},
		error: function( obj ) {
			var tr = jQuery("#" + loadingId );
			tr.css("background-color","#FF3700");
	    	jQuery("#" + loadingId + "_td" ).text( 'Erro ao adquirir plataformas.' );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	  					
		},
		success: function( obj ) {
			var theMessage;
			var tr = jQuery("#" + loadingId );
			
			if( obj.data ) {
				theMessage = obj.data.length + " plataformas foram recebidas.";
				loadPlataformas( obj.data )
			} else {
				theMessage = obj;
	    		tr.css("background-color","#FF3700");						
			}
	    	jQuery("#" + loadingId + "_td" ).text( theMessage );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });
	        	        
		}, 
	    complete: function(xhr, textStatus) {
	    	//
	    }, 		
		dataType: "json",
		contentType: "application/json"
	});  	
}

function showNavioSistram( entity ){
	var navio = entity.properties;

	var lat = navio.lat;
	var lon = navio.lon;
	var queryData = "";
	
	var nome = navio.nome_navio;
	var imo = navio.imo;
	var irin = navio.irin;
	var rumo = navio.rumo;
	var veloc = navio.veloc;
	var fonte = navio.fonte;
	var dh = navio.dh;
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Nome</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + nome + "</td>" +
	"</tr>" +
	
	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>IMO</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + imo + "</td>" +
	"</tr>"	+

	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>IRIN</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + irin + "</td>" +
	"</tr>" +
	
	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Rumo</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + rumo + "</td>" +
	"</tr>" +

	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Veloc</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + veloc + "</td>" +
	"</tr>" +

	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Fonte</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + fonte + "</td>" +
	"</tr>";
	
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Posição</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + lat + ", " + lon + "</td>" +
	"</tr>";	

	jQuery(".queryRowDetails").remove();
   	jQuery("#plataformasMenuTable").append( queryData );
}

function showPlataformaInfo( entity ) {
	var plataforma = entity.properties;
	var lat = plataforma.lat;
	var lon = plataforma.lon;
	var queryData = "";
	
	var nome = plataforma.nome_navio;
	var imo = plataforma.imo;
	var irin = plataforma.irin;
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Nome</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + nome + "</td>" +
	"</tr>" +
	
	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>IMO</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + imo + "</td>" +
	"</tr>"	+

	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>IRIN</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + irin + "</td>" +
	"</tr>";
	
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Posição</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + lat + ", " + lon + "</td>" +
	"</tr>";

	jQuery(".queryRowDetails").remove();
   	jQuery("#plataformasMenuTable").append( queryData );
}

function showPlataforma( entity ) {
	var plataforma = entity.properties;
	var lat = plataforma.latdd.getValue();
	var lon = plataforma.longdd.getValue();
	var raio = jQuery("#platSecurityRadius").val();
	scan(lat,lon,raio);
	
	var position = entity.position;
	
	var perimetro = 1853 * parseFloat( raio ); 

	if ( platPerimeter ) viewer.entities.remove( platPerimeter );
	platPerimeter = viewer.entities.add({
		name : 'PLATAFORMA_PERIMETRO',
        position : position,
        properties : plataforma,
	    ellipse: {
	    	outline : true,
	    	outlineColor : Cesium.Color.RED,
	    	outlineWidth : 5,
	    	fill : false,
	    	heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
	    	height : 50,
	    	extrudedHeight : 100,
	    	numberOfVerticalLines : 64,
	        semiMajorAxis: perimetro,
	        semiMinorAxis: perimetro,
	    }
	});
	
	showPlataformaInfo( entity );
	
}

function bindToQuery() {
	plataformaEventHandler = new Cesium.ScreenSpaceEventHandler( scene.canvas );
	plataformaEventHandler.setInputAction( function( click ) {
		var pickedObject = viewer.scene.pick( click.position );
		
	    if ( Cesium.defined( pickedObject ) ) {
	    	var entity = pickedObject.id;
	    	if ( entity.name === "PLATAFORMA") showPlataforma( entity );
	    	if ( entity.name === "NAVIO_SISTRAM") showNavioSistram( entity );
	    } else {
	    	//
	    }
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);
	viewer._container.style.cursor = "help";
}

function removePlataformas( uuid ){
	jQuery(".queryRowDetails").remove();
	for( x=0; x < receivedPlataformas.length; x++  ) {
		viewer.entities.remove( receivedPlataformas[x] );
	}
	
	/*
	jQuery("#" + uuid).fadeOut(400, function(){
		jQuery("#" + uuid).remove();
		var count = jQuery('#diversosContainer').children().length;
		if ( count === 0 ) { jQuery("#diversosCounter").html( '' ); } else { jQuery("#diversosCounter").html( count ); }
	});
	*/

	receivedPlataformas = [];
	if ( platPerimeter ) viewer.entities.remove( platPerimeter );
	platPerimeter = null;

	for( x=0; x < receivedNavios.length; x++ ) {
		viewer.entities.remove( receivedNavios[x] );
	}
	receivedNavios = [];
}

/*
function putPlataformasToMainPanel() {
	var uuid = createUUID();
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><img src="/resources/img/plataforma.png" style="width:15px;height:15px;"> &nbsp;' +
	'<b>Plataformas</b></td><td class="layerTable" style="text-align: right;">' + 
	'<a title="Remover Plataformas" href="#" onClick="removePlataformas(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;">' +
		'<img src="/resources/img/sistram4.png" style="border:1px solid #3c8dbc;width:100%;height:110px"></td></tr>';
	
	table = table + '</table></div>';
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#diversosContainer").append( layerText );
	jQuery("#layerContainer").show( "slow" );
		
	var count = jQuery('#diversosContainer').children().length;
	jQuery("#diversosCounter").html( count );	
}
*/

function loadPlataformas( plataformas ) {
	if( plataformas.length === 0 ) return;
	
	for( x=0; x<plataformas.length;x++ ) {
		var plataforma = plataformas[x];
		var tipoNavio = plataforma.tipo_navio;
		var latdd = plataforma.latdd;
		var longdd = plataforma.longdd;
		var position = Cesium.Cartesian3.fromDegrees( parseFloat(longdd), parseFloat(latdd) );
		var icone = "/resources/img/plataformas/plataforma.jpg";
    	var platPoint = viewer.entities.add({
    		name : 'PLATAFORMA',
            position : position,
            properties : plataforma,
		    ellipse: {
		    	outline : true,
		    	extrudedHeight : 200,
		    	heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
		    	height : 10,
		    	
		        semiMajorAxis: 300,
		        semiMinorAxis: 300,
                material: new Cesium.ImageMaterialProperty({ 
                	image: icone,
                	color :  Cesium.Color.AQUAMARINE, //.withAlpha(0.9)
                }),   
		    },
            label : {
                text : plataforma.nome_navio,
                //style : Cesium.LabelStyle.FILL_AND_OUTLINE,
                fillColor : Cesium.Color.BLACK,
                //outlineColor : Cesium.Color.BLACK,	                
                font: '14px Consolas',
                //outlineWidth : 1,
                //showBackground : true,
                //backgroundColor : Cesium.Color.WHITE,
                horizontalOrigin : Cesium.HorizontalOrigin.CENTER,
                eyeOffset : new Cesium.Cartesian3(0.0, 800.0, 0.0),
                pixelOffsetScaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.4, 1.5e7, 0.7),
                heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
                disableDepthTestDistance : Number.POSITIVE_INFINITY,
            }
        });
		
    	receivedPlataformas.push( platPoint );
    	
	}
	
	//putPlataformasToMainPanel();
}




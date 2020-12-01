

var isAvRadioSolutionActive = false;
var avisosEntities = [];
var avisoRadioHandler = null;
var receivedNaviosSAR = [];

function startAvisoRadio(){
	if( isAvRadioSolutionActive ){
		isAvRadioSolutionActive = false;
		$("#toolAvisoRadio").removeClass("btn-danger");
		$("#toolAvisoRadio").addClass("btn-warning");
		deleteAvisos();
	} else {
		isAvRadioSolutionActive = true;
		avisosRadio( false );
		$("#toolAvisoRadio").addClass("btn-danger");
		$("#toolAvisoRadio").removeClass("btn-warning");
	}
}


function pointToArray( geom ){
	var geomArr = geom.split("]").join("").split("[").join("").split(",");
	geomArr[0] = parseFloat( geomArr[0] );
	geomArr[1] = parseFloat( geomArr[1] );
	return geomArr;
}


function deleteNaviosSar(){
	for( var x=0; x < receivedNaviosSAR.length; x++ ) {
		viewer.entities.remove( receivedNaviosSAR[x] ); 
	}
	receivedNaviosSAR = [];
}


function deleteAvisos(){
	for( var x=0; x < avisosEntities.length; x++ ) {
		viewer.entities.remove( avisosEntities[x] ); 
	}
	avisosEntities = [];
	
	deleteNaviosSar();
	
	if( avisoRadioHandler ){
		avisoRadioHandler.removeInputAction( Cesium.ScreenSpaceEventType.MOUSE_MOVE );
		avisoRadioHandler.removeInputAction( Cesium.ScreenSpaceEventType.LEFT_CLICK );
		avisoRadioHandler = null;
	}
	jQuery("#avisosDetailContainer").empty( );
}

function plotaPontoAviso(aviso){
	var geom = pointToArray( aviso.geom );
	var position = Cesium.Cartesian3.fromDegrees( geom[1], geom[0] );

	aviso.lat = geom[0];
	aviso.lon = geom[1];
	
	var entity = viewer.entities.add({
		name : 'AVISO_RADIO_PINO',
	    position : position,
	    properties : aviso,
	    billboard :{
	        image : '/resources/img/pin-end.png',
            pixelOffset : new Cesium.Cartesian2(0, -10),
            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.6, 1.5e7, 0.2),
            //heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
            disableDepthTestDistance : Number.POSITIVE_INFINITY            
	    },
	});	
	avisosEntities.push( entity );
}

function drawLineAviso(aviso){
	//console.log( aviso );
}

function drawCircleAviso(aviso){
	var geom = pointToArray( aviso.geom );
	var position = Cesium.Cartesian3.fromDegrees( geom[1], geom[0] );
	var raio = parseFloat( aviso.raio );
	
	aviso.lat = geom[0];
	aviso.lon = geom[1];
	
	var circulo = viewer.entities.add({
		name : 'AVISO_RADIO_CIRCULO',
	    position : position,
	    properties : aviso,
	    ellipse: {
	    	clampToGround : true,
	        semiMajorAxis: raio,
	        semiMinorAxis: raio,
	        material: new Cesium.StripeMaterialProperty({
	            evenColor : Cesium.Color.GOLD.withAlpha(0.5),
	            oddColor : Cesium.Color.BLACK.withAlpha(0.4),
	            repeat : 15.0,
	        }),	        
            stRotation : Cesium.Math.toRadians(45)	            
	    }
	});	
	
	avisosEntities.push( circulo );
}


function procuraNaviosSAR( lat, lon, raio ) {
	
	deleteNaviosSar();
	
	
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
			"Buscando Navios...</td></tr>";
			jQuery("#avisosRadioMenuTable").append( loading );
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

					navio.navioId = "id_" + createUUID();
					
			    	var navioPoint = viewer.entities.add({
			    		name : 'NAVIO_SISTRAM',
			            position : position,
			            properties : navio,
					    ellipse: {
					    	//stRotation : heading,
					    	outline : true,
					    	extrudedHeight : 100,
					    	//heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
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
			                //heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
			                disableDepthTestDistance : Number.POSITIVE_INFINITY,
			            }
			        });					
					
			    	receivedNaviosSAR.push( navioPoint );
			    	
				}
			
			} else {
				theMessage = "Nenhum navio encontrado.";
	    		tr.css("background-color","#FF3700");						
			}
	    	jQuery("#" + loadingId + "_td" ).text( theMessage );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });			
			
		}
		
    });
    
}

function drawPolygonAviso(aviso){
	var positions = [];
	var geomArr = eval( aviso.geom );
	
	
	for( var x=0; x < geomArr.length; x++ ) {
		var geom = geomArr[x];
		positions.push( Cesium.Cartesian3.fromDegrees( geom[1], geom[0] ) );
	}
	
	var polygon = viewer.entities.add({
		name : 'AVISO_RADIO_AREA',
	    properties : aviso,
	    polygon : {
	    	hierarchy : positions,
	        material: new Cesium.StripeMaterialProperty({
	            evenColor : Cesium.Color.GOLD.withAlpha(0.5),
	            oddColor : Cesium.Color.BLACK.withAlpha(0.4),
	            repeat : 15.0,
	        }),	  
	        clampToGround : true
	    }
	});
	
	avisosEntities.push( polygon );
	
}

function addNavioSistramCard( navio ){
	
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

	jQuery("#avisosDetailContainer").empty( );
	
	
	var signImage = "<img id='shipFlag' style='height: 20px;' src='/resources/img/plataformas/navio.jpg'>";
	var table = '<div class="table-responsive route_direction" style="font-family: monospace; font-size: 9.5px;"><table id="shipDataTable" class="table" style="margin-bottom: 0px;width:100%">'; 
	table = table + "<tr><td rowspan='2' class='layerTable' style='width:30px;border-top: 0px;'>" + signImage + "</td>" + 
		"<td style='text-align: right;border-top: 0px;padding: 0px'><b><span style='float:left'>" + nome + "</span><span style='float:right'>" + imo + " " + irin + "</span></b></td></tr>"; 
	
	table = table + "<tr><td colspan='2' style='font-weight:bold; border-top: 0px;padding: 0px;'><span style='float:left'>Lat: " + toDegreesMinutesAndSeconds(lat) + "</span><span style='float:right'>Long: " + 
	toDegreesMinutesAndSeconds(lon) + "</span></td></tr>";

	table = table + "<tr><td colspan='2' style='font-weight:bold; border-top: 0px;padding: 0px;'><span style='float:left'>Rumo: " + rumo + "</span><span style='float:right'>Velocidade: " + veloc + "</span></td></tr>";
	table = table + "<tr><td colspan='2' style='font-weight:bold; border-top: 0px;padding: 0px;'><span style='float:left'>Atualização: " + dh + "</span><span style='float:right'>Fonte: " + fonte + "</span></td></tr>";
	
	table = table + "</table></div>";

	
	
	var layerText = '<div class="avisoCard" id="'+navio.navioId+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' + table + '</div></div>';
	jQuery("#avisosDetailContainer").append( layerText );		
	
}

function addAvisoCard( aviso ){
	jQuery("#avisosDetailContainer").empty( );
	
	var raio = 0;
	if( aviso.raio ) raio = aviso.raio.getValue();
	var numero = aviso.numero.getValue();
	var texto_pt = aviso.texto_pt.getValue();
	var texto_en = aviso.texto_en.getValue();
	var data_ultima_atualizacao = aviso.data_ultima_atualizacao.getValue();
	var geom = aviso.geom.getValue();
	var irim = '';
	if( aviso.irim ) irim = aviso.irim.getValue();
	var tipo = "&nbsp;";
	var image = aviso.image.getValue();

	aviso.avisoId = "id_" + createUUID();
	
    switch ( aviso.tipo.getValue() ) {
    case 'Z':
        tipo = "NAVAREA / SAR";
        break;
    case 'C':
        tipo = "Costeiro";
        break;
    case 'L':
        tipo = "Local";
        break;
    }		
	
    var costa = "&nbsp;";
    switch ( aviso.costa ) {
        case 'I':
            costa = 'Bacia Amazônica';
            break;
        case 'N':
            costa = 'Costa Norte';
            break;
        case 'E':
            costa = 'Costa Leste';
            break;
        case 'S':
            costa = 'Costa Sul';
            break;
        case 'HI':
            costa = 'Rio Paraguai';
            break;
        case 'HT':
            costa = 'Hidrovia Tietê - Paraná';
            break;
        case 'HG':
            costa = 'Hidrovias em Geral';
            break;
        default:
            costa = "NAVAREA V";
            break;
    }        

	var signImage = "<img style='height: 20px;' src='/resources/img/avisos/" + image + "'>";
	var table = '<div class="table-responsive route_direction" style="font-family: monospace; font-size: 9.5px;"><table class="table" style="margin-bottom: 0px;width:100%">'; 
	table = table + "<tr><td rowspan='2' class='layerTable' style='width:30px;border-top: 0px;'>" + signImage + "</td>" + 
		"<td style='text-align: right;border-top: 0px;padding: 0px'><b><span style='float:left'>" + data_ultima_atualizacao.replace("-","/").replace("-","/") + "</span><span style='float:right'>" + numero + "</span></b></td></tr>"; 
	table = table + "<tr><td style='font-weight:bold; border-top: 0px;padding: 0px;'><span style='float:left'>" + costa + "</span><span style='float:right'>" + tipo + "</span></td></tr>";
	
	table = table + "<tr style='border-top: 1px solid #cacaca;' ><td colspan='2' style='font-size: 11px;text-align: justify;border-top: 0px;padding: 0px;'>" + texto_pt + "</td></tr>";	
	table = table + "</table></div>";

	var layerText = '<div class="avisoCard" id="'+aviso.avisoId+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' + table + '</div></div>';
	$("#avisosDetailContainer").append( layerText );			
	
}

function reloadAvisosListDisplay( sarEventsOnlyFilter, avisosRadio ){
	deleteAvisos();
	// $("#avisosContainer").show( 400 );
	
	for( var x=0; x < avisosRadio.length; x++  ) {
		var aviso = avisosRadio[x];
		
		// Usuario quer somente eventos SAR
		if( ( aviso.tipo != 'Z' ) && sarEventsOnlyFilter ) continue;
		
    	aviso.image = "help.png";
	    switch (aviso.tipo_geom) {
	    case 'Point':
	        plotaPontoAviso(aviso);
	        break;
	    case 'Polyline':
	        drawLineAviso(aviso);
	        aviso.image = "reboque_blue.png";
	        break;
	    case 'Circle':
	        drawCircleAviso(aviso);
	        aviso.image = "radar.png";
	        break;
	    case 'Polygon':
	        drawPolygonAviso(aviso);
	        aviso.image = "areaav.png";
	        break;
	    }		
		
	}
	

	avisoRadioHandler = new Cesium.ScreenSpaceEventHandler( viewer.canvas );
	avisoRadioHandler.setInputAction(function(movement) {
	    var pickedObject = scene.pick(movement.endPosition);
	    if ( Cesium.defined(pickedObject) && pickedObject.id instanceof Cesium.Entity && Cesium.defined( pickedObject.id.properties ) ) {
	        var avisoId = pickedObject.id.properties.avisoId;
	        
	        if( pickedObject.id.name === 'NAVIO_SISTRAM' ){
	        	
	        } else {
	        	addAvisoCard( pickedObject.id.properties );
	        }
	        
	        
	    } else{
	        //highlightedEntity = undefined;
	    }
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);	

	
	avisoRadioHandler.setInputAction( function( click ) {
		var pickedObject = scene.pick( click.position );
	    if ( Cesium.defined( pickedObject ) ) {
	    	var entity = pickedObject.id;
	    	
	    	if( entity.name === 'NAVIO_SISTRAM' ){
	    		if( Cesium.defined( entity ) ) {
	    			addNavioSistramCard( entity.properties );
	    			getShipFromVesselTracker( entity.properties );
	    		}
	    	} else {
		    	if( Cesium.defined( entity ) && entity.properties.tipo_geom.getValue() === 'Point' ){
		    		var lat = parseFloat( entity.properties.lat.getValue() );
		    		var lon = parseFloat( entity.properties.lon.getValue() );
		    		procuraNaviosSAR( lat, lon, 2 );
		    	}
	    	}	    	
	    } else {
	    	//
	    }
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);	
	
	
}

function getShipFromVesselTracker( navio ){
	var imo = navio.imo;
	var irin = navio.irin;

	var shipsUrl = "/vtracker/search?term=" + imo;
	var loadingId = createUUID();
    jQuery.ajax({
		url: shipsUrl, 
		type: "GET", 
		beforeSend : function() {
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Acessando VesselTracker.com...</td></tr>";
			jQuery("#avisosRadioMenuTable").append( loading );
		},
		error: function( obj ) {
			var tr = jQuery("#" + loadingId );
			tr.css("background-color","#FF3700");
	    	jQuery("#" + loadingId + "_td" ).text( 'Sem Informações Adicionais.' );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	  					
		},
		success: function( obj ) {
			var theMessage;
			var tr = jQuery("#" + loadingId );
			
			if( obj ) {
				var shipInfo = obj["Ship Info"];
				var generalInfo = obj["General Info"];
				var shipPhoto = "http://" + generalInfo["Image"];
				
				theMessage = "Informações Recebidas.";
				jQuery("#shipFlag").attr("src", shipInfo.flagImage );
				
				jQuery("#shipDataTable tbody").append("<tr><td colspan='2' style='background-color: #cacaca;font-weight:bold; text-align: center;'>Dados do VesselTracker.com</td></tr>");
				
				var keys = Object.keys( generalInfo );
				for( xx=0; xx<keys.length;xx++ ) {
					var key = keys[xx];
					var value = generalInfo[ key ];
					if( key != "Image") {
						jQuery("#shipDataTable tbody").append( "<tr><td colspan='2' style='padding: 3px;'><span style='float:left;font-weight:bold'>"+key+"</span><span style='float:right;'>"+value+"</span></td></tr>");
					}
				}
				
				if( generalInfo["Image"] !=  "" ) {
					jQuery("#shipDataTable tbody").append( "<tr><td colspan='2' style='padding: 3px;'><img style='width: 100%;border:1px solid #cacaca' src='"+shipPhoto+"'></td></tr>");
				}
				
				
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

function avisosRadio( sarEventsOnlyFilter ){
	
	var avisossUrl = "/aviso/getavisos?mock=false";
	
	var loadingId = createUUID();
    jQuery.ajax({
		url: avisossUrl, 
		type: "GET", 
		beforeSend : function() {
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Aguarde...</td></tr>";
			jQuery("#avisosRadioMenuTable").append( loading );
		},
		error: function( obj ) {
			var tr = jQuery("#" + loadingId );
			tr.css("background-color","#FF3700");
	    	jQuery("#" + loadingId + "_td" ).text( 'Erro ao receber avisos.' );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	  					
		},
		success: function( obj ) {
			var theMessage;
			var tr = jQuery("#" + loadingId );
			
			if( obj ) {
				theMessage = obj.length + " avisos foram recebidos.";
				reloadAvisosListDisplay( sarEventsOnlyFilter, obj );
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
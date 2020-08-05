
var runWaysPcn = [];

function loadPistas( pistas, searchParameters ) {
	
	for( x=0; x < runWaysPcn.length; x++ ) {
		viewer.entities.remove( runWaysPcn[x] );
	}
	
	var promise = Cesium.GeoJsonDataSource.load( pistas, { clampToGround : true } );
    promise.then(function(dataSource) {
    	var entities = dataSource.entities.values;
		var runwayColor = new Cesium.PolylineGlowMaterialProperty({ glowPower : 0.14, color : Cesium.Color.RED });			    	 
		var quant = entities.length;
		
		for (var i = 0; i < quant; i++) {
			var entity = entities[i];
			var positions = entity.polyline.positions.getValue();
			var properties = entity.properties;

			var pointPosition = positions[0];
			
			var runWayPl = viewer.entities.add({
				name : 'PCN_RUNWAY',
				properties : properties,
				polyline : {
			    	positions : positions,
		            material : runwayColor,			    	
			    	clampToGround : true,
			    	width: 20,
			    	disableDepthTestDistance : Number.POSITIVE_INFINITY
			    }
			});
			
			
			var runwayPoint = viewer.entities.add({
				name : 'RUNWAY_POINT',
			    position : pointPosition,
			    billboard :{
			        image : '/resources/img/pin-start.png',
		            pixelOffset : new Cesium.Cartesian2(0, -10),
		            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 0.6, 1.5e7, 0.2),
		            heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
		            disableDepthTestDistance : Number.POSITIVE_INFINITY     
		        }
			});	
			
			var runWay = {};
			runWay.uuid = createUUID();
			runWay.polyline = runWayPl;
			runWay.marker = runwayPoint;
			runWay.searchParameters = searchParameters;
			runWaysPcn.push( runWay );
			
		}	

		if( quant > 0) addToPanelRunway( searchParameters );

    	
    });
}

function showRunwayInfo( entity ){
	var properties = entity.properties;
	var queryData = "";
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Aeródromo</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + properties.name + "</td>" +
	"</tr>" +
	
	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>ICAO</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + properties.designator + "</td>" +
	"</tr>"	+
	
	"<tr class='queryRowDetails'>" +
	"<td class='layerTable'><b>Pista</b></td>" +
	"<td style='text-align: right;' class='layerTable'>" + properties.way_designator + "</td>" +
	"</tr>"	+
	
	"<tr class='queryRowDetails'>" +
	"<td class='layerTable'><b>PCN</b></td>" +
	"<td style='text-align: right;' class='layerTable'>" + properties.pcn_code + "</td>" +
	"</tr>"	+
	
	"<tr class='queryRowDetails'>" +
	"<td class='layerTable'><b>Comprimento</b></td>" +
	"<td style='text-align: right;' class='layerTable'>" + properties.nominallength + " metros</td>" +
	"</tr>"	+

	"<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Largura</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + properties.nominalwidth + " metros</td>" +
	"</tr>";
	
	
	jQuery(".queryRowDetails").remove();
   	jQuery("#queryMenuTable").append( queryData );
	
}


function deleteAllRunways() {
	for ( y=0; y<runWaysPcn.length; y++ ) {
		var uuid = runWaysPcn[y].uuid;
		viewer.entities.remove( runWaysPcn[y].polyline );
		viewer.entities.remove( runWaysPcn[y].marker );
		jQuery("#pcnResultCard").remove();
	}
	var count = jQuery('#diversosContainer').children().length;
	if ( count === 0 ) { jQuery("#diversosCounter").html( '' ); } else { jQuery("#diversosCounter").html( count ); }
	runWaysPcn = [];
}

/*
function removePista( uuid ) {
	for ( y=0; y<runWaysPcn.length; y++ ) {
		if( runWaysPcn[y].uuid == uuid ) {
			viewer.entities.remove( runWaysPcn[y].polyline );
			viewer.entities.remove( runWaysPcn[y].marker );
			runWaysPcn.splice(y, 1);
			jQuery("#pcnResultCard").fadeOut(400, function(){
				jQuery("#pcnResultCard").remove();
				var count = jQuery('#diversosContainer').children().length;
				if ( count === 0 ) { jQuery("#diversosCounter").html( '' ); } else { jQuery("#diversosCounter").html( count ); }
			});		
			return true;
		}
	}
}
*/


function gotoRunway( uuid ){
	for ( y=0; y<runWaysPcn.length; y++ ) {
		if( runWaysPcn[y].uuid == uuid ) {
			viewer.zoomTo( runWaysPcn[y].polyline );
			return true;
		}
	}
}

function addToPanelRunway( searchParameters ) {
	var quant = runWaysPcn.length;
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><img src="/resources/img/pcn.png" style="width:15px;height:15px;"> &nbsp;' +
	'<b>Pista de Pouso</b></td><td class="layerTable" style="text-align: right;">' + 
	'<a title="Remover" href="#" onClick="deleteAllRunways();" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td class="layerTable">' + searchParameters + '</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+ quant + '</td></tr>';

	table = table + '</table></div>';
	
	var layerText = '<div id="pcnResultCard" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#diversosContainer").append( layerText );
	jQuery("#layerContainer").show( "slow" );
	
	var count = jQuery('#diversosContainer').children().length;
	jQuery("#diversosCounter").html( count );	
	
}

function searchPCNRunwaysBtnR() {
	var searchPCNWidth = jQuery("#searchPCNWidth").val();
	var searchPCNLength = jQuery("#searchPCNLength").val();
	var searchPCNClass = jQuery("#searchPCNClass").val();
	var searchPCNPavement = jQuery("#searchPCNPavement").val();
	var searchPCNResistence = jQuery("#searchPCNResistence").val();
	var searchPCNPressure = jQuery("#searchPCNPressure").val();
	var searchPCNAval = jQuery("#searchPCNAval").val();
	var searchICAO = jQuery("#searchICAO").val();

	if( !searchPCNLength ) searchPCNLength = -1;
	if( !searchPCNWidth ) searchPCNWidth = -1;
	if( !searchPCNClass ) searchPCNClass = -1;
	if( !searchICAO ) searchICAO = "*";

	var url = "/runwayspdf?pcn="+searchPCNClass+"&pavimento="+searchPCNPavement+"&resistencia="+searchPCNResistence+"&pressao="+searchPCNPressure+"&avaliacao="+
	searchPCNAval+"&comprimento="+searchPCNLength+"&largura="+searchPCNWidth+"&icao=" + searchICAO.toUpperCase();
	
	window.open( url );
}


function searchPCNRunwaysBtn() {

	deleteAllRunways();
	
	var searchPCNWidth = jQuery("#searchPCNWidth").val();
	var searchPCNLength = jQuery("#searchPCNLength").val();
	var searchPCNClass = jQuery("#searchPCNClass").val();
	var searchPCNPavement = jQuery("#searchPCNPavement").val();
	var searchPCNResistence = jQuery("#searchPCNResistence").val();
	var searchPCNPressure = jQuery("#searchPCNPressure").val();
	var searchPCNAval = jQuery("#searchPCNAval").val();
	var searchICAO = jQuery("#searchICAO").val();

	var pcnSS = searchPCNClass;
	var lengthSS = searchPCNLength;
	var widthSS = searchPCNWidth;
	
	
	if( !searchPCNLength ) {
		searchPCNLength = -1;
		lengthSS = "*";
	}
	if( !searchPCNWidth ) {
		searchPCNWidth = -1;
		widthSS = "*";
	}
	if( !searchPCNClass ) {
		searchPCNClass = -1;
		pcnSS = "*";
	}
	if( !searchICAO ) searchICAO = "*";
	
	var searchParameter = widthSS + ", " + lengthSS + " " + searchICAO + " (" + pcnSS + "/" +  searchPCNPavement + "/" + searchPCNResistence + "/" + searchPCNPressure + "/" + searchPCNAval + ")";
	
	// http://sisgeodef.defesa.mil.br:36002/v1/runways?pcn=-1&pavimento=*&resistencia=B&pressao=*&avaliacao=*&comprimento=2500&largura=25&icao=*
	var loadingId = createUUID();
    jQuery.ajax({
		url:"/runways?pcn="+searchPCNClass+"&pavimento="+searchPCNPavement+"&resistencia="+searchPCNResistence+"&pressao="+searchPCNPressure+"&avaliacao="+
			searchPCNAval+"&comprimento="+searchPCNLength+"&largura="+searchPCNWidth+"&icao=" + searchICAO.toUpperCase(), 
		type: "GET", 
		beforeSend : function() {
			var loading = "<tr id='"+ loadingId +"'><td id='"+ loadingId +"_td' colspan='2' class='layerTable'>" +
            "<div class='progress progress-sm active'>" +
            "<div class='progress-bar progress-bar-primary progress-bar-striped' role='progressbar' aria-valuenow='100' aria-valuemin='0' aria-valuemax='100' style='width: 100%'>"+
            "</div></div>" + 		
			"Localizando Pistas...</td></tr>";
			jQuery("#pcnMenuTable").append( loading );
		},
		error: function( obj ) {
			var tr = jQuery("#" + loadingId );
			tr.css("background-color","#FF3700");
	    	jQuery("#" + loadingId + "_td" ).text( 'Erro ao adquirir pistas.' );
	        tr.fadeOut(5000, function(){
	            tr.remove();
	        });	  					
		},		
		success: function( obj ) {
			
			if( !obj.features ) {
				var tr = jQuery("#" + loadingId );
		    	jQuery("#" + loadingId + "_td" ).text( 'Nenhuma Pista Encontrada.' );
		        tr.fadeOut(5000, function(){
		            tr.remove();
		        });	  					
			} else {
				var tr = jQuery("#" + loadingId );
				jQuery("#" + loadingId + "_td" ).text( "Concluído. " + obj.features.length + " pistas encontradas." );
		        tr.fadeOut(5000, function(){
		            tr.remove();
		        });
				loadPistas( obj, searchParameter );
				
			}
			
		}, 
	    complete: function(xhr, textStatus) {
	    	//
	    }, 		
		dataType: "json",
		contentType: "application/json"
	});  	
	
	
}
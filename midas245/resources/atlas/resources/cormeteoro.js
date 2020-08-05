var cores = [];
var aerodromos = [];

function loadCores( ) {
	cores.push( {"cm":"AZ","color": Cesium.Color.ROYALBLUE } );
	cores.push( {"cm":"VD","color": Cesium.Color.GREEN } );
	cores.push( {"cm":"AM","color": Cesium.Color.YELLOW } );
	cores.push( {"cm":"AB","color": Cesium.Color.ORANGE } );
	cores.push( {"cm":"VM","color": Cesium.Color.RED } );
	
	
	var url = "/cor/getcolors?mock=false";
	$.ajax({
		url: url,
		type: "GET", 
		success: function( obj ) {
			console.log( obj );
			if( obj ) prepareData( obj );
		},
		error: function(xhr, textStatus) {
			//
		}, 		
	});
}

function getColor( cm ){
	for( zz=0; zz<cores.length;zz++){
		if( cores[zz].cm == cm ) return cores[zz].color;
	}
	return Cesium.Color.SILVER;
}

function showColorAerodromo( entity ){
	var theData = entity.properties.data.getValue();
	var queryData = "";
	var refData = theData[ theData.length -1 ];
	var metar = refData.metar.metar;
	
	console.log( theData );
	
	var aerodromo = metar.airport;
	var aerodromoName = aerodromo.icao + " (" + aerodromo.iata + ")";
	var temp = metar.temperature;
	var visibility = refData.metar.alpha;  
	var teto = refData.metar.beta; 
	var metarMessage = metar.message;
	var wind = metar.wind.directionDegrees + "\xB0 (" +metar.wind.direction + ") " + metar.wind.speed + "kt ";
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Aeródromo</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + aerodromoName + "</td>" +
	"</tr>";
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Temperatura</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + temp + "\xB0</td>" +
	"</tr>";
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Visibilidade</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + visibility + "m</td>" +
	"</tr>";
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Teto</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + teto + "m</td>" +
	"</tr>";
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Vento</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + wind + "</td>" +
	"</tr>";
	queryData = queryData + "<tr class='queryRowDetails' style='border-bottom: 2px solid #3c8dbc; border-top: 2px solid #3c8dbc;'>" +
	   "<td colspan='2' class='layerTable' style='text-align:center;padding: 0px !important;'>" + metarMessage + "</td>" +
	"</tr>";

	/*
	for( var tt = 0; tt < metar.clouds.length; tt++ ) {
		queryData = queryData + "<tr class='queryRowDetails'>" +
		   "<td class='layerTable'><b>Nuvem '"+ metar.clouds[tt].quantity +"'</b></td>" +
		   "<td style='text-align: right;' class='layerTable'>" + metar.clouds[tt].height + "m</td>" +
		"</tr>";
	}
	*/
	
	
	var theButton = "";
	var maxColors = theData.length;
	//if(maxColors > 4 ) maxColors = 4;
	for( var x=0; x < maxColors;x++   ) {
		var dia = ('00' + theData[x].dia).slice(-2);
		var hora = ('00' + theData[x].hora).slice(-2);
		var minuto = ('00' + theData[x].minuto).slice(-2);
		var cm = theData[x].metar.cm;
		var dh = cm + "<br>" + dia + "<br>" + hora + ":" + minuto;
		var bkColor = getMetarBkColor(cm);
		theButton = theButton + '<button style="background-color:'+bkColor+';margin-right:3px;width: 40px;float:left" type="button" class="btn btn-primary btn-xs btn-flat">'+dh+'</button>';
	}
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td colspan='2' style='text-align:center;margin: 0 auto;' class='layerTable'>" + theButton + "</td>" +
	"</tr>";
	
	$(".queryRowDetails").remove();
   	$("#queryMenuTable").append( queryData );
	
	
}

function getMetarBkColor( theMetarColor ){
	if( theMetarColor === "AZ" ) return '#00c0ef';
	if( theMetarColor === "VD" ) return '#008d4c';
	if( theMetarColor === "AM" ) return '#e0d90b';
	if( theMetarColor === "AB" ) return '#e08e0b';
	if( theMetarColor === "VM" ) return '#d73925';
}

function removeCores( uuid ){
	for( var ww = 0; ww < aerodromos.length; ww++ ) {
		viewer.entities.remove( aerodromos[ww].entity );
	}
	
	$("#" + uuid).fadeOut(400, function(){
		$("#" + uuid).remove();
		var count = $('#diversosContainer').children().length;
		if ( count === 0 ) { $("#diversosCounter").html( '' ); } else { $("#diversosCounter").html( count ); }
	});
	aerodromos = [];
}

function putCoresAerodromosToMainPanel() {
	var uuid = createUUID();
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><img src="/resources/img/cormet.png" style="width:15px;height:15px;"> &nbsp;' +
	'<b>Cores Meteorológicas</b></td><td class="layerTable" style="text-align: right;">' + 
	'<a title="Remover Cores Meteorológicas" href="#" onClick="removeCores(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;">' +
		'<img src="/resources/img/redemet.png" style="border:1px solid #3c8dbc;width:100%;height:110px"></td></tr>';
	
	table = table + '</table></div>';
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	$("#diversosContainer").append( layerText );
	$("#layerContainer").show( "slow" );
		
	var count = $('#diversosContainer').children().length;
	$("#diversosCounter").html( count );	
}

function prepareData( obj ){
	var aerodromoData = [];
	var lastIcao = "";
	for( x=0; x< obj.length; x++ ) {
		var data = obj[x];
		var metar = data.metar;
		var icao = metar.airport.icao;
		var dia = metar.day;
		var hora = metar.time[0];
		var minuto = metar.time[1];
		if( (lastIcao != "") && (lastIcao != icao) ){
			aerodromos.push( {"id":lastIcao, "data":aerodromoData});
			aerodromoData = [];
		}
		lastIcao = icao;
		aerodromoData.push( {"dia":dia,"hora":hora,"minuto":minuto,"icao":lastIcao,"metar": data} );
	}
	loadAerodromos();
}

function loadAerodromos() {
	for( var ww = 0; ww < aerodromos.length; ww++ ) {
		var data = aerodromos[ww].data;
		var lastData = data[ data.length -1 ];
		var metar = lastData.metar;
		var corMet = metar.cm.toLowerCase();
		var aerodromo = metar.metar.airport;
		var dataContainer = {"data":data};
		
		var position = Cesium.Cartesian3.fromDegrees( parseFloat(aerodromo.longitude), parseFloat(aerodromo.latitude), 0 );
		var aerodromoCormet = viewer.entities.add({
			name : 'CORMET_AERODROMO',
	        position : position,
	        properties : dataContainer,
	        billboard : {
	        	image : '/resources/img/' + corMet + "-o.png",
	            width : 25,
	            height : 25,
	            pixelOffset : new Cesium.Cartesian2(0, -10),
	            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.0, 1.5e7, 0.2),
	            heightReference : Cesium.HeightReference.CLAMP_TO_GROUND,
	            disableDepthTestDistance : Number.POSITIVE_INFINITY            
	        }
		});
		
		aerodromos[ww].entity = aerodromoCormet;
		aerodromos[ww].uuid = createUUID();
	}
	putCoresAerodromosToMainPanel();
}
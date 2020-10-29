var cores = [];
var aerodromos = [];
var corMetEventHandler = null;
var isCorMetSolutionActive = false;
var corMetConJob = null;
var loadingCorMetoc = false;

var satVP = false;
var satIV = false;
var satTN = false;
var satVI = false;

var inmetImageBBox = [];
inmetImageBBox["??"] = { 'w':-75.0, 's':-35.2, 'e':-29.89, 'n':10.0 };
inmetImageBBox["TN"] = { 'w':-75.4, 's':-35.8, 'e':-31.29, 'n':7.3 };
inmetImageBBox["VP"] = { 'w':-75.4, 's':-35.8, 'e':-31.29, 'n':7.3 };
inmetImageBBox["IV"] = { 'w':-75.4, 's':-35.8, 'e':-31.29, 'n':7.3 };
inmetImageBBox["VA"] = { 'w':-75.4, 's':-35.8, 'e':-31.29, 'n':7.3 };
inmetImageBBox["VI"] = { 'w':-75.4, 's':-35.8, 'e':-31.29, 'n':7.3 };


function cancelCorMetocSolution(){
	clearInterval( corMetConJob );
	removeCores();
	isCorMetSolutionActive = false;
	$("#toolCOR").removeClass("btn-danger");
	$("#toolCOR").addClass("btn-warning");
	removeCormetMouseClickQuery();
	$("#queryMenuBox").hide();
}


function addSingleImageryLayerCard( base64PngImage, data ){
	var bbox = inmetImageBBox[ data.param ];
	var aUniqueKey = "chk" + data.param;
	
	var provider = new Cesium.SingleTileImageryProvider({
	    url : base64PngImage,
	    rectangle : Cesium.Rectangle.fromDegrees(bbox.w, bbox.s, bbox.e, bbox.n) //west, south, east, north
	});
	
	var uuid = "L-" + createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.data = data;
	
	var currentTransparency = 1.0;
	var theCurrentLayer = getLayerByKey( aUniqueKey );
	if( theCurrentLayer != null ) {
		//currentTransparency = theCurrentLayer.layer.alpha;
		deleteLayer( theCurrentLayer.uuid );
	}
	
	if( provider ){
		theProvider.layer = viewer.imageryLayers.addImageryProvider( provider );
		theProvider.layer.alpha = currentTransparency;
		
		var props = { 'uuid':uuid, 'layerType' : 'INMET_IMAGE' }
		theProvider.layer.properties = props; 

		stackedProviders.push( theProvider );		

		// Adiciona o Card
	    var defaultImage = "<img title='Alterar Ordem' style='cursor:move;border:1px solid #cacaca;width:19px;' src='/resources/img/drag.png'>";
		var layerText = getALayerCard( uuid, data.sourceName + " às " + data.sourceHour, defaultImage );
		$("#activeLayerContainer").append( layerText );
		
		$("#SL_"+uuid).bootstrapSlider({});
		$("#SL_"+uuid).on("slide", function(slideEvt) {
			var valu = slideEvt.value / 100;
			doSlider( this.id.substr(3), valu );
		});	
		
		var legUUID = "LEG_" + uuid;
		$( "#" + legUUID ).html( "<img style='height: 205px;' src='" + base64PngImage + "'>" );
		$( "#" + legUUID ).css( { 'text-align': 'center' } );

	}	

}

function dataAtualFormatada(){
    var data = new Date(),
        dia  = data.getDate().toString(),
        diaF = (dia.length == 1) ? '0'+dia : dia,
        mes  = (data.getMonth()+1).toString(), //+1 pois no getMonth Janeiro começa com zero.
        mesF = (mes.length == 1) ? '0'+mes : mes,
        anoF = data.getFullYear();
    return  anoF + "-" + mesF + "-" + diaF;
}

function backInTime( horaObj ){
	var newMin = horaObj.m - 10;
	var newHor = horaObj.h;
	if( newMin < 0 ){
		newMin = 50;
		newHor--;
		if( newHor < 0 ) newHor = 23;
	}
	if( newMin < 10) newMin = "0" + newMin;
	if( newHor < 10) newHor = "0" + newHor;
	return {'h':newHor, 'm':newMin};
}

function horaAtual( rd ){
	var data = new Date();
	var minuto = data.getMinutes();
	var hora = data.getHours();
	if( rd ) {
		minuto = roundDown( minuto, 10 );
	}
	if( minuto < 10) minuto = "0" + minuto;
	if( hora < 10) hora = "0" + hora;
	return {'h':hora, 'm':minuto};
}

function getGoesImages( parametro, horaObj ){
	var hora = horaObj.h + ":" + horaObj.m;
	
	console.log("Carrregando imagem " + parametro + " das " + hora);
	
	var url = "/metoc/goes/BR/" + parametro + "/" + dataAtualFormatada() + "/" + hora;
	
	console.log( url );
	
	$.ajax({
		url: url,
		type: "GET", 
		success: function( obj ) {
			
			if( obj ) {
				var data = { sourceAddress: obj.parametro_extenso, sourceLayer: hora, sourceName : obj.parametro_extenso, sourceHour: obj.hora, param: parametro, timeRequested: hora};
				addSingleImageryLayerCard( obj.base64, data );
			} else {
				fireToast( 'error', 'Erro', 'Não existe imagem ' + parametro + ' disponível para às ' + hora, '' );
				console.log("Imagem inexistente");
				// DESISTI DE ACIONAR FALLBACK. 
				//var newHora = backInTime( horaObj ); 
				//console.log( horaObj );
				//console.log( newHora );
				//getGoesImages( parametro, newHora );
			}
		},
		error: function(xhr, textStatus) {
			//
		}, 		
	});
	
}

function loadSatelites(){
	var theCurrentLayer;
	
	if( satVP ) {
		getGoesImages( "VP", horaAtual( true ) );
	} else {
		var theCurrentLayer = getLayerByKey( "chkVP" );
	}
	
	if( satTN ) {
		getGoesImages( "TN", horaAtual( true ) );
	} else {
		var theCurrentLayer = getLayerByKey( "chkTN" );
	}
	if( satIV ) {
		getGoesImages( "IV", horaAtual( true ) );
	} else {
		var theCurrentLayer = getLayerByKey( "chkIV" );
	}
	if( satVI ) {
		getGoesImages( "VI", horaAtual( true ) );
	} else {
		var theCurrentLayer = getLayerByKey( "chkVI" );
	}
	
	if (theCurrentLayer) deleteLayer( theCurrentLayer.uuid );
	
	
}


function startCorMetSolution(){

	loadCores( );
	var interv = ( 1000 * 60 ) * 5;
	corMetConJob = setInterval( function(){
		loadCores();
	}, interv );
	
}

function loadCores( ) {
	if( loadingCorMetoc ) {
		return;
	}
	loadingCorMetoc = true;
	removeCores();
	
	loadSatelites();

	isCorMetSolutionActive = true;
	$("#toolCOR").removeClass("btn-warning");
	$("#toolCOR").addClass("btn-danger");
	
	cores.push( {"cm":"AZ","color": Cesium.Color.ROYALBLUE } );
	cores.push( {"cm":"VD","color": Cesium.Color.GREEN } );
	cores.push( {"cm":"AM","color": Cesium.Color.YELLOW } );
	cores.push( {"cm":"AB","color": Cesium.Color.ORANGE } );
	cores.push( {"cm":"VM","color": Cesium.Color.RED } );
	
	var url = "/cor/getcolors";
	$.ajax({
		url: url,
		type: "GET", 
		success: function( obj ) {
			if( obj ) prepareData( obj );
		},
		error: function(xhr, textStatus) {
			loadingCorMetoc = false;
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
	var aerodromo = metar.airport;
	var aerodromoName = aerodromo.icao + " (" + aerodromo.iata + ")";
	var temp = metar.temperature;
	
	var alpha = refData.metar.alpha;  
	var beta = refData.metar.beta; 
	
	var visibility = metar.visibility.mainVisibility;  
	var cloud = "";
	
	var metarMessage = metar.message;
	var wind = metar.wind.directionDegrees + "\xB0 (" +metar.wind.direction + ") " + metar.wind.speed + "kt ";

	var theCor = refData.metar.cm;
	var cm = theCor.corMet;
	var teto = theCor.teto;
	var bkColor = getMetarBkColor(cm);	
	
	
	if( metar.cavok ){
		visibility = "> 10Km";
		teto = "> 5000ft";
		cloud = "NSC";
	}
	
	console.log( refData );
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Aeródromo</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + aerodromoName + "</td>" +
	"</tr>";
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Cor Atual</b></td>" +
	   "<td style='text-align: right;background-color:"+bkColor+"' class='layerTable'>" + cm + "</td>" +
	"</tr>";
	
	
	/*
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Temperatura</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + temp + "\xB0</td>" +
	"</tr>";
	*/
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Visibilidade</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + visibility + "</td>" +
	"</tr>";
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Teto</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + teto + "</td>" +
	"</tr>";

	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Alpha</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + alpha + "m</td>" +
	"</tr>";
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Beta</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + beta + "m</td>" +
	"</tr>";
	
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable'><b>Nuvem</b></td>" +
	   "<td style='text-align: right;' class='layerTable'>" + cloud + "</td>" +
	"</tr>";

	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td style='text-align: left;' class='layerTable'>" +
		   "<label><input style='margin: 0px 5px 0px 0px;' id='chkVP' type='checkbox' class='flat-red' >Vapor d'Água Realçado</label>" +
		   "<label><input style='margin: 0px 5px 0px 0px;' id='chkTN' type='checkbox' class='flat-red' >Topo das Nuvens (T ºC)</label>" +
		"</td>" +   
	   "<td style='text-align: left;' class='layerTable'>" +
		   "<label><input style='margin: 0px 5px 0px 0px;' id='chkIV' type='checkbox' class='flat-red' >Inf. Termal</label>" +
		   "<label><input style='margin: 0px 5px 0px 0px;' id='chkVI' type='checkbox' class='flat-red' >Visível</label>" +
	   "</td>" +
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
		
		var theCor = theData[x].metar.cm;
		var cm = theCor.corMet;
		
		var dh = cm + "<br>" + dia + "<br>" + hora + ":" + minuto;
		var bkColor = getMetarBkColor(cm);
		theButton = theButton + '<button style="background-color:'+bkColor+';margin-right:3px;width: 40px;font-size: 10px;float:left" type="button" class="btn btn-primary btn-xs btn-flat">'+dh+'</button>';
	}
	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td colspan='2' style='text-align:center;margin: 0 auto;' class='layerTable'>" + theButton + "</td>" +
	"</tr>";
	
	$(".queryRowDetails").remove();
   	$("#queryMenuTable").append( queryData );
   	$("#queryMenuBox").show();
   	
   	$("#chkVP").click( function(){
   		satVP = this.checked;
   		loadSatelites();
   	});
   	$("#chkTN").click( function(){
   		satTN = this.checked;
   		loadSatelites();
   	});
   	$("#chkIV").click( function(){
   		satIV = this.checked;
   		loadSatelites();
   	});
   	$("#chkVI").click( function(){
   		satVI = this.checked;
   		loadSatelites();
   	});

   	
   	
}

function getMetarBkColor( theMetarColor ){
	if( theMetarColor === "AZ" ) return '#00c0ef';
	if( theMetarColor === "VD" ) return '#008d4c';
	if( theMetarColor === "AM" ) return '#e0d90b';
	if( theMetarColor === "AB" ) return '#e08e0b';
	if( theMetarColor === "VM" ) return '#d73925';
}

function removeCores(){
	for( var ww = 0; ww < aerodromos.length; ww++ ) {
		viewer.entities.remove( aerodromos[ww].entity );
	}
	aerodromos = [];
}

function prepareData( obj ){
	
	if(!isCorMetSolutionActive) return;
	
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
	bindCormetMouseClickQuery();
	
	loadingCorMetoc = false;
	$("#mainWaitPanel").hide();
}


function removeCormetMouseClickQuery(){
	corMetEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.LEFT_CLICK);
	corMetEventHandler.removeInputAction(Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	corMetEventHandler = null;
}

function bindCormetMouseClickQuery(){
	corMetEventHandler = new Cesium.ScreenSpaceEventHandler( scene.canvas );
	
	corMetEventHandler.setInputAction( function( click ) {
		var pickedObject = viewer.scene.pick( click.position );
	    if ( Cesium.defined( pickedObject ) ) {
	    	var entity = pickedObject.id;
	    	if ( entity.name === "CORMET_AERODROMO") showColorAerodromo( entity );
	    }
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);

	corMetEventHandler.setInputAction( function( movement ) {
		var pickedObject = viewer.scene.pick( movement.endPosition );
	    if ( Cesium.defined( pickedObject ) ) {
	    	var entity = pickedObject.id;
	    	if ( Cesium.defined( entity  ) && entity.name === "CORMET_AERODROMO") {
	    		viewer._container.style.cursor = "help";
	    		var theData = entity.properties.data.getValue();
	    		var topPos = movement.endPosition.y + 20 + "px";
	    		var leftPos = movement.endPosition.x + 20 + "px";
	    		var theButton = "";
	    		var maxColors = theData.length;
	    		var widthPercent = (100 / maxColors);
	    		for( var x=0; x < maxColors;x++   ) {
	    			var cm = theData[x].metar.cm.corMet;
	    			var dh = "&nbsp;";
	    			var bkColor = getMetarBkColor(cm);
	    			theButton = theButton + '<div style="width:'+widthPercent+'%;height:100%;float:left;background-color:'+bkColor+';"></div>';
	    		}
	    		$("#corMetToolTip").html( theButton );
	    		$("#corMetToolTip").css({'top': topPos,'left':leftPos});
	    		$("#corMetToolTip").show();
	    	}
	    } else {
	    	viewer._container.style.cursor = "default";
	    	$("#corMetToolTip").hide();
	    }
	}, Cesium.ScreenSpaceEventType.MOUSE_MOVE);
	
	
}

function loadAerodromos() {
	
	for( var ww = 0; ww < aerodromos.length; ww++ ) {
		var data = aerodromos[ww].data;
		var lastData = data[ data.length -1 ];
		var metar = lastData.metar;
		var corMet = metar.cm.corMet.toLowerCase();
		var aerodromo = metar.metar.airport;
		var dataContainer = {"data":data};
		
		var position = Cesium.Cartesian3.fromDegrees( parseFloat(aerodromo.longitude), parseFloat(aerodromo.latitude), 10 );
		
        var aerodromoCor = {
        	image : '/resources/img/' + corMet + "-o.png",
            width : 25,
            height : 25,
            pixelOffset : new Cesium.Cartesian2(0, -10),
            scaleByDistance : new Cesium.NearFarScalar(1.5e2, 1.0, 1.5e7, 0.2),
            disableDepthTestDistance : Number.POSITIVE_INFINITY            
        };
        
        if( scene.mode == Cesium.SceneMode.SCENE3D ){
        	aerodromoCor.heightReference = Cesium.HeightReference.CLAMP_TO_GROUND;
        }
		
		var aerodromoCormet = viewer.entities.add({
			name : 'CORMET_AERODROMO',
	        position : position,
	        properties : dataContainer,
	        billboard : aerodromoCor
		});
		
		aerodromos[ww].entity = aerodromoCormet;
		aerodromos[ww].uuid = createUUID();
	}
	
}
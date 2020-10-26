var layerStack = [];
var searchedLayersResult = [];
var stackedProviders = [];
var baseLayer = null;	

var bdgexCartasImageryProvider = null;
var rapidEyeImagery = null;
var contourLines = null;
var contourShade = null;
var openseamap = null;
var cartasCHM = null;
var metocLayer = null;
var marinetraffic = null;


// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

function updateLayersOrder( event, ui ){
	
	var uuid = ui.item[0].id;
	var newLayerIndex = ui.item.index() + 2;  // 0=Camada Base // 1=Grid Coordenadas // 2 > Camadas do usuário...
	var layer = getLayerByUUID( uuid );
	var currentLayerIndex = viewer.imageryLayers.indexOf( layer );
	
	if( newLayerIndex < currentLayerIndex ){
		var steps = currentLayerIndex - newLayerIndex;
		for( x=0; x<steps; x++){
			viewer.imageryLayers.lower(layer);
		}
	}
	if( newLayerIndex > currentLayerIndex ){
		var steps = newLayerIndex - currentLayerIndex;
		for( x=0; x<steps; x++){
			viewer.imageryLayers.raise(layer);
		}
	}
	
	var targetLayerIndex = viewer.imageryLayers.indexOf( layer );
}

function expandCard(uuid){
	var idX = "#expd_" + uuid;
	var idC = "#cops_" + uuid;
	$( idX ).hide();
	$( idC ).show();
	$("#" + uuid).css( 'height', 300 );
}

function collapseCard( uuid ){
	var idX = "#expd_" + uuid;
	var idC = "#cops_" + uuid;
	$( idC ).hide();
	$( idX ).show();
	$("#" + uuid).css( 'height', 70 );
}


function hideLayer( uuid ){
	var idH = "#hdlay_" + uuid;
	var idS = "#swlay_" + uuid;
	$( idH ).hide();
	$( idS ).show();
	doHideLayer( uuid );
}

function showLayer( uuid ){
	var idH = "#hdlay_" + uuid;
	var idS = "#swlay_" + uuid;
	$( idS ).hide();
	$( idH ).show();
	doShowLayer( uuid, 1 );
}

function doShowLayer( uuid ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid === uuid ) {
			sp.layer.show = true;
		}
	}
}

function getLayerByUUID( uuid ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid === uuid ) {
			return sp.layer;
		}
	}
	return null;
}

function getLayerByKey( key ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		var layerKey = sp.data.sourceAddress + sp.data.sourceLayer;
		if( layerKey === key ) {
			return sp.layer;
		}
	}
	return null;
}


function doHideLayer( uuid ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid == uuid ) {
			sp.layer.show = false;
		}
	}
}

function doSlider( uuid, value ){
	for( x=0; x<stackedProviders.length;x++ ) {
		var sp = stackedProviders[x];
		if( sp.uuid == uuid ) {
			sp.layer.alpha = value;
		}
	}
}

function getALayerCard( uuid, layerAlias, defaultImage  ){
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>'+layerAlias+'</b>'+
	
	'<div class="box-tools pull-right">'+                           
		//'<button id="hdlay_'+uuid+'" onClick="hideLayer(\''+uuid+'\');" title="Ocultar Camada" type="button" style="display:none;padding: 0px;margin-right:15px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-eye"></i></button>'+
		//'<button id="swlay_'+uuid+'" onClick="showLayer(\''+uuid+'\');" title="Exibir Camada" type="button" style="padding: 0px;margin-right:15px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-eye-slash"></i></button>'+
		'<button id="expd_'+uuid+'" onClick="expandCard(\''+uuid+'\');" title="Expandir" type="button" style="padding: 0px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-caret-right"></i></button>'+
		'<button id="cops_'+uuid+'"onClick="collapseCard(\''+uuid+'\');" title="Recolher" type="button" style="display:none;padding: 0px;" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-caret-down"></i></button>'+
	'</div>' +	
	
	'</td></tr>'; 
	table = table + '<tr><td colspan="2" style="width: 60%;">'; 
	table = table + '<input id="SL_'+uuid+'" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100" ' +
		'data-slider-tooltip="hide" data-slider-step="5" data-slider-value="100" data-slider-id="blue">';
	table = table + '</td><td >' + 
	'<a title="Excluir Camada" href="#" onClick="deleteLayer(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'<a title="RF-YYY" style="margin-right: 10px;" href="#" onClick="layerToUp(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-floppy-o"></i></a>' + 
	'<a title="RF-ZZZ" style="margin-right: 10px;" href="#" onClick="layerToDown(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-gear"></i></a>' + 
	'<a title="RF-WWW" style="margin-right: 10px;" href="#" onClick="exportLayerToPDF(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-search-plus"></i></a>' + 
	'</td></tr>';
	table = table + '</table></div>';
	var layerText = '<div class="sortable" id="'+uuid+'" style="overflow:hidden;height:70px;background-color:white; margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div><div class="box-footer" id="LEG_'+uuid+'"></div></div>';
	return layerText;
}

/*
function getALayerGroup( uuid, groupName, defaultImage ){
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>'+groupName+'</b></td></tr>'; 
	table = table + '<tr><td colspan="3" id="GRPCNT_'+uuid+'"></td></tr>';
	table = table + '</table></div>';
	var layerText = '<div class="sortable" id="'+uuid+'" style="background-color:white; margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';
	return layerText;
}
*/


function updateLegendImages(){
	for( x=0; x<stackedProviders.length;x++ ){
		var sp = stackedProviders[x];
		var data = sp.data;
		if( data ){
			var uuid = sp.uuid;
			
			var imgUUID = "IMG_" + uuid;
			
		    var bWest = "", bSouth = "", bEast = "", bNorth = "";
		    if( Cesium.defined( scratchRectangle ) ){
			    var bWest = Cesium.Math.toDegrees(scratchRectangle.west);
			    var bSouth = Cesium.Math.toDegrees(scratchRectangle.south);
			    var bEast = Cesium.Math.toDegrees(scratchRectangle.east);
			    var bNorth = Cesium.Math.toDegrees(scratchRectangle.north);
		    }
		    
			jQuery.ajax({
				url: "/proxy/getlegend?uuid=" + uuid + "&sourceId=" + data.id + '&bw='+bWest+'&bs='+bSouth+'&be='+bEast+'&bn='+bNorth,
				type: "GET", 
				success: function( imagePath ) {
					if( imagePath != '' ){
						console.log('Nova imagem : ' + imagePath);
						$( "#" + imgUUID ).attr("src", imagePath );
					} else {
						console.log('Sem legenda.');
					}
				}
			});
			
			
			
			
		}
		
	}
}

function addLayerCard( data ){
	var uuid = "L-" + createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.data = data;
	
	var key = data.sourceAddress + data.sourceLayer;
	if( getLayerByKey( key ) != null ) {
		fireToast( 'info', 'Camada Já Criada', 'A camada ' + data.sourceName + ' já está criada.' , '000' );
		return;
	}
	
	var provider = getProvider( data.sourceAddress, data.sourceLayer, false, 'png', true );
	if( provider ){
		theProvider.layer = viewer.imageryLayers.addImageryProvider( provider );
		
		var props = { 'uuid':uuid  }
		theProvider.layer.properties = props; 
		theProvider.data = data;

		stackedProviders.push( theProvider );		

		// Adiciona o Card
	    var defaultImage = "<img title='Alterar Ordem' style='cursor:move;border:1px solid #cacaca;width:19px;' src='/resources/img/drag.png'>";
		var layerText = getALayerCard( uuid, data.sourceName, defaultImage );
		$("#activeLayerContainer").append( layerText );
		
		$("#SL_"+uuid).bootstrapSlider({});
		$("#SL_"+uuid).on("slide", function(slideEvt) {
			var valu = slideEvt.value / 100;
			doSlider( this.id.substr(3), valu );
		});	

		// Legenda
		var legUUID = "LEG_" + uuid;
		var imgUUID = "IMG_" + uuid;
		
	    var bWest = "", bSouth = "", bEast = "", bNorth = "";
	    if( Cesium.defined( scratchRectangle ) ){
		    var bWest = Cesium.Math.toDegrees(scratchRectangle.west);
		    var bSouth = Cesium.Math.toDegrees(scratchRectangle.south);
		    var bEast = Cesium.Math.toDegrees(scratchRectangle.east);
		    var bNorth = Cesium.Math.toDegrees(scratchRectangle.north);
	    }
	    
		jQuery.ajax({
			url: "/proxy/getlegend?uuid=" + uuid + "&sourceId=" + data.id + '&bw='+bWest+'&bs='+bSouth+'&be='+bEast+'&bn='+bNorth,
			type: "GET", 
			success: function( imagePath ) {
				if( imagePath != '' ){
					var n = new Date().getTime();					
					$( "#" + legUUID ).html( "<img id='"+imgUUID+"' src='" + imagePath + "'>" );
					$( "#" + legUUID ).slimScroll({
				        height: '205px',
				        wheelStep : 10,
				    });
				} else {
					console.log('Sem legenda.');
				}
			}
		});
		
		$('#activeLayerContainer').slimScroll();
	}	

}

function deleteLayer( uuid ) {
	
	for( x=0; x < stackedProviders.length;x++ ) {
		var ll = stackedProviders[x];
		if ( ll.uuid == uuid ) {
			if( viewer.imageryLayers.remove( ll.layer, true ) ){
				stackedProviders.splice(x, 1);
				jQuery("#" + uuid).fadeOut(400, function(){
					jQuery("#" + uuid).remove();
				});
			} else {
				// um toast?
			}
			return;
		}
	}
}


// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************



function layerToDown( uuid ) {
	console.log("DN: " + uuid );
	for( x=0; x < stackedProviders.length;x++ ) {
		var ll = stackedProviders[x];
		if ( ll.uuid == uuid ) {
			viewer.imageryLayers.lower( ll.layer );
			return;
		}
	}
}

function layerToUp( uuid ) {
	console.log("UP: " + uuid );
	for( x=0; x < stackedProviders.length;x++ ) {
		var ll = stackedProviders[x];
		if ( ll.uuid == uuid ) {
			viewer.imageryLayers.raise( ll.layer );
			return;
		}
	}
}

function addToPanelLayer( layerName, workspace, scale, layerAlias, server, imageType ) {
	if( !imageType ) imageType = 'png8';
	if( !server ) server = pleione;
	
	var layerFullName = layerName;
	if( workspace != '' ) layerFullName = workspace+":"+layerName;
	
	var uuid = createUUID(); 
	var theProvider = {};
	theProvider.uuid = uuid;
	var theScale = 'Todas'
	
	if ( scale === 'SCALE_ALL') {
		theProvider.layer = addLayer( layerFullName , server, layerFullName, true, 1.0, imageType ); 
	} else {
		var filter = "escala=" + scale;
		theProvider.layer = addLayerWithFilter( layerFullName , pleione, layerFullName, true, 1.0, 'png8', filter );
		theScale = '1:' + scale;
	}
	
	var props = { 'scale':scale, 'layerFullName':layerFullName }
	
	theProvider.layer.properties = props; 
	stackedProviders.push( theProvider );
	
	var imgPoint = "<img title='Pontos' style='border:1px solid #cacaca;width:19px;' src='/resources/img/points.png'>";
	var imgLine = "<img title='Linhas' style='border:1px solid #cacaca;width:19px;' src='/resources/img/lines.png'>";
	var imgPolygon = "<img title='Áreas' style='border:1px solid #cacaca;width:19px;' src='/resources/img/polygons.png'>";
	var defaultImage = "<img title='Geometria Mista' style='border:1px solid #cacaca;width:19px;' src='/resources/img/unknow.png'>";

	if( layerName.endsWith("_a") ) defaultImage = imgPolygon;
	if( layerName.endsWith("_l") ) defaultImage = imgLine;
	if( layerName.endsWith("_p") ) defaultImage = imgPoint;
	
	
	var tipoCarto = "Fonte Externa";
	var sourceName = "Externa";

	if( workspace === 'odisseu' ) {
		tipoCarto = "Cartografia Terrestre";
		sourceName = "DSG";
	}	

	if( workspace === 'icaro' ) {
		tipoCarto = "Cartografia Aeronáutica";
		sourceName = "ICA";
	}	

	if( workspace === 'nautilo' ) {
		tipoCarto = "Cartografia Náutica";
		sourceName = "CHM";
	}	
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + defaultImage + '&nbsp; <b>Camada EDGV-DEFESA</b>' +
	'<a title="Apagar Camada" href="#" onClick="deleteLayer(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	
	'<a title="Para cima das outras" style="margin-right: 10px;" href="#" onClick="layerToUp(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-arrow-circle-up"></i></a>' + 
	'<a title="Para baixo das outras" style="margin-right: 10px;" href="#" onClick="layerToDown(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-arrow-circle-down"></i></a>' + 
	
	'<a title="Exportar Para PDF" style="margin-right: 10px;" href="#" onClick="exportLayerToPDF(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-file-pdf-o"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td colspan="3" class="layerTable"><b>' + layerAlias + '</b></td></tr>';
	table = table + '<tr><td colspan="2" class="layerTable">' + tipoCarto + '</td><td class="layerTable" style="text-align:right" >'+theScale+'</td></tr>';

	table = table + '<tr><td colspan="3" style="padding-left: 15px;padding-right: 15px;padding-top: 3px;padding-bottom: 3px;">'; 
	table = table + '<input id="SL_'+uuid+'" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100"' +
		'data-slider-tooltip="hide" data-slider-step="5" data-slider-value="100" data-slider-id="blue">';
	table = table + '</b></td></tr>';
	
	table = table + '</table></div>';
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#activeLayerContainer").append( layerText );
	jQuery("#layerContainer").show( "slow" );
	
	var count = jQuery('#activeLayerContainer').children().length;
	jQuery("#layersCounter").html( count );	

	jQuery("#SL_"+uuid).bootstrapSlider({});
	jQuery("#SL_"+uuid).on("slide", function(slideEvt) {
		var valu = slideEvt.value / 100;
		doSlider( slideEvt.target.id.substr(3), valu );
	});	
	
}

function addLayerCart( uuid, workspace, layerName, scale) {
	for( x=0; x < searchedLayersResult.length;x++ ) {
		var ll = searchedLayersResult[x];
		for( y=0; y < ll.layer.layers.length;y++ ) {
			var tt = ll.layer.layers[y];
			if( tt.layer == layerName ) {
				
				var layerFullName = workspace+":"+layerName;
				var found = false;
				// verifica se ja tem na tela
				for( zz=0; zz < stackedProviders.length; zz++ ) {
					var propsCheck = stackedProviders[zz].layer.properties;
					if( (propsCheck.scale == scale) && ( propsCheck.layerFullName == layerFullName ) ) {
						found = true;
						break;
					}
				}
				
				if( !found ) addToPanelLayer( layerName, workspace, scale, ll.layer.nome );
				
				break;
			}
		}
	}
}

function queryLayer() {

	mainEventHandler.setInputAction( function( click ) {
		
		var pickedObject = viewer.scene.pick( click.position );
		var pickRay = viewer.camera.getPickRay( click.position );
		var featuresPromise = viewer.imageryLayers.pickImageryLayerFeatures(pickRay, viewer.scene);

		// Camadas
		if (Cesium.defined(featuresPromise)) {
		    Cesium.when(featuresPromise, function(features) {
		    	if( !Cesium.defined( pickedObject ) ) { 
			    	jQuery(".queryRowDetails").remove();
			        for( xx=0; xx<features.length; xx++ ) {
			        	jQuery("#queryMenuTable").append( getTrQuery( features[xx] ) );
			        }
		    	}
		    });
		} else {
		    console.log('Nenhuma camada clicada.');
		}		
		
		// Objetos
	    if ( Cesium.defined( pickedObject ) ) {
	    	var entity = pickedObject.id;
	    	
	    	console.log("QUERY ENTITY: " + entity.name );
	    	
	    	if ( entity.name === 'ROTA_POI') showRotaPoi( entity );
	    	if ( entity.name === 'PHOTO_HASTE') showStreetImage( entity );
	    	//if ( entity.name === "PLATAFORMA") showPlataformaInfo( entity );
	    	//if ( entity.name === "NAVIO_SISTRAM") showNavioInfo( entity );
	    	if ( entity.name === "PCN_RUNWAY") showRunwayInfo( entity );
	    	if ( entity.name === "CORMET_AERODROMO") showColorAerodromo( entity );
	    	if ( entity.name === "MUNICIPIO_PREVISAO") showPrevisaoMunicipio( entity );
	    	if ( entity.name === "AERODROMO_METOC") showMetarAerodromo( entity );
	    	
	    } else {
	    	console.log('Nenhuma entidade clicada.');
	    }
	}, Cesium.ScreenSpaceEventType.LEFT_CLICK);
	
	
}

function getTrQuery( queryResult ){
	var properties = queryResult.properties;
	var position = queryResult.position;
	var geomType = queryResult.data.geometry.type;
	var metadados = JSON.parse( properties.metadados );
	var bbox = properties.bbox;
	var produto = JSON.parse( properties.json_produto ); 
	var trId = createUUID();
	var tipoCarto = "Cartografia Desconhecida";
	var icon = "";
	var externalMetadata = "";
	var sourceName = produto["Fonte"];
	
	if( sourceName === 'DSG' ) {
		tipoCarto = "Cartografia Terrestre";
		externalMetadata = properties.perfil_metadados_identificador;
		icon = "odisseu.png"
	}	

	if( sourceName === 'CENSIPAM' ) {
		tipoCarto = "Cartografia Terrestre";
		externalMetadata = properties.perfil_metadados_identificador;
		icon = "censipam.png"
	}	
	
	if( sourceName === 'ICA' ) {
		tipoCarto = "Cartografia Aeronáutica";
		icon = "icaro.png"
	}	

	if( sourceName === 'CHM' ) {
		tipoCarto = "Cartografia Náutica";
		icon = "nautilo.png"
	}
	
	var iconImg = "<img title='" + sourceName + "' style='border:1px solid #cacaca;width:30px;' src='/resources/img/"+icon+"'>";
	var queryData = "";

	queryData = queryData + "<tr class='queryRowDetails'>" +
	   "<td class='layerTable' style='width: 30%;'>" + iconImg + "</td>" +
	   "<td colspan='2' style='text-align: right;' class='layerTable'>&nbsp;</td>" +
	"</tr>";
	
	
	var keys = Object.keys( produto );
	for( xx=0; xx<keys.length;xx++ ) {
		var key = keys[xx];
		var value = produto[ key ];
		queryData = queryData + "<tr class='queryRowDetails'>" +
		   "<td class='layerTable' style='width: 30%;'><b>" + key + "</b></td>" +
		   "<td colspan='2' style='text-align: right;' class='layerTable'>" + value + "</td>" +
		"</tr>";
	}

	/*
	if( externalMetadata != "" ) {
		queryData = queryData + '<tr class="queryRowDetails"><td class="layerTable" colspan="3" class="layerTable" style="text-align: right;"><button onclick="gotoBdgex(\''+externalMetadata+'\')"  type="button" class="btn btn-block btn-primary btn-xs btn-flat">Ver Metadados</button></td></tr>';
	}
	*/
	
	var firstRowStyle = "border-top: 2px solid #3c8dbc";
	var keys = Object.keys( metadados );
	for( xx=0; xx<keys.length;xx++ ) {
		var key = keys[xx];
		var value = metadados[ key ];
		var theRealValue = value;
		
		if( Array.isArray( value ) ) {
			theRealValue = "";
			for( vvv=0; vvv<value.length;vvv++  ) {
				var infoIcon = '<span style="cursor:pointer;margin-left: 10px;" title="'+value[vvv].descricao+'" class="text-light-blue pull-right"><i class="fa fa-info-circle"></i></span>';
				theRealValue = theRealValue + value[vvv].nome + infoIcon + '<br>';
			}
		}
		
		queryData = queryData + "<tr style='"+firstRowStyle+"' class='queryRowDetails'>" +
		   "<td class='layerTable' style='width: 30%;'><b>" + key + "</b></td>" +
		   "<td colspan='2' style='text-align: right;' class='layerTable'>" + theRealValue + "</td>" +
		"</tr>";
		firstRowStyle = "";
	}
	
	return queryData;
}

function downloadProduct( identificador ) {
	// https://bdgex.eb.mil.br/mediador/index.php?modulo=download&acao=baixar&identificador=2c2d1fd7-1bd1-5a4d-7bbb-fb0aeb9cabbb
	var url = "https://bdgex.eb.mil.br/mediador/index.php?modulo=download&acao=baixar&identificador=" + identificador;
	window.open(url,'_blankdown');
}


function addRow( key, value ) {
	jQuery("#queryMenuTable").append("<tr class='queryRowDetails'>" +
	   "<td class='layerTable' style='width: 30%;'><b>" + key + "</b></td>" +
	   "<td colspan='2' style='text-align: right;' class='layerTable'>" + value + "</td>" +
	"</tr>");	
}

function gotoBdgex( identificador ) {
	// var url = "https://bdgex.eb.mil.br/mediador/index.php?modulo=metaDados&acao=formularioInformacao&uuid=" + identificador;
	
	//identificador = "4e879571-ffbe-d57d-2244-5866de14af59";
	
	console.log( "/metadado?uuid=" + identificador );
	
	jQuery.ajax({
		url:"/metadado?uuid=" + identificador,
		type: "GET", 
		success: function( obj ) {
	    	jQuery(".queryRowDetails").remove();
	    	
	    	console.log( obj );

			addRow( "Organização", obj["gmd:contact"]["gmd:CI_ResponsibleParty"]["gmd:organisationName"]["gco:CharacterString"]["#text"] );
			
			var links = obj["gmd:distributionInfo"]["gmd:MD_Distribution"]["gmd:onLine"];
			var urls = "";
			if( links.length > 0  ) {
				for( xx=0; xx < links.length; xx++ ) {
					urls = urls + "<a href='" + links[xx]["gmd:CI_OnlineResource"]["gmd:linkage"]["gco:CharacterString"]["#text"] + "'>[Recurso]</a></br>" ;
				}
			}
			addRow( "Download", urls );
			
			addRow( "Sistema", obj["gmd:referenceSystemInfo"]["gmd:MD_ReferenceSystem"]["gmd:referenceSystemIdentifier"]["gmd:RS_Identifier"]["gmd:code"]["gco:CharacterString"]["#text"] );
			
			
			
		},
		error: function(xhr, textStatus) {
			console.log('Erro');
		}, 		
	});
	
}

function getTr( layer ){
	var icon = "nk.png";
	var nome = layer.nome;
	var tipoCarto = "Cartografia Desconhecida";
	var sourceName = "Origem Desconhecida";

	if( layer.workspace === 'odisseu' ) {
		tipoCarto = "Cartografia Terrestre";
		sourceName = "Cartografia Terrestre";
		icon = "ct.png";
	}	

	if( layer.workspace === 'icaro' ) {
		tipoCarto = "Cartografia Aeronáutica";
		sourceName = "Cartografia Aeronáutica";
		icon = "ca.png";
	}	

	if( layer.workspace === 'nautilo' ) {
		tipoCarto = "Cartografia Náutica";
		sourceName = "Cartografia Náutica";
		icon = "cn.png";
	}

	var imgPoint = "<img title='Pontos' style='border:1px solid #cacaca;width:19px;' src='/resources/img/points.png'>";
	var imgLine = "<img title='Linhas' style='border:1px solid #cacaca;width:19px;' src='/resources/img/lines.png'>";
	var imgPolygon = "<img title='Áreas' style='border:1px solid #cacaca;width:19px;' src='/resources/img/polygons.png'>";
	var defaultImage = "<img title='Geometria Mista' style='border:1px solid #cacaca;width:19px;' src='/resources/img/unknow.png'>";

	var trId = createUUID();
	var theDiv = "<div style='height:37px;width:100%;'>" +
	"<div style='float:left;width:35px;height:36px;'>" +
	"<img title='" + sourceName + "' style='border:1px solid #cacaca;width:30px;' src='/resources/img/"+icon+"'>" +
	"</div>" +
	"<div style='float:left;width:80%'><div style='height:18px;border-bottom:1px solid #cacaca'><b>"+nome+"</b></div><div style='height:15px;'>"+tipoCarto+"</div></div>" + 
	"</div>";

	
	var theLayerResult = {};
	theLayerResult.uuid = trId;
	theLayerResult.layer = layer;
	searchedLayersResult.push( theLayerResult );
	
	for( xx=0; xx<layer.layers.length;xx++ ) {
		var theLayer = layer.layers[xx];
		var escalas = theLayer.escalas;
		var layerName = theLayer.layer;

		if( layerName.endsWith("_a") ) defaultImage = imgPolygon;
		if( layerName.endsWith("_l") ) defaultImage = imgLine;
		if( layerName.endsWith("_p") ) defaultImage = imgPoint;

		var scaleLinks = "<a onclick='addLayerCart(\""+trId+"\",\""+layer.workspace+"\",\""+layerName+"\",\"SCALE_ALL\");' href='#'>Todas</a>";
		for( yy=0; yy<escalas.length;yy++ ) {
			scaleLinks = scaleLinks + " | <a onclick='addLayerCart(\""+trId+"\",\""+layer.workspace+"\",\""+layerName+"\",\""+escalas[yy]+"\");' href='#'>1:"+escalas[yy]+"</a>";
		}
		theDiv = theDiv + "<div style='width:100%;height:25px;border-top: 1px solid #f4f4f4;'>"+ defaultImage + "  " + scaleLinks +"</div>";
	}

	var theTr = "<tr style='margin-bottom:2px;border-bottom: 2px solid #3c8dbc;' class='layerFoundItem' id='"+ trId +"'><td id='"+ trId +"_td' colspan='2' class='layerTable'>" + theDiv + "</td></tr>";
	return theTr;
}

function updateFoundLayerPanel( layers ) {
	searchedLayersResult = [];
	for( x=0; x < layers.length; x++  ) {
		var layer = layers[x];
		jQuery("#searchMenuTable").append( getTr(layer) );
	}
}

function findLayerByNome( ) {
	jQuery(".layerFoundItem").remove();
	var nome = jQuery("#layerNameFinder").val();

	if( nome === '' ) {
		closeSearchToolBarMenu();
		return;
	}
	
	jQuery("#treeview-terrestre").hide();	

	jQuery.ajax({
		url:"/cartografia/find?limite=5&nome=" + nome,
		type: "GET", 
		success: function( obj ) {
			updateFoundLayerPanel( obj );
		},
		error: function(xhr, textStatus) {
			console.log('Erro');
		}, 		
	});
}

function createImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType ) {

	var imageryProvider = new Cesium.WebMapServiceImageryProvider({ 
		url : sourceUrl, 
		layers : sourceLayers,
		tileWidth: 256,
		tileHeight: 256,		
		enablePickFeatures : canQuery,
		parameters : { 
			transparent : false,
			srs	: 'EPSG:4326',
			format : 'image/' + imageType, 
			tiled : true 
		}
	});	
	imageryProvider.defaultAlpha = transparency;
	return imageryProvider;
}

function createFilteredImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType, filter ) {

	var imageryProvider = new Cesium.WebMapServiceImageryProvider({ 
		url : sourceUrl, 
		layers : sourceLayers,
		tileWidth: 256,
		tileHeight: 256,		
		enablePickFeatures : canQuery,
		parameters : { 
			transparent : true,
			srs	: 'EPSG:4326',
			format : 'image/' + imageType, 
			tiled : true, 
			cql_filter : filter
		}
	});	
	imageryProvider.defaultAlpha = transparency;

	return imageryProvider;
}


function addLayerWithFilter( layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType, filter ) {
	if( !imageType ) imageType = 'png8';	
	var layer = {};
	var provider = createFilteredImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType, filter );
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	return layer.imageryLayer;
}

function setLayerOpacity( layerName, opacity ) {
	for ( var x=0; x < layerStack.length; x++  ) {
		if ( layerStack[x].name == layerName ) {
			layerStack[x].imageryLayer.alpha = opacity;
		}
	}
}


function addWMTSLayer( layerName, sourceUrl, sourceLayers, transparency, time ) {
	var layer = {};
	
	var times = Cesium.TimeIntervalCollection.fromIso8601({
	    iso8601: '2019-11-20/2019-11-20/P1D',
	    dataCallback: function dataCallback(interval, index) {
	        return {
	            Time: Cesium.JulianDate.toIso8601(interval.start)
	        };
	    }
	});	
	
	var provider = new Cesium.WebMapTileServiceImageryProvider({ 
	    url : 'https://map1a.vis.earthdata.nasa.gov/wmts-geo/wmts.cgi?time=2019-11-20',
	    layer : 'VIIRS_SNPP_CorrectedReflectance_BandsM11-I2-I1',
	    style : 'default',
	    //times : times,
	    //clock : viewer.clock,
	    format : 'image/jpeg',
	    tileMatrixSetID : 'EPSG4326_250m',
	});

	/*
	provider.readyPromise.then(function() {
        var start = Cesium.JulianDate.fromIso8601('2015-07-30');
        var stop = Cesium.JulianDate.fromIso8601('2017-06-17');
        viewer.timeline.zoomTo(start, stop);
        var clock = viewer.clock;
        clock.startTime = start;
        clock.stopTime = stop;
        clock.currentTime = start;
        clock.clockRange = Cesium.ClockRange.LOOP_STOP;
        clock.multiplier = 86400;
    });
    */	
	
	
	provider.defaultAlpha = transparency;
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	layer.imageryLayer.brightness = 5.0;
	layer.imageryLayer.alpha = transparency;
	return layer.imageryLayer;
}


// https://wms.hycom.org/thredds/wms/GLBy0.08/latest?service=WMS&version=1.3.0&request=GetCapabilities
// https://wms.hycom.org/thredds/wms/GLBy0.08/latest?LAYERS=sea_water_velocity&ELEVATION=-15&TIME=2019-10-25T12%3A00%3A00.000Z&TRANSPARENT=true&STYLES=vector%2Frainbow&COLORSCALERANGE=-50%2C50&NUMCOLORBANDS=20&LOGSCALE=false&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&FORMAT=image%2Fpng&SRS=EPSG%3A4326&BBOX=-44.472656250001,-27.564697265625,-36.035156250001,-20.972900390625&WIDTH=768&HEIGHT=600
// https://wms.hycom.org/thredds/wms/GLBy0.08/latest/?transparent=true&width=256&height=256&elevation=-15&time=2019-10-25T12%3A00%3A00.000Z&srs=EPSG%3A4326&styles=vector%2Frainbow&colorscalerange=0.004%2C0.8193&format=image%2Fpng&tiled=true&numcolorbands=20&logscale=false&service=WMS&version=1.1.1&request=GetMap&layers=sea_water_velocity&bbox=-47.81249999999999%2C-22.5%2C-45%2C-19.687499999999996
function addMetocLayer( layerName, sourceUrl, sourceLayers, transparency, time ) {
	console.log( sourceUrl );
	var layer = {};
	// http://sisgeodef.defesa.mil.br:36485/thredds/wms/testAll/best_chuva.nc?
	// LAYERS=Precipitation_rate_surface&
	// ELEVATION=0&
	// TIME=2019-09-26T00:00:00.000Z&
	// TRANSPARENT=true&
	// STYLES=boxfill/rainbow&
	// COLORSCALERANGE=0,0.0038&
	// NUMCOLORBANDS=20&
	// LOGSCALE=false&
	// SERVICE=WMS&
	// VERSION=1.1.1&
	// REQUEST=GetMap&
	// FORMAT=image/png&
	// SRS=EPSG:4326&
	// BBOX=-33.75,-11.25,-22.5,0&
	// WIDTH=256&HEIGHT=256
	var provider = new Cesium.WebMapServiceImageryProvider({ 
		url : sourceUrl, 
		layers : sourceLayers,
		enablePickFeatures : false,
		parameters : { 
			transparent : true,
			//WIDTH:256,
			//HEIGHT:256,
			ELEVATION:0,
			time : time,
			srs	: 'EPSG:4326',
			//styles : 'vector/rainbow', // 'boxfill/rainbow', // contour/rainbow
			COLORSCALERANGE : '0.001,2.005', //  '0.004,0.8193',
			format : 'image/png', 
			tiled : true,
			NUMCOLORBANDS : 253,
			LOGSCALE : false,
			
		}
	});	
	provider.defaultAlpha = transparency;
	
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	
	layer.imageryLayer.brightness = 5.0;
	layer.imageryLayer.alpha = transparency;
	//layer.imageryLayer.contrast = 0.0;
	//layer.imageryLayer.hue = 0.0;
	//layer.imageryLayer.saturation = 0.0;
	//layer.imageryLayer.gamma = 15.0;
	
	
	return layer.imageryLayer;
}

function addLayer( layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType ) {
	if( !imageType ) imageType = 'png8';	
	var layer = {};
	var provider = createImageryProvider( sourceUrl, sourceLayers, canQuery, transparency, imageType );
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	return layer.imageryLayer;
}


function addMarineTrafficLayer( elementId ) {
	var layer = {};
	var layerName = 'MarineTraffic';
	var provider = new MagnoMarineTrafficProvider({
		url : "https://tiles.marinetraffic.com/ais_helpers/shiptilesingle.aspx?output=png&sat=1&grouping=shiptype&tile_size=512&legends=1&zoom={z}&X={x}&Y={y}",
		whenFeaturesAcquired : function( shipPackageData ){
			for( x=0; x < shipPackageData.ships.length; x++   ) {
				var theShip = shipPackageData.ships[x];
				var lat = theShip[1];
				var lon = theShip[0];
				var theHash = Geohash.encode(lat,lon,10);
				var key = theShip[2];
				theShip.push( theHash );
				shipsInScreen[ key ] = theShip;
			}
			console.log( shipPackageData );
		}
	});
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	
	var uuid = createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.layer = layer.imageryLayer;
	
	var props = { 'uuid':uuid, 'elementId':elementId, 'layerName': layerName, 'sourceUrl':'', 'sourceLayers':'' };
	theProvider.layer.properties = props; 
	stackedProviders.push( theProvider );
	return theProvider;
}


function addBaseSystemLayer( elementId, layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType ) {
	var uuid = createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.layer = addLayer( layerName, sourceUrl, sourceLayers, canQuery, transparency, imageType ); 
	
	var props = { 'uuid':uuid, 'elementId':elementId, 'layerName':layerName, 'sourceUrl':sourceUrl, 'sourceLayers':sourceLayers };
	theProvider.layer.properties = props; 
	stackedProviders.push( theProvider );
	
	return theProvider;
}

/*  ************* METODO ESPECIAl PARA TILE SERVER **************** */

function addLayerXYZ( layerName, url, transparency  ) {
	var layer = {};
	var provider = new Cesium.UrlTemplateImageryProvider({
		url : url,
		credit : 'Ministério da Defesa - SisGeoDef',
		maximumLevel : 18,
		hasAlphaChannel : false,
		enablePickFeatures : false
	});
	provider.defaultAlpha = transparency;
	layer.imageryLayer = viewer.imageryLayers.addImageryProvider( provider ); 
	layer.name = layerName;
	layerStack.push( layer );
	return layer.imageryLayer;
}
function addBaseSystemLayerXYZ( elementId, layerName, url, transparency ) {
	var uuid = createUUID();
	var theProvider = {};
	theProvider.uuid = uuid;
	theProvider.layer = addLayerXYZ( layerName, url, transparency ); 
	var props = { 'uuid':uuid, 'elementId':elementId, 'layerName':layerName, 'sourceUrl':url, 'sourceLayers': 'OpenStreetMap' };
	theProvider.layer.properties = props; 
	stackedProviders.push( theProvider );
	return theProvider;
}



/*  *************************************************************** */
function addBasicLayerToPanel( layerName, theLayer ) {
	var uuid = theLayer.uuid;
	var icon = "baselayer.png";
	var iconImg = "<img style='border:1px solid #cacaca;width:19px;' src='/resources/img/"+icon+"'>";
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="3" class="layerTable">' + iconImg + '&nbsp; <b>Camada Base</b>' +
	'<a title="Apagar Camada" href="#" onClick="deleteLayer(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	'<a title="Para cima das outras" style="margin-right: 10px;" href="#" onClick="layerToUp(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-arrow-circle-up"></i></a>' + 
	'<a title="Para baixo das outras" style="margin-right: 10px;" href="#" onClick="layerToDown(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-arrow-circle-down"></i></a>' + 
	'</td></tr>'; 
	
	table = table + '<tr><td colspan="3" class="layerTable"><b>' + layerName + '</b></td></tr>';
	table = table + '<tr><td colspan="3" class="layerTable">Camada Básica do Sistema</td></tr>';

	table = table + '<tr><td colspan="3" style="padding-left: 15px;padding-right: 15px;padding-top: 3px;padding-bottom: 3px;">'; 
	table = table + '<input id="SL_'+uuid+'" type="text" value="" class="slider form-control" data-slider-min="0" data-slider-max="100"' +
		'data-slider-tooltip="hide" data-slider-step="5" data-slider-value="100" data-slider-id="blue">';
	table = table + '</b></td></tr>';
	
	table = table + '</table></div>';
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#activeLayerContainer").append( layerText );
	jQuery("#layerContainer").show( "slow" );
	
	var count = jQuery('#activeLayerContainer').children().length;
	jQuery("#layersCounter").html( count );	

	jQuery("#SL_"+uuid).bootstrapSlider({});
	jQuery("#SL_"+uuid).on("slide", function(slideEvt) {
		var valu = slideEvt.value / 100;
		doSlider( slideEvt.target.id.substr(3), valu );
	});	
	
	
}





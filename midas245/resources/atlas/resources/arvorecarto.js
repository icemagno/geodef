var theTreeElement = null;
var viewerCatalog = null;
var selectedWMSService = null;

function openCatalogBox(){
	getCatalogTopics();
}

function copyWMSURL(){
	  var copyText = document.getElementById("share-wms");
	  if( copyText.value.length < 5 ) return;
	  copyText.select();
	  copyText.setSelectionRange(0, 99999);
	  document.execCommand("copy");	
	  fireToast( 'info', 'Compartilhar', 'A URL do Geoserviço foi copiada para a área de transferência.' , '000' );
}

function addLayerWMS(){
	if( selectedWMSService === null ) return;
	addLayerCard( selectedWMSService.data );
}

function startCesiumInMiniMap(){
	
	viewerCatalog = new Cesium.Viewer('cesiumCatalogContainer',{
		sceneMode :  Cesium.SceneMode.SCENE2D,
		timeline: false,
		animation: false,
		baseLayerPicker: false,
		skyAtmosphere: false,
		fullscreenButton : false,
		geocoder : false,
		homeButton : false,
		infoBox : false,
		sceneModePicker : false,
		selectionIndicator : false,
		navigationHelpButton : false,
	    imageryProvider: baseOsmProvider,
	});
	
	var west = -80.72;
	var south = -37.16;
	var east = -31.14;
	var north = 11.79;	
	var brasil = Cesium.Rectangle.fromDegrees(west, south, east, north);
	var center = Cesium.Rectangle.center(brasil);
	var initialPosition = Cesium.Cartesian3.fromRadians(center.longitude, center.latitude, 8900000);
	var initialOrientation = new Cesium.HeadingPitchRoll.fromDegrees(0, -90, 0);
	
	viewerCatalog.camera.setView({
	    destination: initialPosition,
	    orientation: initialOrientation,
	    endTransform: Cesium.Matrix4.IDENTITY
	});	
	
	
	var helper = new Cesium.EventHelper();
	helper.add( viewerCatalog.scene.globe.tileLoadProgressEvent, function (event) {
		if (event == 0) {
			$("#catalogMapWaitingIcon").hide();
		} else {
			$("#catalogMapWaitingIcon").show();
		}
	});
	
    $(".cesium-viewer-bottom").hide();
    $(".cesium-viewer-navigationContainer").hide();
    $(".navigation-controls").hide();
	
	
}

function searchTree(){
	
	
    var pattern = $('#searchCatalogTree').val();
    if( pattern.length === 0 ){
    	$(".sourcesTree").treeview('clearSearch');
    	$("#layerSearchResultContainer").hide();
    	$("#layerContainerHolder").show();
    } else {
    	$("#layerSearchResultContainer").empty();
    	
    	$("#layerSearchResultContainer").show();
    	$("#layerContainerHolder").hide();
    	
   		$("#layerSearchResultContainer").append( "<h4>Não Implementado Ainda</h4>" );	
        
    }    
    
}

function getCatalogTopics(){
	
    jQuery.ajax({
		url:"/catalog/topics", 
		type: "GET", 
		success: function( catalogTopics ) {
			
			$('#catalogTreeModal').attr('class', 'modal fade bs-example-modal-lg').attr('aria-labelledby','catalogModalLabel');
			$('#tab_geo').html( getGeoTabContent( catalogTopics ) );
			
			$('#layerContainer').slimScroll({
		        height: '550px',
		        wheelStep : 10,
		    });	
			$('#layerDetailsContainer').slimScroll({
		        height: '210px',
		        wheelStep : 10,
		    });	
			
			$('#catalogTreeModal').modal('show');
			$("#catalogTreeModal").on("hidden.bs.modal", function () {
				viewerCatalog.destroy();
				selectedWMSService = null;
				viewerCatalog = null;
				$("#cesiumCatalogContainer").html('');
			});			
			
			for( x=0; x < catalogTopics.length; x++ ){
				getTopicSources( catalogTopics[x] );
			}
			$('.list-group-item').css({'border-radius':0});
			
			startCesiumInMiniMap();
			
			$("#wmsCopyBtn").click( function(){
				copyWMSURL();
			});
			
			$("#addLayerWMSBtn").click( function(){
				addLayerWMS();
			});
			
			
			$("#searchCatalogTree").keyup(function(){
				searchTree();
			});
			
		},
	    error: function(xhr, textStatus) {
	    	fireToast( 'error', 'Erro Crítico', 'Não foi possível receber o catálogo.', '404' );
	    }, 		
    });
	
}



function getGeoTabContent( catalogTopics ){
	var content = '<div class="row" style="margin: 0px;">' + 
		'<div class="col-md-6" style="padding-right: 5px;padding-left: 0px;">' +
		
		    '<div style="margin-bottom: 0px;" class="box box-widget">'+
		    '<div class="box-header box-header with-border">' +
		    
            '<div class="input-group">'+
            '<input id="searchCatalogTree" type="text" class="form-control">'+
            '<span class="input-group-addon"><i class="fa fa-search"></i></span>'+
            '</div>'+
		    
		    '</div>'+
		    '<div class="box-body"><div id="layerContainerHolder"><div id="layerContainer">'+
					getCatalogTree( catalogTopics ) +	
			'</div></div>'+
		    '<div style="display:none" id="layerSearchResultContainer" class="box-body"></div></div>'+
			'</div>'+
		'</div>' +
		'<div class="col-md-6" style="padding-right: 0px;padding-left: 5px;">' +
			'<div style="margin-bottom: 0px;" class="box box-widget">'+
		    
			'<div class="box-header box-header with-border">'+ 
			'<div id="layerLogoImage" style="display:none;z-index:999;position:absolute;top:2px;left:0px;width:150px;height:50px;"></div>' +
			'<button type="button" class="btn btn-primary pull-right" data-dismiss="modal">Fechar</button></div>'+
		    
		    '<div style="padding: 0px !important;height:250px;border:1px solid #ddd" id="cesiumCatalogContainer" class="box-body">'+
				
			'<div id="catalogMapWaitingIcon" style="display:none;width: 100%;height: 100%; position: absolute;" class="overlay"><i class="fa fa-refresh fa-spin"></i></div></div><div class="box-footer">' + 

			'<div class="pull-left">' +
				'<button id="addLayerWMSBtn" style="margin-right: 5px;" type="button" title="Criar Camada" class="btn btn-default"><i class="fa fa-mail-reply-all"></i></button>' +
			'</div>' +			
			
            '<div style="width:90%; margin:0px; float:right;" >' +
            '<input style="width:90%;float:left;" type="text" class="form-control" placeholder="URL do Geoserviço" id="share-wms">' +
            '<span class="input-group-btn">' +
            	'<button id="wmsCopyBtn" type="button" title="Compartilhar" class="btn btn-default"><i class="fa fa-share-alt"></i></button>' +
			'</span>'+
            '</div>' + 
			
			'</div></div>' + 	
			'<div id="layerDetailsContainer" style="margin-left:10px;margin-right:10px;"></div>'+	
		'</div>' + 
	'</div>';
	return content;
}	


function formatCatalogTopic( topic ){
	var content = '<div class="panel" style="margin-bottom: 0px">' +
	'<div style="padding: 0px;" class="box-header"> '+
		'<button style="text-align: left;" href="#topicTab'+topic.id+'" data-toggle="collapse" data-parent="#layerContainer" type="button" class="btn btn-block btn-primary">'+
			'&nbsp; ' + topic.topicName + 
		'</button>'+
	'</div>'+
	'<div id="topicTab'+topic.id+'" class="panel-collapse collapse">'+
		'<div style="padding: 0px;" class="box-body"><div id="sourcesTree'+topic.id+'" class="sourcesTree"></div></div>'+
	'</div>'+
	'</div>';
	return content;
}


function getChildren( node, treeView ){
	var id = node.data.id;
	node.nodes = [];
	var result = [];
	treeView.treeView().loadTree();
	console.log( node );
	console.log("Get children of " + node.data.id );
	
	
	
	/*
	var totalSources = source.sources.length;
	if ( totalSources == 0 ) return [];
	for( var z=0; z < totalSources; z++ ){
		var ss = source.sources[z];
		var theData = { text: ss.sourceName, nodes:[], tags: [ ss.sources.length ], data : ss };
		if( ss.sourceAddress.length > 20 ) {
			theData.image = '/resources/img/layer.png';
		}
		theData.nodes = getChildren( ss );
		result.push( theData );
	}
	*/
	return result;
}


function getTopicSources( topic ){
	var content = "";
	var treeMainData = [];
	var totalSources = topic.sources.length; 
	
	for( var y=0; y < totalSources; y++ ){
		var source = topic.sources[y];
		var theData = { text: source.sourceName, nodes:[], data : source };

		theData.nodes.push( { text: 'Aguarde...', nodes:[], data : {} } );    
		
		if( source.parentId == null ) treeMainData.push( theData );
	}

	
	if( treeMainData.length > 0 ){
		var theTreeElement = $('#sourcesTree' + topic.id).treeview({
			levels: 1,
			data: treeMainData,
			color: "#3c8dbc",
	        expandIcon: 'glyphicon glyphicon glyphicon-folder-close',
	        collapseIcon: 'glyphicon glyphicon glyphicon-folder-open',			
			showTags: false,	
			showImage: true,
	        multiSelect: false,
	        onNodeSelected: function(event, node) {
	        	$("#layerDetailsContainer").text( node.data.description );
	        	
	        	var logoImage = node.data.sourceLogo;
	        	$("#layerLogoImage").html('');
	        	$("#layerLogoImage").hide();
	        	if( logoImage ){
	        		var logoImg = "<img style='width:150px;height:50px;border:1px solid #ddd' src='"+ logoImage + "'>";
	        		$("#layerLogoImage").html( logoImg );
	        		$("#layerLogoImage").show();
	        	}
	        	
	        	
	        	if( node.data.sourceAddress.length > 10 ){
	        		previewLayer( node.data );
	        	}
	        },
	        onNodeUnselected: function (event, node) {
	        	$("#layerDetailsContainer").text('');
	        },
	        onNodeCollapsed: function(event, node) {
	        	$("#layerDetailsContainer").text('');
	        },
	        onNodeExpanded: function (event, node) {
	        	$("#layerDetailsContainer").text( node.data.description );
	        	getChildren( node, this );
	        }	        
		});
		
		//$('#sourcesTree' + topic.id).treeview('collapseAll', {});
		theTreeElement.treeview('collapseAll', {  });
		
	}
	
}


function previewLayer( data ){
	selectedWMSService = null;
	
	var cqlFilter = "";
	if( data.cqlFilter ) cqlFilter = "&cql_filter=" + data.cqlFilter;
	
	$("#share-wms").val( data.sourceAddress + "?SERVICE=WMS&REQUEST=GetMap&VERSION=1.1.0&&STYLES=&LAYERS=" + data.sourceLayer + 
			"&SRS=EPSG:4326&BBOX=-180,-90,180,90&width=800&height=400&tiled=true&format=image/png&transparent=true" + cqlFilter );
	
	var provider = getProvider( data.sourceAddress, data.sourceLayer, false, 'png', true );
	if( provider ){
		var layers = viewerCatalog.imageryLayers;
		if( layers.length > 1 ){
			layers.remove( layers.get(1) );
		}
		var imageryLayer = layers.addImageryProvider( provider, 1 );
		selectedWMSService = { data : data, layer : imageryLayer };
	} else {
		console.log('Erro ao carregar o preview da camada');
	}
	
}

function getCatalogTree( catalogTopics ){
	var content = "";
	for( x=0; x<catalogTopics.length;x++ ){
		content = content + formatCatalogTopic( catalogTopics[x] )
	}
	return content;
}


/***
 * 
 * 		OLD CODE BELOW !!!
 * 
 * 
 */



function addLayerFromTree( layerName, workspace, scale, layerAlias, server, imageType ) {
	 addToPanelLayer( layerName, workspace, scale, layerAlias, server, imageType );
}

function getTreeData( obj ){
	var treeMainData = [];
	var terrestre = obj.terrestre;
	var nautica = obj.nautica;
	var aeronautica = obj.aeronautica;

	var edgvFontes = {text: "EDGV-DEFESA", nodes:[]}
	var outrasFontes = {text: "Outras Fontes ou Padrões", nodes:[] };
	
	// Outras fontes - Marinha
	var marinha = {text: "Marinha", nodes:[] };	
	var carta1 = 'Carta Náutica 22900' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'carta22900\',\'\',\'SCALE_ALL\',\'Carta Náutica 22900\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	marinha.nodes.push( { text : carta1, icon: 'fa fa-angle-right' } );

	var carta2 = 'Carta Náutica 23000' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'carta23000\',\'\',\'SCALE_ALL\',\'Carta Náutica 23000\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	marinha.nodes.push( { text : carta2, icon: 'fa fa-angle-right' } );
	
	var carta3 = 'Carta Náutica 23100' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'carta23100\',\'\',\'SCALE_ALL\',\'Carta Náutica 23100\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	marinha.nodes.push( { text : carta3, icon: 'fa fa-angle-right' } );

	var carta4 = 'Carta Náutica 1501' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'carta1501\',\'\',\'SCALE_ALL\',\'Carta Náutica 1501\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	marinha.nodes.push( { text : carta4, icon: 'fa fa-angle-right' } );
	
	var carta4 = 'Carta Náutica 1550' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'carta1550\',\'\',\'SCALE_ALL\',\'Carta Náutica 1550\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	marinha.nodes.push( { text : carta4, icon: 'fa fa-angle-right' } );
	
	outrasFontes.nodes.push( marinha );
	
	// Outras Fontes - Exercito
	var exercito = {text: "Exército", nodes:[] };
	var bdgex1 = 'Esp Planialt. Baia de Guanabara' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'carta\',\'volcano\',\'25000\',\'ESP PLANIALT BAIA DE GUANABARA\',\''+pleione+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	exercito.nodes.push( { text : bdgex1, icon: 'fa fa-angle-right' } );
	outrasFontes.nodes.push( exercito );
	
	// Outras fontes - Aeronautica
	var fab = {text: "Aeronáutica", nodes:[] };
	var cartaica1 = 'Cartas de Área: Macaé' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'icamacae\',\'\',\'SCALE_ALL\',\'Cartas de Área: Macaé\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	fab.nodes.push( { text : cartaica1, icon: 'fa fa-angle-right' } );

	var cartaica2 = 'Cartas Visuais WAC BH' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'icabh\',\'\',\'SCALE_ALL\',\'Cartas Visuais WAC BH\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	fab.nodes.push( { text : cartaica2, icon: 'fa fa-angle-right' } );
	
	var cartaica3 = 'Cartas de Rotas: L2' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'ical2\',\'\',\'SCALE_ALL\',\'Cartas de Rotas: L2\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	fab.nodes.push( { text : cartaica3, icon: 'fa fa-angle-right' } );

	var cartaica4 = 'Cartas de Rotas: H2' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
	'onClick="addLayerFromTree(\'icah2\',\'\',\'SCALE_ALL\',\'Cartas de Rotas: H2\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
	fab.nodes.push( { text : cartaica4, icon: 'fa fa-angle-right' } );

	outrasFontes.nodes.push( fab );
	
	var emcfaNodes = [];
	var apoloNodes = [];
	emcfaNodes.push( {text: "Sistema APOLO", nodes:apoloNodes } );

	// Camadas APOLO
	apoloNodes.push( { text :'Un. de Conservação Nac.' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'apolomma\',\'\',\'SCALE_ALL\',\'MMA: Un. de Conservação Nacional\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	apoloNodes.push( { text :'SISCLATEN: Proj. Encerrados' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'sisclaten01\',\'\',\'SCALE_ALL\',\'SISCLATEN: Projetos Encerrados\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	apoloNodes.push( { text :'DNIT: Pontes' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'apolodnit\',\'\',\'SCALE_ALL\',\'DNIT: Pontes\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	apoloNodes.push( { text :'ONS: Linhas de Transmissão' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'apololinhas\',\'\',\'SCALE_ALL\',\'ONS: Linhas de Transmissão\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	apoloNodes.push( { text :'ENEEL: Usinas de Energia' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'apolousinas\',\'\',\'SCALE_ALL\',\'ENEEL: Usinas de Energia\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	apoloNodes.push( { text :'Amazônia Azul' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'amazoniaazul\',\'\',\'SCALE_ALL\',\'ENEEL: Usinas de Energia\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	apoloNodes.push( { text :'Organizações Militares' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'apoloorgmil\',\'\',\'SCALE_ALL\',\'Organizações Militares\',\''+mapproxy+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );


	outrasFontes.nodes.push( {text: "EMCFA", nodes:emcfaNodes } );
	outrasFontes.nodes.push( {text: "CENSIPAM", nodes:[] } );


	var inpeNodes = [];
	outrasFontes.nodes.push( {text: "INPE", nodes:inpeNodes } );
	
	var dgiNodes = [];
	inpeNodes.push( {text: "DGI", nodes:dgiNodes } );
	
	dgiNodes.push( { text :'Vento Calculado' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'terrama2_54:view54\',\'\',\'SCALE_ALL\',\'INPE/DGI Vento Calculado\',\''+bdqueimadas+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	
	dgiNodes.push( { text :'Velocidade do Vento (m/s)' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'terrama2_48:view48\',\'\',\'SCALE_ALL\',\'INPE/DGI Velocidade do Vento (m/s)\',\''+bdqueimadas+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );

	
	dgiNodes.push( { text :'Precipitação' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'terrama2_38:view38\',\'\',\'SCALE_ALL\',\'INPE/DGI Precipitação (mm)\',\''+bdqueimadas+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	dgiNodes.push( { text :'Temperatura' + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
		'onClick="addLayerFromTree(\'terrama2_36:view36\',\'\',\'SCALE_ALL\',\'INPE/DGI Temperatura (C)\',\''+bdqueimadas+'\',\'png\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>', 
		icon: 'fa fa-angle-right' } );
	
	
	
	
	// EDGV-DEFESA
	var terrestreRoot = {text: "Cartografia Terrestre"}
	var nauticaRoot = {text: "Cartografia Náutica"}
	var aeronauticaRoot = {text: "Cartografia Aeronáutica"}

	
	// Cartografia terrestre
	var terrestreCategs = [];
	for( x=0; x<terrestre.length; x++ ) {
		var categs = terrestre[x];
		var categName = categs.categoria;
		var classes = categs.classes;
		
		// Terrestre
		var terrestreCateg = {text: categName };
		var camadas = [];
		for( y=0; y<classes.length; y++  ) {
			var classe = classes[y];
			var aLayer = {text: classe.nome, workspace:classe.workspace, nodes:[]};
			var layers = classe.layers; 
			var workspace = classe.workspace;
			
			for(z=0; z<layers.length;z++){
				var layerName = layers[z].layer;
				var scaleValues = layers[z].escalas;
				var layerType = "";
				if( layerName.endsWith("_a") ) layerType = "Área";
				if( layerName.endsWith("_l") ) layerType = "Linha";
				if( layerName.endsWith("_p") ) layerType = "Ponto";
				var controlData = { layerName:layerName, workspace:workspace  };
				var escalas = [ ];
				
				var teste = 'Todas <a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
				'onClick="addLayerFromTree(\''+layerName+'\',\''+workspace+'\',\'SCALE_ALL\',\''+classe.nome+'\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
				escalas.push( { text : teste, icon: 'fa fa-angle-right', data : controlData } );
				
				for( t=0; t<scaleValues.length;t++ ) {
					controlData.escala = scaleValues[t];
					// layerName, workspace, scale, layerAlias
					
					var teste = '1:' + scaleValues[t] + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
					'onClick="addLayerFromTree(\''+layerName+'\',\''+workspace+'\',\''+controlData.escala+'\',\''+classe.nome+'\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
					escalas.push( { text : teste, icon: 'fa fa-angle-right', data : controlData } );
				}
				aLayer.nodes.push( {text : layerType, data : controlData, nodes:escalas} );
			}
			
			camadas.push( aLayer );
		}
		terrestreCateg.nodes = camadas;
		terrestreCategs.push( terrestreCateg );
	}
	terrestreRoot.nodes = terrestreCategs; 

	// Cartografia Nautica
	var nauticaClases = [];
	for( x=0; x<nautica.length; x++ ) {
		var classe = nautica[x];
		var aLayer = {text: classe.nome, workspace:classe.workspace, nodes:[]};
		var layers = classe.layers; 
		var workspace = classe.workspace;
		for(z=0; z<layers.length;z++){
			var layerName = layers[z].layer;
			var scaleValues = layers[z].escalas;
			var controlData = { layerName:layerName, workspace:workspace  };
			
			var teste = 'Todas <a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
			'onClick="addLayerFromTree(\''+layerName+'\',\''+workspace+'\',\'SCALE_ALL\',\''+classe.nome+'\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
			aLayer.nodes.push( { text : teste, icon: 'fa fa-angle-right', data : controlData } );
			
			
			for( t=0; t<scaleValues.length;t++ ) {
				controlData.escala = scaleValues[t];
				var teste = '1:' + scaleValues[t] + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
				'onClick="addLayerFromTree(\''+layerName+'\',\''+workspace+'\',\''+controlData.escala+'\',\''+classe.nome+'\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
				aLayer.nodes.push( { text : teste, icon: 'fa fa-angle-right', data : controlData } );
			}
		}
		nauticaClases.push( aLayer );
	}
	nauticaRoot.nodes = nauticaClases;
	
	// Cartografia aeronautica
	var aeronauticaClases = [];
	for( x=0; x<aeronautica.length; x++ ) {
		var classe = aeronautica[x];
		var aLayer = {text: classe.nome, workspace:classe.workspace, nodes:[]};
		var layers = classe.layers; 
		var workspace = classe.workspace;
		for(z=0; z<layers.length;z++){
			var layerName = layers[z].layer;
			var scaleValues = layers[z].escalas;
			var controlData = { layerName:layerName, workspace:workspace  };

			var teste = 'Todas <a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
			'onClick="addLayerFromTree(\''+layerName+'\',\''+workspace+'\',\'SCALE_ALL\',\''+classe.nome+'\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
			aLayer.nodes.push( { text : teste, icon: 'fa fa-angle-right', data : controlData } );
			
			
			for( t=0; t<scaleValues.length;t++ ) {
				controlData.escala = scaleValues[t];
				var teste = '1:' + scaleValues[t] + '<a class="text-red pull-right" title="Adicionar ao Mapa" href="#" '+
				'onClick="addLayerFromTree(\''+layerName+'\',\''+workspace+'\',\''+controlData.escala+'\',\''+classe.nome+'\');" ><i style="margin-right: 7px;" class="fa fa-external-link-square"></i></a>';
				aLayer.nodes.push( { text : teste, icon: 'fa fa-angle-right', data : controlData } );
			}
			
		}
		aeronauticaClases.push( aLayer );
	}
	aeronauticaRoot.nodes = aeronauticaClases;
	
	edgvFontes.nodes.push( terrestreRoot );
	edgvFontes.nodes.push( nauticaRoot );
	edgvFontes.nodes.push( aeronauticaRoot );
	
	treeMainData.push( edgvFontes );
	treeMainData.push( outrasFontes );
	
	return treeMainData;
	
}


function loadCarto( ) {
	var url = "/cartografia/tree";
	$.ajax({
		url: url,
		type: "GET", 
		success: function( obj ) {
			
			theTreeElement = jQuery('#treeview-terrestre').treeview({
				data: getTreeData( obj ),
	            multiSelect: false,
	            onNodeSelected: function(event, node) {
	            	//console.log("Select:");
	            	//console.log( node );
	            },
	            onNodeUnselected: function (event, node) {
	            	//console.log("Unselect:");
	            	//console.log( node );
	            }				
			});
			
			jQuery('.list-group-item').css({'border-radius':0});
			theTreeElement.treeview('collapseAll', {  });
			
		},
		error: function(xhr, textStatus) {
			//
		}, 		
	});
}

function startCartoTree() {
	loadCarto();
	jQuery('#layerNameFinder').css({'font-size':12,'height':25});
}





var theTreeElement = null;

function openCatalogBox(){
	getCatalogTopics();
}


function getCatalogTopics(){
	
    jQuery.ajax({
		url:"/catalog/topics", 
		type: "GET", 
		success: function( catalogTopics ) {
			
			console.log( catalogTopics );
			
			
			jQuery('#catalogTreeModal').attr('class', 'modal fade bs-example-modal-lg').attr('aria-labelledby','catalogModalLabel');
			$('#tab_geo').html( getGeoTabContent( catalogTopics ) );
			$('#tab_upload').html('<b>Não implementado ainda.</b>');
			
			jQuery('#layerContainer').slimScroll({
		        height: '450px',
		        wheelStep : 10,
		    });	
			jQuery('#layerDetailsContainer').slimScroll({
		        height: '230px',
		        wheelStep : 10,
		    });	
			
			jQuery('#catalogTreeModal').modal('show');
			
			
			for( x=0; x < catalogTopics.length; x++ ){
				getTopicSources( catalogTopics[x] );
			}
			$('.list-group-item').css({'border-radius':0});
			
			
		},
	    error: function(xhr, textStatus) {
	    	fireToast( 'error', 'Erro Crítico', 'Não foi possível receber o catálogo.', '404' );
	    }, 		
    });
	
}



function getGeoTabContent( catalogTopics ){
	var content = '<div class="row">' + 
		'<div class="col-md-6" style="border-right: 1px solid #f4f4f4;padding-right: 5px;padding-left: 0px;">' +
			'<div id="layerContainer">' + 
			
				getCatalogTree( catalogTopics ) +	
				
			'</div>'+	
		'</div>' +
		'<div class="col-md-6" style="padding-right: 0px;padding-left: 5px;">' +
			'<div style="margin-bottom: 10px;" class="box box-widget"><div class="box-body">'+
				'<img style="width:100%" src="http://sisgeodef.defesa.mil.br:36203/atlas/map-teste.jpg">' +
			'</div></div>' + 	
			'<div id="layerDetailsContainer">' + 
				'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget magna tempor, accumsan quam at, egestas massa. Interdum et malesuada fames ac ante ipsum primis in faucibus. Cras semper rutrum turpis, quis convallis tortor mollis eget. Mauris consectetur commodo quam, et blandit justo dapibus nec. Vivamus euismod, dolor nec tincidunt volutpat, felis metus imperdiet velit, nec tempus leo felis euismod lorem. Donec vel aliquam eros. Etiam consequat metus id mi pulvinar, sed egestas elit efficitur. In lobortis purus vitae leo sollicitudin fermentum. Nulla quis diam eget enim ultricies gravida. Fusce iaculis fermentum volutpat. Curabitur mattis diam bibendum diam sodales, tempus rutrum neque interdum.' + 
				'Phasellus ac euismod nisl. Vivamus tincidunt quam sed auctor rhoncus. Praesent nec massa sollicitudin, porttitor neque eu, viverra justo. Praesent libero nunc, dapibus nec diam a, mollis molestie leo. Pellentesque sem mauris, aliquet sit amet cursus sed, accumsan id ante. Duis dolor sem, rhoncus eu porttitor a, facilisis at sem. Curabitur dolor lectus, malesuada ac mattis vitae, accumsan vitae velit.' + 
				'Suspendisse accumsan, purus nec convallis dignissim, neque purus lobortis dolor, et pulvinar erat turpis id sapien. Mauris et nisi magna. Nam eleifend metus vitae ligula vulputate tristique. Pellentesque sollicitudin vulputate nisl, eu cursus elit cursus fermentum. Etiam dui arcu, rhoncus at facilisis at, vestibulum vitae lacus. Maecenas euismod lacus odio, quis rutrum velit porttitor sed. Aenean ut orci tempus, pharetra lectus ac, placerat nunc. Etiam pulvinar et elit placerat varius. Cras sed quam eu eros malesuada pharetra quis eu augue. Pellentesque interdum consequat lacus id scelerisque. Aliquam vulputate tempor mauris sit amet tincidunt. Praesent fringilla, justo sed euismod accumsan, mauris mi bibendum magna, in bibendum erat ante eget tortor. Donec egestas pretium ullamcorper. Nam facilisis massa massa, in imperdiet turpis vehicula non.' + 
			'</div>'+	
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
		'<div style="padding: 0px; border:1px solid #f4f4f4; height: 340px" class="box-body"><div id="sourcesTree'+topic.id+'" class=""></div></div>'+
	'</div>'+
	'</div>';
	return content;
}


function getTopicSources( topic ){
	var content = "";
	var treeMainData = [];
	var totalSources = topic.sources.length; 
	
	
	for( var y=0; y < totalSources; y++ ){
		var source = topic.sources[x];
		treeMainData.push( { text: source.sourceName, nodes:[] } );
	}

	if( treeMainData.length > 0 ){
		var theTreeElement = $('#sourcesTree' + topic.id).treeview({
			data: treeMainData,
			color: "#3c8dbc",
	        expandIcon: 'glyphicon glyphicon glyphicon-folder-close',
	        collapseIcon: 'glyphicon glyphicon glyphicon-folder-open',			
			showTags: true,			
	        multiSelect: false,
	        onNodeSelected: function(event, node) {
	        	//
	        },
	        onNodeUnselected: function (event, node) {
	        	//
	        },
	        onNodeCollapsed: function(event, node) {
	        	console.log("Collapse:");
	        	console.log( node );
	        },
	        onNodeExpanded: function (event, node) {
	        	console.log("Expand:");
	        	console.log( node );
	        }	        
		});
		theTreeElement.treeview('collapseAll', {  });
		
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
	jQuery.ajax({
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





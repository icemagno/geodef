var theTreeElement = null;


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





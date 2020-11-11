
var qtdQueryResult = 0;

function showFeaturesData( featureCollection, stackedProvider ){
	var layerName = stackedProvider.data.sourceName;
	var sourceLogo = stackedProvider.data.sourceLogo;
	var features = featureCollection.features;
	var uuid = "QL-" + createUUID();
	
	if( features.length == 0 ) return;

	qtdQueryResult++;
	$("#qtdQueryResult").text( qtdQueryResult );
	
	
	var baseFeature = features[0];
	var properties = baseFeature.properties;

	var table = '<table id="'+uuid+'" class="table table-bordered table-hover"><thead><tr>'; 

	for ( var [key, value] of Object.entries( properties ) ) {
	    table = table + '<th>'+ key +'</th>'; 
	}		
	
	table = table + '</tr></thead><tbody>';
	
	for( x=0; x < features.length; x++ ) {
		var feature = features[x];
		var properties = feature.properties;
		table = table + '<tr>';
		for ( var [key, value] of Object.entries( properties ) ) {
			if( !value || value == 'null ') value = '&nbsp;';
			table = table + '<td>'+value+'</td>';
		}
		table = table + '</tr>';
	}

	table = table + '</tbody></table>';
	
	$("#queryResultBody").append( table ) ;
	
	$('#' + uuid).DataTable({
		 'responsive'  : false,
		 'searching'   : false,
		 'autoWidth'   : false,
    	 'destroy'     : true,
         'scrollY'     : 150,
         'scrollX'     : true,
         'ordering'    : false,
         'paging'      : false,
         'dom': '<"top"i>rt<"bottom"><"clear">',
		 language: {
		    searchPlaceholder: "Localizar",
		    search: "_INPUT_",
		    paginate: {
		        first:    '«',
		        previous: '‹',
		        next:     '›',
		        last:     '»'
		    },
		    emptyTable: "Nenhum Registro Encontrado",
		    zeroRecords: "Nenhum Registro Encontrado",
		    infoEmpty: "Sem registros",
		    infoFiltered: " - filtrado de _MAX_ records",
		    aria: {
		        paginate: {
		            first:    'Primeiro',
		            previous: 'Anterior',
		            next:     'Próximo',
		            last:     'Último'
		        }
		    }    		        
		    
		 }    			
	});
	
	$("#" + uuid + "_info").html("<b>" + layerName + "</b>" );
}

function showQueryResultContainer(){
	qtdQueryResult = 0;
	 
	$("body").addClass("sidebar-collapse");

	$("#queryResultContainer").remove();
	
	var queryResultContainer = '<div id="queryResultContainer" style="width: 75%; position: absolute; bottom: 10px; height: 320px; right: 230px;" class="box box-info">' +
    '<div class="box-header with-border">'+
    '<h3 class="box-title"><span id="qtdQueryResult">0</span> Camadas Encontradas</h3><div class="box-tools pull-right">' +
    '<button type="button" title="Fechar" id="queryResultCloseBtn" class="btn"><i style="font-size: 18px;" class="fa fa-times"></i></button>' +
    '</div></div><div style="padding: 0px;font-size: 10px; font-family: Consolas;" id="queryResultBody" class="box-body"></div></div>';	
	
	$("#cesiumContainer").append( queryResultContainer ) ;
	
    $("#queryResultCloseBtn").click( function(){
    	$("#queryResultContainer").remove();	
    });
    
	$("#queryResultBody").slimScroll({
        height: '230px',
        wheelStep : 10,
    });
    
	
}
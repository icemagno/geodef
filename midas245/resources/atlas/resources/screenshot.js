var imageScreenCount = 0;


function saveImage( uuid ) {
	var name = 'sisgide-imagem-' + imageScreenCount + '.png';
	imageScreenCount++;	
	var dataURL = jQuery("#pict" + uuid).attr('src');
	
	jQuery.ajax({
		type: "POST",
		url: "/saveimage",
		data: {
			imgBase64: dataURL,
			imgName : name
		}
	}).done(function(o) {
		showToast('Imagem Enviada ao Servidor', 'info', 'Concluído');
	});
}


function downloadImage( uuid ) {
	
	var uri = jQuery("#pict" + uuid).attr('src');
	var name = 'sisgide-imagem-' + imageScreenCount + '.png';
	imageScreenCount++;
	
	uri = uri.replace(/^data:image\/[^;]/, 'data:application/octet-stream');
	
    var link = document.createElement('a');
    if (typeof link.download === 'string') {
        document.body.appendChild(link); // Firefox requires the link to be in the body
        link.download = name;
        link.href = uri;
        link.click();
        document.body.removeChild(link); // remove the link when done
    } else {
        location.replace(uri);
    }	
}
function deleteImage( uuid ) {
	jQuery("#" + uuid).fadeOut(400, function(){
		jQuery("#" + uuid).remove();
		var count = jQuery('#exportedProductsContainer').children().length;
		if ( count === 0 ) { jQuery("#exportedCounter").html( '' ); } else { jQuery("#exportedCounter").html( count ); }
	});			
}
function screenShot() {
	var uuid = createUUID();
	var date = new Date(Date.now()).toLocaleString('pt-BR');
	
	var table = '<div class="table-responsive"><table class="table" style="margin-bottom: 0px;width:100%">' + 
	'<tr style="border-bottom:2px solid #3c8dbc"><td colspan="2" class="layerTable"><i class="fa fa-camera"></i> &nbsp; <b>Foto de Tela</b></td>' +
	'<td class="layerTable" style="text-align: right;">' + 
	
	'<a title="Apagar Imagem" href="#" onClick="deleteImage(\''+uuid+'\');" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>' + 
	//'<a title="Fazer Download da Imagem" style="margin-right: 15px;" href="#" onClick="downloadImage(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-download"></i></a>' + 
	'<a title="Salvar no Servidor" style="margin-right: 15px;" href="#" onClick="saveImage(\''+uuid+'\');" class="text-light-blue pull-right"><i class="fa fa-save"></i></a>' +
	
	'</td></tr>'; 
	
	table = table + '<tr><td class="layerTable">Data/Hora</td>'+
	'<td colspan="2" class="layerTable" style="text-align: right;">'+date+'</td></tr>';	
	
	table = table + '<tr><td colspan="3" class="layerTable" style="text-align: right;"><img src="#" style="border:1px solid #3c8dbc;width:100%;height:110px" id="pict' + uuid + '"></td></tr>';
	
	table = table + '</table></div>';
	
	var layerText = '<div id="'+uuid+'" style="margin-bottom: 5px;border: 1px solid #cacaca;" ><div class="box-body">' +
	table + '</div></div>';

	jQuery("#exportedProductsContainer").append( layerText );
	jQuery("#layerContainer").show( "slow" );
		
	
	var count = jQuery('#exportedProductsContainer').children().length;
	jQuery("#exportedCounter").html( count );
	
	
	var promise =  scene.outputSceneToFile();
	Cesium.when(promise,function(base64data){
		jQuery("#pict" + uuid ).attr("src", base64data );
	});	
	
	
	
	/*
	showToast('Preparando Imagem...', 'info', 'Aguarde');

	var prepareScreenshot = function () {
		scene.preRender.removeEventListener(prepareScreenshot);
		setTimeout(function () {
			scene.postRender.addEventListener(takeScreenshot);
		}, timeout);
	};

	var takeScreenshot = function () {

		scene.postRender.removeEventListener(takeScreenshot);
		var canvas = scene.canvas;
		canvas.toBlob(function (blob) {
			var url = URL.createObjectURL(blob);
			downloadURI(url, "sisgide-mapa.png");
		});
	};

	function downloadURI(uri, name) {
		var link = document.createElement("a");
		link.download = name;
		link.href = uri;
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
		delete link;
	}

	prepareScreenshot();
	*/
}




function exportToPdf( data ) {
	
	var legendFiles = [];
	
	$(".feature-legend").each( function(index){
		var url = this.id.substr(4).replaceAll('-','');
		var filename = url.split('/').pop() + '.png';
		legendFiles.push( filename );
	}); 
	
	$(".legendImage").each( function(index){
		var url = this.src;
		var filename = url.split('/').pop();
		legendFiles.push( filename );
	});
	
	jQuery.ajax({
		type: "POST",
		url: "/createchart", // ou saveimage
		data: {
			'imgBase64': data,
			'legends' : JSON.stringify( legendFiles )
		},
		success: function( url ) {
			if( url ) window.open(url);
		}
	}).done(function(o) {
		//
	});
}

function screenShot() {

	var prepareScreenshot = function () {
		scene.preRender.removeEventListener(prepareScreenshot);
		setTimeout(function () {
			scene.postRender.addEventListener(takeScreenshot);
		}, timeout);
	};

	var takeScreenshot = function () {

		scene.postRender.removeEventListener(takeScreenshot);
		var canvas = scene.canvas;
		
		var dataURL = canvas.toDataURL();
		exportToPdf( dataURL );	
		
		/*
		canvas.toBlob(function (blob) {
			var url = URL.createObjectURL(blob);
			downloadURI(url, "sisgide-mapa.png");
		});
		*/
	};

	/*
	function downloadURI(uri, name) {
		var link = document.createElement("a");
		link.download = name;
		link.href = uri;
		document.body.appendChild(link);
		link.click();
		document.body.removeChild(link);
		delete link;
	}
	*/
	
	prepareScreenshot();
	
	fireToast( 'info', 'Aguarde...', 'A imagem ficará pronta em alguns segundos.', '' );
	
}


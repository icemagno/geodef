const Toast = Swal.mixin({
	  toast: true,
	  position: 'top-end',
	  showConfirmButton: false,
	  width: 320,
	  timer: 7000,	  
	  timerProgressBar: true,
	  onOpen: (toast) => {
	    toast.addEventListener('mouseenter', Swal.stopTimer)
	    toast.addEventListener('mouseleave', Swal.resumeTimer)
	  }
});


// https://sweetalert2.github.io/#examples
// ICONS: success error warning info question

function fireToast( icon, title, text, errorCode ){

	
	
	// Vou encaminhar para o metodo antigo,
	// pois ele empilha os cards dos avisos sem perder o anterior.
	
	//showToast( text, icon, title );

	Toast.fire({
		title: title,
		text: text,
		icon: icon,
		footer: 'SisGEODEF',
	});
	

}


// Metodo antigo: empilha os avisos.

function showToast(html, toastType, heading) {
	if (!heading) {
		switch (toastType) {
		case "success":
			heading = 'Sucesso';
			break;
		case "info":
			heading = 'Informação';
			break;
		case "error":
			heading = 'Erro';
			break;
		case "warning":
			heading = 'Atenção';
			break;
		}
	}

	jQuery.toast({
		heading: heading,
		text: html,
		icon: toastType,
		showHideTransition: 'slide',
		position: 'bottom-right',
		hideAfter: 5000,
		loader: true
	});
};

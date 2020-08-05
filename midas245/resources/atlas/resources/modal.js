function setModalBox(title,content,footer,jQuerysize){
	document.getElementById('modal-bodyku').innerHTML=content;
	document.getElementById('myModalLabel').innerHTML=title;
	document.getElementById('modal-footerq').innerHTML=footer;
	
	if(jQuerysize == 'large') {
		jQuery('#myModal').attr('class', 'modal fade bs-example-modal-lg')
		.attr('aria-labelledby','myLargeModalLabel');
		jQuery('.modal-dialog').attr('class','modal-dialog modal-lg');
	}
	if(jQuerysize == 'standart')	{
		jQuery('#myModal').attr('class', 'modal fade')
		.attr('aria-labelledby','myModalLabel');
		jQuery('.modal-dialog').attr('class','modal-dialog');
	} 
	if( jQuerysize == 'small' )	{
		jQuery('#myModal').attr('class', 'modal fade bs-example-modal-sm')
		.attr('aria-labelledby','mySmallModalLabel');
		jQuery('.modal-dialog').attr('class','modal-dialog modal-sm');
	}
	
	jQuery('#myModal').modal('show');
}
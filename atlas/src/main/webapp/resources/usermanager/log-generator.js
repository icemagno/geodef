
function getLogDate( log ) {
	var logDate = '<li class="time-label"><span class="bg-red">' + log.data + '</span></li>';
	return logDate;
}

function getLogBody( log ) {
	var btnType= 'btn-success'; // GET
	if( log.method === 'POST' ) btnType = 'btn-primary';
	if( log.method === 'PUT' ) btnType = 'btn-warning';
	if( log.method === 'DELETE' ) btnType = 'btn-danger';
	
	if ( !log.queryString  ) log.queryString = '';
	
	var logBody = '<span class="time"><i class="fa fa-clock-o"></i> '+ log.hora +'</span>' +
    	'<h3 class="timeline-header">' + 
			'<a class="btn '+btnType+' btn-xs">'+log.method+'</a> &nbsp; '+ 
			'<a class="btn btn-primary btn-xs"><i class="fa fa-tv"></i> &nbsp;'+
				log.remoteHost +
			'</a>' +
		'</h3>' + 	
    	'<div class="timeline-body">'+
    	log.requestUrl  +
    	'<p class="text-green">' + log.queryString.replace(/&/g, '& ') + '</p>' +
    	 
    	'</br></div>';
	return logBody;
}


function getLogItem( log, fotoServer ) {
	var remoteUserId = log.remoteUserId;
	var remoteUserName = log.remoteUserName;
	var userLink = "user/"+remoteUserId;
	
	if( remoteUserName === '{}') {
		remoteUserName = 'Aplicativo'
	}
	
	if( !remoteUserName ) {
		remoteUserName = "&nbsp;";
	}

	var icon = "fa-user";
	var iconColor = "btn-success";
	
	var logType = log.accessType;
	if( logType === 'UNKNOWN') { 
		icon = 'fa-unlock-alt';
		iconColor = "btn-default";
		userLink = "#";
	}
	if( logType === 'SYSTEM') {
		icon = 'fa-cog';
		iconColor = "btn-warning";
		userLink = "#";
	}
	
	var symbolImage = "<i class='fa "+icon+"'></i>";
	
	var logItem = '<li><i class="fa fa-key bg-blue"></i><div class="timeline-item">' +
    	getLogBody( log ) + 
    		'<div class="timeline-footer">' +
    			'<div class="user-block">' + 
    				'<img class="img-circle img-bordered-sm" src="' + fotoServer + log.profileImage + '" alt="user image">' +
    				'<span class="username"><a class="btn '+iconColor+' btn-xs" href="'+userLink+'">' + symbolImage + ' &nbsp; ' + log.remoteUser.toUpperCase() + '</a></span><span class="description">'+remoteUserName+'</span>' + 
	    		'</div>' +	
    		'</div>' +
    	'</div></li>';	
	return logItem;
}

function getLogListFooter() {
    return '<li><i class="fa fa-clock-o bg-gray"></i></li>';
}
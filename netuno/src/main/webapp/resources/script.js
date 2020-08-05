var ws = null;

function connect() {
    var socket = new SockJS('/ws');
    var stompClient = Stomp.over(socket);
    
    stompClient.debug = null;
	stompClient.connect({}, function(frame) {
		
		stompClient.subscribe('/queue/notify', function(notification) {
			addMenu( JSON.parse( notification.body ) );
		});
		
		
	});    
    
}

function removeMenu( data ) {
	var notifications = data.notifications;
	// Apos adicionar os que chegaram, remove os que sairam
}


function addMenu( data ) {
	var notifications = data.notifications;
	$('#solucion-menu').empty();
	
	$('#solucion-count').html( '<small class="label pull-right bg-red">'+notifications.length+'</small>' );
	
	for( var x=0; x < notifications.length; x++  ) {
		var notification = notifications[x];
		var name = notification.name;
		var id = notification.id;
		var isNew = notification.newData;
		
		var newText = "";
		if ( isNew ) {
			newText = '<span class="pull-right-container"><small class="label pull-right bg-green">NOVO</small></span>';
		}
		var li = '<li><a href="#"><i class="fa fa-crosshairs"></i><span>' + name + '</span>'+newText+'</a></li>';
		
		console.log( notification );
		$("#solucion-menu").append( li );	
	}
	
	removeMenu( data );
}

connect();
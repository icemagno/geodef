//Elements for taking the snapshot
var canvas = document.getElementById('canvas');
var context = canvas.getContext('2d');
var video = document.getElementById('video');

function save( dataURL ) {
	jQuery.ajax({
		type: "POST",
		url: "/saveimage",
		data: {
			imgBase64: dataURL
		}
	}).done(function(o) {
		console.log('saved');
		// If you want the file to be visible in the browser
		// - please modify the callback in javascript. All you
		// need is to return the url to the file, you just saved
		// and than put the image in your browser.
	});
}


//Grab elements, create settings, etc.
var video = document.getElementById('video');

//Get access to the camera!
if(navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
//	Not adding `{ audio: true }` since we only want video now
	navigator.mediaDevices.getUserMedia({ video: true }).then(function(stream) {
//		video.src = window.URL.createObjectURL(stream);
		video.srcObject = stream;
		video.play();
	});
}

/* Legacy code below: getUserMedia
else if(navigator.getUserMedia) { // Standard
navigator.getUserMedia({ video: true }, function(stream) {
video.src = stream;
video.play();
}, errBack);
} else if(navigator.webkitGetUserMedia) { // WebKit-prefixed
navigator.webkitGetUserMedia({ video: true }, function(stream){
video.src = window.webkitURL.createObjectURL(stream);
video.play();
}, errBack);
} else if(navigator.mozGetUserMedia) { // Mozilla-prefixed
navigator.mozGetUserMedia({ video: true }, function(stream){
video.srcObject = stream;
video.play();
}, errBack);
}
 */


//Trigger photo take
setInterval(function(){
	context.drawImage(video, 0, 0, 640, 480);
//	save( canvas.toDataURL() );
}, 3000);



var mapIsMoving = false;
var data = [], totalPoints = 100;
var profileHeightIndex = 0;

function getData( value ) {
	
	var mapPointerHeight = parseFloat( value );
	
	var pico = 0.0;
	
	if ( profileHeightIndex < totalPoints ) {
		data.push(mapPointerHeight);
		profileHeightIndex++;
	}
	
	if ( profileHeightIndex == totalPoints ) {
		var ultimo = data.length - 1;
		for (var i = 0; i < ultimo; ++i) {
			data[i] = data[i+1];
		}
		data[ultimo] = mapPointerHeight;
	}

	for (var i = 0; i < data.length; ++i) {
		if ( data[i] > pico ) pico = data[i];
	}	
	
	interactive_plot.getOptions().yaxes[0].max = pico;
	jQuery("#profileHeightValue").html('Altitude:<br>' + value + 'm');
	jQuery("#profileMaxHeightValue").html('Máxima<br>' + pico + 'm');
	
	
	var res = []
	for (var i = 0; i < data.length; ++i) {
		res.push([i, data[i]])
	}
	return res
	
}

function updateProfileGraph( mapPointerHeight ) {
	if( mapIsMoving ) return false;
	
	interactive_plot.setData( [getData(mapPointerHeight)] );
	interactive_plot.setupGrid();
	interactive_plot.draw();
}

var interactive_plot = jQuery.plot('#interactive',[[]], {
	grid  : {
		borderColor: '#f3f3f3',
		borderWidth: 1,
		tickColor  : '#f3f3f3'
	},
	series: {
		shadowSize: 0, // Drawing is faster without shadows
		color     : '#3c8dbc'
	},
	lines : {
		fill : true, //Converts the line chart to area chart
		color: '#3c8dbc'
	},
	yaxis : {
		min : 0,
		max : 100,
		show: false
	},
	xaxis : {
		show: false
	}
});



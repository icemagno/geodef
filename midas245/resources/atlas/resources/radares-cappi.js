
var cappiSourceServer = "http://sisgeodef.defesa.mil.br/mapproxy/service/wms";
var cappiArcos = null;
var cappiRadares = [];
var oldCappiRadares = [];
var cappiRadarCronJob = null; 

function initCappiMonitor(){
	/*
	cappiArcos = viewer.imageryLayers.addImageryProvider( 
			getProvider( cappiSourceServer, 'cemaden_dev:arco_td', false, 'png', true )
	);
	*/
	activateCappiRadares();
	cappiRadarCronJob = setInterval( function(){
		reloadCappiRadares();
	}, 60000 );
}

function activateCappiRadares(){
	var elev = '_3_3';
	
	
	activateCappiRadar('cemaden_dev:cappi_almenara' + elev);
	activateCappiRadar('cemaden_dev:cappi_boavista' + elev);
	/*
	activateCappiRadar('cemaden_dev:cappi_cangucu' + elev);
	activateCappiRadar('cemaden_dev:cappi_cascavel' + elev);
	activateCappiRadar('cemaden_dev:cappi_cemig' + elev);
	activateCappiRadar('cemaden_dev:cappi_cha-grande' + elev);
	activateCappiRadar('cemaden_dev:cappi_chapeco' + elev);
	activateCappiRadar('cemaden_dev:cappi_cruzeirodosul' + elev);
	*/
	activateCappiRadar('cemaden_dev:cappi_gama' + elev);
	activateCappiRadar('cemaden_dev:cappi_guaratiba' + elev);
	/*
	activateCappiRadar('cemaden_dev:cappi_jaraguari' + elev);
	activateCappiRadar('cemaden_dev:cappi_lontras' + elev);
	*/
	activateCappiRadar('cemaden_dev:cappi_macae' + elev);
	/*
	activateCappiRadar('cemaden_dev:cappi_macapa' + elev);
	activateCappiRadar('cemaden_dev:cappi_maceio' + elev);
	activateCappiRadar('cemaden_dev:cappi_manaus' + elev);
	activateCappiRadar('cemaden_dev:cappi_morrodaigreja' + elev);
	activateCappiRadar('cemaden_dev:cappi_natal' + elev);
	activateCappiRadar('cemaden_dev:cappi_paraguai' + elev);
	activateCappiRadar('cemaden_dev:cappi_petrolina' + elev);
	activateCappiRadar('cemaden_dev:cappi_picodocouto' + elev);
	activateCappiRadar('cemaden_dev:cappi_portovelho' + elev);
	activateCappiRadar('cemaden_dev:cappi_presidente_prudente' + elev);
	activateCappiRadar('cemaden_dev:cappi_salvador' + elev);
	activateCappiRadar('cemaden_dev:cappi_santarem' + elev);
	activateCappiRadar('cemaden_dev:cappi_santateresa' + elev);
	activateCappiRadar('cemaden_dev:cappi_santiago' + elev);
	activateCappiRadar('cemaden_dev:cappi_saofrancisco' + elev);
	activateCappiRadar('cemaden_dev:cappi_saogabrieldacachoeira' + elev);
	
	activateCappiRadar('cemaden_dev:cappi_saoluiz' + elev);
	activateCappiRadar('cemaden_dev:cappi_saoroque' + elev);
	activateCappiRadar('cemaden_dev:cappi_tabatinga' + elev);
	activateCappiRadar('cemaden_dev:cappi_tefe' + elev);
	activateCappiRadar('cemaden_dev:cappi_teixeirasoares' + elev);
	activateCappiRadar('cemaden_dev:cappi_tresmarias' + elev);
	*/
	//activateCappiRadar('cemaden_dev:edda_0');
	activateCappiRadar('cemaden_dev:edda_1');
	//activateCappiRadar('cemaden_dev:edda_2');
	//activateCappiRadar('cemaden_dev:edda_3');
	activateCappiRadar('cemaden_dev:edda_4');
}


function reloadCappiRadares(){
	for( x=0; x<cappiRadares.length; x++ ) {
		cappiRadares[x].alpha = 0.5;
		oldCappiRadares.push( cappiRadares[x] );
	}
	cappiRadares = [];
	activateCappiRadares();
	
	setTimeout(function(){ 
		for( x=0; x<oldCappiRadares.length; x++ ) {
			viewer.imageryLayers.remove( oldCappiRadares[x], true );
		}
		oldCappiRadares = [];
	}, 7000);
	
}

function activateCappiRadar( name ){
	var n = new Date().getTime();	
	var provider = getProvider( cappiSourceServer, name, false, 'png', true, n );
	var cappi = viewer.imageryLayers.addImageryProvider( provider );
	cappiRadares.push( cappi );
}

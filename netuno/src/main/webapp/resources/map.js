function startMap() {

	
	
	// teste -----------------------------
	
	// ctm50 curva_nivel100 curva_nivel50 rapideye ram_colorimetria_25
	/*
	
capitais	
ctm100	
ctm25	
ctm250	
ctmmultiescalas_mercator	
curva_nivel25	
curva_nivel250	
estados	
landsat7	
mds25	
mds250	
mds50	
municipios	
ortoimagem_scn25	
ortoimagens_codeplan	
ram_colorimetria_50	
ram_mds
	
	*/

      var landsat7 = new ol.layer.Tile({
           source: new ol.source.TileWMS({
               url: 'http://bdgex.eb.mil.br/mapcache',
               params: {
                   'LAYERS': 'landsat7',
                   'transparent' : true,
                   'FORMAT': 'image/png',
                   'tiled': true,
                   'antialias': 'full',
                   'VERSION': '1.3.0'                   
               }
          })     
      });	
	
      
      var basebrasil = new ol.layer.Tile({
          source: new ol.source.TileWMS({
              url: 'http://bdgex.eb.mil.br/cgi-bin/geoportal',
              params: {
                  'LAYERS': 'basebrasil',
                  'transparent' : true,
                  'FORMAT': 'image/png',
                  'tiled': true,
                  'antialias': 'full',
                  'VERSION': '1.3.0'                   
              }
         })     
     });	      
      

      var Mapeamento_em_andamento = new ol.layer.Tile({
          source: new ol.source.TileWMS({
              url: 'http://bdgex.eb.mil.br/cgi-bin/geoportal',
              params: {
                  'LAYERS': 'Mapeamento_em_andamento',
                  'transparent' : true,
                  'FORMAT': 'image/png',
                  'tiled': true,
                  'antialias': 'full',
                  'VERSION': '1.3.0'                   
              }
         })     
     });	      
            

      var DNPM_Extracao_Mineral = new ol.layer.Tile({
          source: new ol.source.TileWMS({
              url: 'http://bdgex.eb.mil.br/cgi-bin/geoportal',
              params: {
                  'LAYERS': 'DNPM_Extracao_Mineral',
                  'transparent' : true,
                  'FORMAT': 'image/png',
                  'tiled': true,
                  'antialias': 'full',
                  'VERSION': '1.3.0'                   
              }
         })     
     });	      
      
      
      var mapaBase = new ol.layer.Tile({
    	  source : new ol.source.TileWMS({
              url: 'http://osm.casnav.mb/osmope/wms/',
              params: {
                  'LAYERS': 'osm:OSMMapa',
                  'FORMAT': 'image/png8', 
                  'tiled': true,
                  'antialias': 'full',
                  'VERSION': '1.3.0'
              }
          })
      });
	
      var curvasOsm = new ol.layer.Tile({
    	  source : new ol.source.TileWMS({
              url: 'http://osm.casnav.mb/osmope/wms/',
              params: {
                  'LAYERS': 'osm:curvas_nivel',
                  'FORMAT': 'image/png8', 
                  'tiled': true,
                  'antialias': 'full',
                  'VERSION': '1.3.0'
              }
          })	
      });

      
      var testeBdgex = new ol.layer.Tile({
    	  source : new ol.source.TileWMS({
              url: 'http://www.geoportal.eb.mil.br/cgi-bin/mapaindice/',
              params: {
                  'LAYERS': 'F100_WGS84_VETORIAL',
                  'FORMAT': 'image/png', 
                  'tiled': true,
                  'antialias': 'full',
                  'VERSION': '1.1.1'
              }
          })	
      });
      
      
      var Alteracao_Fisiografica_Antropica = new ol.layer.Tile({
    	  source : new ol.source.TileWMS({
    		  url: 'http://bdgex.eb.mil.br/teogc/250/terraogcmed.cgi/',
    		  params: {
    			  'LAYERS': 'Alteracao_Fisiografica_Antropica',
    			  'FORMAT': 'image/png', 
    			  'tiled': true,
    			  'antialias': 'full',
    			  'VERSION': '1.1.1'
    		  }
    	  })	
      });      
      
	var map = new ol.Map({
		target: "map",
		layers: [ mapaBase, DNPM_Extracao_Mineral, Mapeamento_em_andamento ],
		view: new ol.View({
			center: [-17,-43],
			projection: 'EPSG:4326',
			zoom: 2
		})
	});

}


function applyMargins() {
	var leftToggler = $(".mini-submenu-left");
	var rightToggler = $(".mini-submenu-right");
	if (leftToggler.is(":visible")) {
		$("#map .ol-zoom")
			.css("margin-left", 0)
			.removeClass("zoom-top-opened-sidebar")
			.addClass("zoom-top-collapsed");
	} else {
		$("#map .ol-zoom")
			.css("margin-left", $(".sidebar-left").width())
			.removeClass("zoom-top-opened-sidebar")
			.removeClass("zoom-top-collapsed");
	}
	if (rightToggler.is(":visible")) {
		$("#map .ol-rotate")
			.css("margin-right", 0)
			.removeClass("zoom-top-opened-sidebar")
			.addClass("zoom-top-collapsed");
	} else {
		$("#map .ol-rotate")
			.css("margin-right", $(".sidebar-right").width())
			.removeClass("zoom-top-opened-sidebar")
			.removeClass("zoom-top-collapsed");
	}
}


function isConstrained() {
	return $("div.mid").width() == $(window).width();
}


function applyInitialUIState() {
	if (isConstrained()) {
		$(".sidebar-left .sidebar-body").fadeOut('slide');
		$(".sidebar-right .sidebar-body").fadeOut('slide');
		$('.mini-submenu-left').fadeIn();
		$('.mini-submenu-right').fadeIn();
	}
}


$(function () {
	
	$('.sidebar-left .slide-submenu').on('click', function () {
		var thisEl = $(this);
		thisEl.closest('.sidebar-body').fadeOut('slide', function () {
			$('.mini-submenu-left').fadeIn();
			applyMargins();
		});
	});
	
	$('.mini-submenu-left').on('click', function () {
		var thisEl = $(this);
		$('.sidebar-left .sidebar-body').toggle('slide');
		thisEl.hide();
		applyMargins();
	});
	
	$('.sidebar-right .slide-submenu').on('click', function () {
		var thisEl = $(this);
		thisEl.closest('.sidebar-body').fadeOut('slide', function () {
			$('.mini-submenu-right').fadeIn();
			applyMargins();
		});
	});
	
	$('.mini-submenu-right').on('click', function () {
		var thisEl = $(this);
		$('.sidebar-right .sidebar-body').toggle('slide');
		thisEl.hide();
		applyMargins();
	});
	
	$(window).on("resize", applyMargins);

	startMap();
	applyInitialUIState();
	applyMargins();
});


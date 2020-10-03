var visibleBar = null;

function hideAllButtonBars() {
	jQuery(".queryRowDetails").remove();
	jQuery( "#toolBarsSubContainer .activeBtnBar" ).hide(300);
	jQuery( "#toolBarsSubContainer .activeBtnBar" ).removeClass('activeBtnBar');	
	jQuery( ".toolBarMenuBox" ).hide(300);
	visibleBar = null;
	removeMouseClickListener();
}

function hideRouteDir() {
	jQuery("#routeContainer").hide();
}

function closeQueryToolBarMenu() {
	hideAllButtonBars();
	removeMouseClickListener();
	jQuery('.cesium-viewer').css('cursor', '');
}

function closeMetocToolBarMenu() {
	hideAllButtonBars();
}

function closeVsToolBarMenu() {
	hideAllButtonBars();
	cancelViewShedTool();
}

function closeRouteToolBarMenu() {
	hideAllButtonBars();
	hideRouteMenu();
	cancelRouteEditing();
	hideRouteDir();
}

function closePlataformasToolBarMenu() {
	hideAllButtonBars();
}

function closeAvisosRadioToolBarMenu() {
	hideAllButtonBars();
	jQuery('#avisosContainer').hide();
	deleteAvisos();
}

function closeMeasureToolBarMenu() {
	hideAllButtonBars();
}

function closeDrawToolBarMenu() {
	hideAllButtonBars();
}

function showButtonBar( element ) {
	jQuery( element ).show(300);
	jQuery( element ).addClass('activeBtnBar');
}

function isVisible( bar ) {
	return visibleBar == bar;
}

function closeSearchToolBarMenu() {
	jQuery(".layerFoundItem").remove();
	jQuery("#layerNameFinder").val('');	
	jQuery("#treeview-terrestre").show();	
	//jQuery("#treeview-nautica").show();	
	//jQuery("#treeview-aeronautica").show();	
}

function bindToolBarButtons() {
	
    jQuery("#showMeasureTools").click( function() {
    	var wasVisible = isVisible('BAR_MEASURE');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_MEASURE';	
    		showButtonBar( "#toolBarMeasure" );
    		jQuery("#measureMenuBox").show( 300 );
    	}
    });
    
    jQuery("#showToolQuery").click( function(){
    	var wasVisible = isVisible('BAR_QUERY');
		hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_QUERY';	
    		queryLayer();
       		jQuery("#queryMenuBox").show( 300 );
    	}    	
	});
    
    
    jQuery("#showToolRoutes").click( function(){
    	var wasVisible = isVisible('BAR_ROUTE');
		hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_ROUTE';	
    		bindRouteRightClick();
       		jQuery("#routeMenuBox").show( 300 );
    	}
    });
    
    jQuery("#show3DTools").click( function(){
    	var wasVisible = isVisible('BAR_ANALYSIS');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_ANALYSIS';	
    		showButtonBar( "#toolBarTerrainAnalysis" );
    		jQuery("#vsMenuBox").show(300);
    	}
    });
    
    jQuery("#showDesignTools").click( function(){
    	var wasVisible = isVisible('BAR_DRAW');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_DRAW';	
    		showButtonBar( "#toolBarFeatures" );
    		jQuery("#drawMenuBox").show(300);
    	}
    });

    jQuery("#toolExperimental").click( function(){
    	showButtonBar( "#toolBarExperimental" );
    });
    
    jQuery("#toolEdgvBook").click( function(){
    	window.open( sisgeodefHost + "/iscy/");
    });
    
    jQuery("#toolGuia").click( function(){
    	window.open("/resources/img/fastguide/index.html");
    });
	
	
    jQuery("#toolFullScreen").click( function(){
    	var elem = document.getElementById("cesiumContainer");
		openFullscreen( elem );
    });
    
    jQuery("#toolSolucionadores").click( function(){
    	var wasVisible = isVisible('BAR_SOLUCOES');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_SOLUCOES';	
    		showButtonBar( "#toolBarSolucionadores" );
    	}
    });
    
    jQuery("#toolCatalogs").click( function(){
    	var wasVisible = isVisible('BAR_CATALOGS');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_CATALOGS';	
    		showButtonBar( "#toolBarCatalogs" );
    	}
    });

    
    
	// *****************************************
    
	jQuery("#toolGoTopView").click( function(){
		var currentPosition = viewer.camera.positionCartographic;
		
        var windowPosition = new Cesium.Cartesian2(viewer.container.clientWidth / 2, viewer.container.clientHeight / 2);
        var pickRay = viewer.scene.camera.getPickRay(windowPosition);
        var pickPosition = viewer.scene.globe.pick(pickRay, viewer.scene);
        var pickPositionCartographic = viewer.scene.globe.ellipsoid.cartesianToCartographic(pickPosition);
        var longitude = (pickPositionCartographic.longitude * (180/Math.PI));
        var latitude = (pickPositionCartographic.latitude * (180/Math.PI));		
		
		
		
		var height = currentPosition.height;
		//var longitude = Cesium.Math.toDegrees(currentPosition.longitude);
		//var latitude = Cesium.Math.toDegrees(currentPosition.latitude);
		viewer.camera.flyTo({
		    destination : Cesium.Cartesian3.fromDegrees( longitude, latitude, height + 15000 ),
		    orientation : {
		        heading : Cesium.Math.toRadians( 0.0 ),
		        pitch : Cesium.Math.toRadians( -90.0 ),
		        roll : Cesium.Math.toRadians( 0.0 )
		    }
		});
	});
    
    
	jQuery("#toolHome").click( function(){
		var center = Cesium.Rectangle.center( homeLocation );
		var longitude = Cesium.Math.toDegrees(center.longitude);
		var latitude = Cesium.Math.toDegrees(center.latitude);
		viewer.camera.flyTo({
		    destination : Cesium.Cartesian3.fromDegrees( longitude, latitude, 752872 ),
		    orientation : {
		        heading : Cesium.Math.toRadians( 0.0 ),
		        pitch : Cesium.Math.toRadians( -90.0 ),
		        roll : Cesium.Math.toRadians( 0.0 )
		    }
		});
		
	});

    jQuery("#routeDirButton").click( function(){
    	hideRouteDir();
    });

	jQuery("#toolScreenSnapShot").click( function(){
		screenShot();
	});
	
	jQuery("#toolViewShed").click( function(){
		viewShed();
	});
	
	jQuery("#toolAddPoint").click( function(){
		drawPoint();
	});
	jQuery("#toolAddLine").click( function(){
		drawLine();
	});
	jQuery("#toolAddPolygon").click( function(){
		drawPolygon( false );
	});
	jQuery("#toolAddPolygonSurface").click( function(){
		drawPolygon( true );
	});
	
	jQuery("#toolAddMarker").click( function(){
		drawMarker();
	});

	/* **************************************************
	 *                     SOLUCIONADORES 
	 * **************************************************/

	jQuery("#toolGtOpA").click( function(){
		jQuery("#plataformasMenuBox").show(300);
		plataformas();
	});	


	/* --------------   AVISOS RADIO -------------  */
	jQuery("#toolAvisoRadio").click( function(){
		jQuery("#avisosRadioMenuBox").show(300);
	});	
	jQuery("#loadAvisosRadioBtn").click( function(){
		var sarEventsOnlyFilter = jQuery("#sarEventsOnly").prop('checked');
		avisosRadio( sarEventsOnlyFilter );
	});	
	
	/* --------------   METOC --------------------  */
	// Reverti o menu de Climatologia
	jQuery("#loadClimatologiaBtn").click( function(){
		//var time = jQuery("#metocLayerTimeDate").val();
		loadClimato();
	});
	
	jQuery("#toolMetoc").click( function(){
		jQuery("#metocMenuBox").show(300);
	});
	
	/* -------------------------------------------- */
	
	jQuery("#toolPCN").click( function(){
		jQuery("#pcnMenuBox").show(300);
	});	

	
	jQuery("#toolCOR").click( function(){
		loadCores( );
		//jQuery("#pcnMenuBox").show(300);
	});	
	
	/* **************************************************
	 *                     EXPERIMENTAL 
	 * **************************************************/
	jQuery("#toolOSM3D").click( function(){
		getBuildings();
	});
	
	jQuery("#toolFavelas").click( function(){
		drawFavelas();
	});
	
	jQuery("#toolNuvemPontos").click( function(){
		loadPC();
	});

	jQuery("#toolFlood").click( function(){
		startFlood();
	});
	
	/******************************************************/ 
	
	
	
}
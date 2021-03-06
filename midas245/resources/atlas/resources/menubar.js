var visibleBar = null;

function hideAllButtonBars() {
	$(".queryRowDetails").remove();
	$( "#toolBarsSubContainer .activeBtnBar" ).hide(300);
	$( "#toolBarsSubContainer .activeBtnBar" ).removeClass('activeBtnBar');	
	$( ".toolBarMenuBox" ).hide(300);
	visibleBar = null;
	removeMouseClickListener();
}

function cancelWaitingOp(){
	$("#mainWaitPanel").hide();
}

function closeQueryToolBarMenu() {
	$("#queryMenuBox").hide();
	currentPanelActiveAerodromo = '';
}

function closePCNToolBarMenu() {
	isPCNSolutionActive = false;
	deleteAllRunways();
	$("#toolPCN").addClass("btn-warning");
	$("#toolPCN").removeClass("btn-danger");
	hideAllButtonBars();
}

function closeVsToolBarMenu() {
	hideAllButtonBars();
	cancelViewShedTool();
}

function closePlataformasToolBarMenu() {
	hideAllButtonBars();
}

function closeMeasureToolBarMenu() {
	hideAllButtonBars();
}

function closeDrawToolBarMenu() {
	hideAllButtonBars();
}

function showButtonBar( element ) {
	$( element ).show(300);
	$( element ).addClass('activeBtnBar');
}

function isVisible( bar ) {
	return visibleBar == bar;
}

function closeSearchToolBarMenu() {
	$(".layerFoundItem").remove();
	$("#layerNameFinder").val('');	
	$("#treeview-terrestre").show();	
	//$("#treeview-nautica").show();	
	//$("#treeview-aeronautica").show();	
}

function bindToolBarButtons() {
	
    $("#showMeasureTools").click( function() {
    	var wasVisible = isVisible('BAR_MEASURE');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_MEASURE';	
    		showButtonBar( "#toolBarMeasure" );
    		$("#measureMenuBox").show( 300 );
    	}
    });
    
    
    $("#showToolQuery").click( function(){
   		queryLayer();
	});
    
    $("#show3DTools").click( function(){
    	var wasVisible = isVisible('BAR_ANALYSIS');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_ANALYSIS';	
    		showButtonBar( "#toolBarTerrainAnalysis" );
    		$("#vsMenuBox").show(300);
    	}
    });
    
    $("#showDesignTools").click( function(){
    	var wasVisible = isVisible('BAR_DRAW');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_DRAW';	
    		showButtonBar( "#toolBarFeatures" );
    		$("#drawMenuBox").show(300);
    	}
    });

    $("#toolExperimental").click( function(){
    	showButtonBar( "#toolBarExperimental" );
    });
    
    $("#toolEdgvBook").click( function(){
    	window.open( sisgeodefHost + "/iscy/");
    });
    
    $("#toolGuia").click( function(){
    	window.open("/midas/atlas/fastguide/index.html");
    });
	
	
    $("#toolFullScreen").click( function(){
    	var elem = document.getElementById("cesiumContainer");
		openFullscreen( elem );
    });
    
    $("#toolSolucionadores").click( function(){
    	var wasVisible = isVisible('BAR_SOLUCOES');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_SOLUCOES';	
    		showButtonBar( "#toolBarSolucionadores" );
    	}
    });
    
    $("#toolCatalogs").click( function(){
    	var wasVisible = isVisible('BAR_CATALOGS');
    	hideAllButtonBars();
    	if( !wasVisible ) {
    		visibleBar = 'BAR_CATALOGS';	
    		showButtonBar( "#toolBarCatalogs" );
    	}
    });

    
    
	// *****************************************
    
	$("#toolGoTopView").click( function(){
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
    
    
	$("#toolHome").click( function(){
		var center = Cesium.Rectangle.center( homeLocation );
		var longitude = Cesium.Math.toDegrees(center.longitude);
		var latitude = Cesium.Math.toDegrees(center.latitude);
		viewer.camera.flyTo({
		    destination : Cesium.Cartesian3.fromDegrees( longitude, latitude, 11293823 ),
		    orientation : {
		        heading : Cesium.Math.toRadians( 0.0 ),
		        pitch : Cesium.Math.toRadians( -90.0 ),
		        roll : Cesium.Math.toRadians( 0.0 )
		    }
		});
		
	});

	// Barra de busca
    $("#myPlaceBtn").click( function(){
    	getUserLocation();
    });
    
    $("#helpOnSerachBarBtn").mouseenter( function(){
    	$("#searchBarHelpContainer").show();
    }).mouseleave( function(){
    	$("#searchBarHelpContainer").hide();
    });
    	
    
    
    
    // ==================================================
    
	$("#toolScreenSnapShot").click( function(){
		screenShot();
	});
	
	$("#toolViewShed").click( function(){
		viewShed();
	});
	
	$("#toolAddPoint").click( function(){
		drawPoint();
	});
	$("#toolAddLine").click( function(){
		drawLine();
	});
	$("#toolAddPolygon").click( function(){
		console.log('dddd');
		drawPolygon( false );
	});
	$("#toolAddPolygonSurface").click( function(){
		drawPolygon( true );
	});
	
	$("#toolAddMarker").click( function(){
		drawMarker();
	});
	$("#toolAddCircle").click( function(){
		drawCircle();
	});
	$("#toolAddBox").click( function(){
		drawBox();
	});
	$("#toolPrfilElevacao").click( function(){
		calcLineTerrainProfile();
	});
	$("#toolVoronoi").click( function(){
		//
	});
	$("#toolBuffer").click( function(){
		//
	});
	
	// Botoes da barra lateral esquerda.
	$("#openCatalogBtn").click( function(){
		openCatalogBox();
	});
	$("#uploadUserDataBtn").click( function(){
		showUploadUserData();
	});


	/* **************************************************
	 *                     SOLUCIONADORES 
	 * **************************************************/


	//***********************************************************
	//                 ROTA 
	//***********************************************************
    $("#toolRoutes").click( function(){
    	if( isRouteSolutionActive ){
    		cancelRouteSolution();
    	} else {
    		startRouteSolution();
    	}
    	
    });

    $("#routeDirButton").click( function(){
    	$("#routeContainer").hide();
    });
    

    // **********************************************************
	
	
	$("#toolGtOpA").click( function(){
		if( isPlataformaSolutionActive ){
			cancelPlataformaSolution();
		} else {
			startPlataformaSolution();
		}	
	});	


	/* --------------   AVISOS RADIO -------------  */
	$("#toolAvisoRadio").click( function(){
		startAvisoRadio();
	});	
	
	/* --------------   METOC --------------------  */
	// Reverti o menu de Climatologia
	$("#loadClimatologiaBtn").click( function(){
		//var time = $("#metocLayerTimeDate").val();
		loadClimato();
	});
	
	$("#toolMetoc").click( function(){
		$("#metocMenuBox").show(300);
	});
	
	/* -------------------------------------------- */
	
	$("#toolPCN").click( function(){
		if( isPCNSolutionActive ){
			closePCNToolBarMenu();
		} else {
			$("#toolPCN").removeClass("btn-warning");
			$("#toolPCN").addClass("btn-danger");
			$("#pcnMenuBox").show(300);
			isPCNSolutionActive = true;
		}
	});	

	$("#toolCOR").click( function(){
		if( isCorMetSolutionActive ){
			cancelCorMetocSolution();
		} else {
			$("#mainWaitPanel").show();
			startCorMetSolution();
		}		
	});	

	$("#toolOSM3D").click( function(){
		startOsmBuildings();
	});
	
	
}
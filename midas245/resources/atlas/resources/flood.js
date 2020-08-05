var currentHeight = 0;
var maxValue = 0;
var minValue = 0;
var altitude = -1;
var int = null;
var hyp = null;
var colorTable = null;

function setColorTable(colorTable, key) {
    switch (key) {
        case "1":
            colorTable.insert(71, new Cesium.Color(0, 39/255, 148/255));
            colorTable.insert(0, new Cesium.Color(149/255, 232/255, 249/255));
            break;
        case "2":
            colorTable.insert(71, new Cesium.Color(162/255, 251/255, 194/255));
            colorTable.insert(0, new Cesium.Color(1, 103/255, 103/255));
            break;
        case "3":
            colorTable.insert(71, new Cesium.Color(230/255, 198/255, 1));
            colorTable.insert(0, new Cesium.Color(157/255, 0, 1));
            break;
        case "4":
            colorTable.insert(71, new Cesium.Color(210/255, 15/255, 15/255));
            colorTable.insert(54, new Cesium.Color(221/255, 224/255, 7/255));
            colorTable.insert(36, new Cesium.Color(20/255, 187/255, 18/255));
            colorTable.insert(18, new Cesium.Color(0, 161/255, 1));
            colorTable.insert(0, new Cesium.Color(9/255, 9/255, 212/255));
            break;
        case "5":
            colorTable.insert(71, new Cesium.Color(186/255, 1, 229/255));
            colorTable.insert(0, new Cesium.Color(26/255, 185/255, 156/255));
            break;
      default:
        break;
    }
}


function startFlood() {
	
    var polygonHandler = new Cesium.DrawHandler(viewer,Cesium.DrawMode.Polygon);
    polygonHandler.activate();
    
	polygonHandler.drawEvt.addEventListener(function(polygon){
        var array = [].concat(polygon.object.positions);
        var positions = [];
        for(var i = 0, len = array.length; i < len; i ++){

            var cartographic = Cesium.Cartographic.fromCartesian(array[i]);
            var longitude = Cesium.Math.toDegrees(cartographic.longitude);
            var latitude = Cesium.Math.toDegrees(cartographic.latitude);
            var h=cartographic.height;
            if(positions.indexOf(longitude)==-1&&positions.indexOf(latitude)==-1){
                positions.push(longitude);
                positions.push(latitude);
                positions.push(h);
            }
        }
        polygonHandler.deactivate();
        polygonHandler.activate();
        
        if( positions) flood(positions);
        
        polygonHandler.polygon.show=false;
        polygonHandler.polyline.show=false;
        
    });	
	
	
}

function flood(positions){
	hyp = new Cesium.HypsometricSetting();
    currentHeight = 0;
    
    maxValue = parseInt(9000);
    minValue = parseInt(0);  // metros
	currentHeight = minValue;

	colorTable = new Cesium.ColorTable();
	setColorTable(colorTable, 1);
	
	hyp.MinVisibleValue = minValue;
    hyp.ColorTable = colorTable;
    hyp.DisplayMode = Cesium.HypsometricSettingEnum.AnalysisRegionMode.FACE
    hyp.Opacity = 1.0;
    hyp.LineInterval = 10.0;
	
    var layer = imageryLayers.get(1); 
	
    int = self.setInterval("doFlood()", 100);
	
    window.doFlood = function() {
    	
    	console.log( currentHeight );
    	
        if(currentHeight > maxValue) {
            self.clearInterval(int);
            return;
        }
        hyp.MaxVisibleValue = currentHeight;
        hyp.CoverageArea = positions;
        
        viewer.scene.globe.hypsometricSetting = {
            hypsometricSetting : hyp,
            analysisMode : Cesium.HypsometricSettingEnum.AnalysisRegionMode.ARM_REGION
        };
        
        currentHeight += 10;  // metros por segundo
    }
}	



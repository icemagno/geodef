
function doWindParticles(){
	
                
    //scene.globe.baseColor = new Cesium.Color(0.0, 0.0, 0.0, 1.0);
	
	var fieldLayer = new Cesium.FieldLayer3D(scene.context);

	var life = 1;
	var lifeRange = [life * 1000.0, life * 1000.0 + 5000.0];
	fieldLayer.particleVelocityFieldEffect.particleLifeRange = lifeRange;

	fieldLayer.particleVelocityFieldEffect.velocityScale = 0.5 * 100.0; 
	fieldLayer.particleVelocityFieldEffect.particleSize = 1.5;
	fieldLayer.particleVelocityFieldEffect.paricleCountPerDegree = 1.7;


	var colorTable = new Cesium.ColorTable();
	/*
	colorTable.insert(2, new Cesium.Color(254 / 255, 224 / 255, 139 / 255, 0.95));
	colorTable.insert(2, new Cesium.Color(171 / 255, 221 / 255, 164 / 255, 0.95));
	colorTable.insert(2, new Cesium.Color(104 / 255, 196 / 255, 160 / 255, 0.95));
	colorTable.insert(4, new Cesium.Color(44 / 255, 185 / 255, 156 / 255, 0.95));
	colorTable.insert(4, new Cesium.Color(25 / 255, 169 / 255, 178 / 255, 0.95));
	colorTable.insert(7, new Cesium.Color(50 / 255, 136 / 255, 189 / 255, 0.95));
	colorTable.insert(10, new Cesium.Color(31 / 255, 110 / 255, 183 / 255, 0.95));
	colorTable.insert(15, new Cesium.Color(5 / 255, 98 / 255, 184 / 255, 0.95));
	*/
	colorTable.insert(0, new Cesium.Color(3/255, 0/255, 255/255));
	colorTable.insert(1, new Cesium.Color(255/255, 128/255, 200/255));
	colorTable.insert(2, new Cesium.Color(0/255, 120/255, 255/255));
	colorTable.insert(4, new Cesium.Color(0, 255/255, 128/255));
	colorTable.insert(7, new Cesium.Color(255/255, 0/255, 255/255));
	colorTable.insert(10, new Cesium.Color(255/255, 255/255, 0/255));
	colorTable.insert(15, new Cesium.Color(255/255, 0/255, 0/255));

	scene.primitives.add(fieldLayer); 

	var particleWindField = [];
	var particleWindInverseField = [];
	var dataChanged = false;
	fieldLayer.particleVelocityFieldEffect.colorTable = colorTable;

    $.ajax({
        url: '/resources/data/climatologia/winds.json',
        success: function (data) {
            var p = 0;
            for (var j = 0; j < data.ny; j++) {
                particleWindField[j] = [];
                //particleWindInverseField[j] = [];
                for (var i = 0; i < data.nx; i++, p++) {
                    particleWindField[j][i] = data.data[p];
                    //particleWindInverseField[j][i] = [-data.data[p][0], -data.data[p][1]];
                }
            }
			fieldLayer.fieldData = particleWindField;
        }
    });



}
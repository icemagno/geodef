var _primitives = null;
var SPEED_RATE = 0.14;
var PARTICLES_NUMBER = 3000;
var MAX_AGE = 7;
var BRIGHTEN = 1.5;
 

var Windy = function (json, cesiumViewer, options ) {
	this.color = Cesium.Color.BLUE;
	if( options	){
		if( options.color ) this.color = options.color;
	}	
    this.windData = json;
    this.windField = null;
    this.particles = [];
    this.lines = null;
    _primitives = cesiumViewer.scene.primitives;
    this._init();
};

Windy.prototype = {
    constructor: Windy,
    _init: function () {
        this.windField = this.createField();
        for (var i = 0; i < PARTICLES_NUMBER; i++) {
            this.particles.push( this.randomParticle( new Particle() ) );
        }
    },
    createField: function () {
        var data = this._parseWindJson();
        return new WindField(data);
    },
    animate: function () {
        var self = this,
            field = self.windField,
            particles = self.particles;

        var instances = [],
            nextX = null,
            nextY = null,
            xy = null,
            uv = null;
        particles.forEach(function (particle) {
            if (particle.age <= 0) {
                self.randomParticle(particle);
            }
            if (particle.age > 0) {
                var x = particle.x,
                    y = particle.y;

                if (!field.isInBound(x, y)) {
                    particle.age = 0;
                } else {
                    uv = field.getIn(x, y);
                    nextX = x +  SPEED_RATE * uv[0];
                    nextY = y +  SPEED_RATE * uv[1];
                    particle.path.push(nextX, nextY);
                    particle.x = nextX;
                    particle.y = nextY;
                    instances.push(self._createLineInstance(self._map(particle.path), particle.age / particle.birthAge));
                    particle.age--;
                }
            }
        });
        if (instances.length <= 0) this.removeLines();
        self._drawLines(instances);
    },
    _parseWindJson: function () {
        var uComponent = null,
            vComponent = null,
            header = null;
        this.windData.forEach(function (record) {
            var type = record.header.parameterCategory + "," + record.header.parameterNumber;
            switch (type) {
                case "2,2":
                    uComponent = record['data'];
                    header = record['header'];
                    break;
                case "2,3":
                    vComponent = record['data'];
                    break;
                default:
                    break;
            }
        });
        return {
            header: header,
            uComponent: uComponent,
            vComponent: vComponent
        };
    },
    removeLines: function () {
		if( !Cesium.defined(this.lines) ) return;
		_primitives.remove(this.lines);
		if( !this.lines.isDestroyed() ) this.lines.destroy();
    },
	
    _map: function (arr) {
        var length = arr.length,
            field = this.windField,
            dx = field.dx,
            dy = field.dy,
            west = field.west,
            south = field.north,
            newArr = [];
        for (var i = 0; i <= length - 2; i += 2) {
            newArr.push(
                west + arr[i] * dx,
                south - arr[i + 1] * dy
            )
        }
        return newArr;
    },
    _createLineInstance: function (positions, ageRate) {
        var colors = [],
            length = positions.length,
            count = length / 2;
        for (var i = 0; i < length; i++) {
            colors.push( this.color.withAlpha(i / count * ageRate * BRIGHTEN));
        }
        return new Cesium.GeometryInstance({
            geometry: new Cesium.PolylineGeometry({
                positions: Cesium.Cartesian3.fromDegreesArray(positions),
                colors: colors,
                width: 1.0,
                colorsPerVertex: true
            })
        });
    },
    _drawLines: function (lineInstances) {
        this.removeLines();
        var linePrimitive = new Cesium.Primitive({
            appearance: new Cesium.PolylineColorAppearance({
                translucent: true
            }),
            geometryInstances: lineInstances,
            asynchronous: false
        });
        this.lines = _primitives.add(linePrimitive);
    },
    randomParticle: function (particle) {
        var safe = 30,x, y;

        do {
            x = Math.floor(Math.random() * (this.windField.cols - 2));
            y = Math.floor(Math.random() * (this.windField.rows - 2));
        } while (this.windField.getIn(x, y)[2] <= 0 && safe++ < 30);

        particle.x = x;
        particle.y = y;
        particle.age = Math.round(Math.random() * MAX_AGE);
        particle.birthAge = particle.age;
        particle.path = [x, y];
        return particle;
    }
};




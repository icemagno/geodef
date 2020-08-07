/**
 * WebGL sample configuration file: contains the classification, name, thumbnail, file path of the sample
 */
var identification = {
    name: "WebGL"
};
var exampleConfig = {
    "layer": {
        name: "Layer",
        name_en: "layer",
        content: {
            "terrain": {
                name: "terrain",
                name_en: "terrain",
                content: [{
                    name: "Topographic image",
                    name_en: "terrainAndImagery",
                    thumbnail: "terrainAndImagery.jpg",
                    fileName: "terrainAndImagery"
                }]
            },
            "imagery": {
                name: "image",
                name_en: "imagery",
                content: [{
                        name: "Dynamic time",
                        name_en: "dynamicTime",
                        thumbnail: "dynamicTime.jpg",
                        fileName: "dynamicTime"
                    },
                    {
                        name: "Temporal",
                        name_en: "ImageryAdjustment",
                        thumbnail: "ImageryAdjustment.jpg",
                        fileName: "ImageryAdjustment"
                    },
                    {
                        name: "Superimposed 2D map",
                        name_en: "SuperMapTileImagery",
                        thumbnail: "SuperMapTileImagery.jpg",
                        fileName: "SuperMapTileImagery"
                    },
                    {
                        name: "safety certificate",
                        name_en: "tokenCredential",
                        thumbnail: "tokenCredential.jpg",
                        fileName: "tokenCredential"
                    }
                ]
            },
            "S3M": {
                name: "Safety certificate",
                name_en: "S3M",
                content: [{
                        name: "Oblique photogrammetric model",
                        name_en: "S3MTiles_suofeiya",
                        thumbnail: "S3MTiles_suofeiya.jpg",
                        fileName: "S3MTiles_suofeiya"
                    },
                    {
                        name: "Salzburg (water surface effects)",
                        name_en: "S3MTiles_srsb_water",
                        thumbnail: "S3MTiles_srsb_water.jpg",
                        fileName: "S3MTiles_srsb_water"
                    },
                    {
                        name: "Bird's Nest (water surface effect)",
                        name_en: "S3MTiles_niaochao_water",
                        thumbnail: "S3MTiles_niaochao_water.jpg",
                        fileName: "S3MTiles_niaochao_water"
                    },
                    {
                        name: "CBD",
                        name_en: "S3MTiles_jingmo",
                        thumbnail: "S3MTiles_jingmo.jpg",
                        fileName: "S3MTiles_jingmo"
                    },
                    {
                        name: "BIM",
                        name_en: "S3MTiles_BIM",
                        thumbnail: "S3MTiles_BIM.jpg",
                        fileName: "S3MTiles_BIM"
                    },
                    {
                        name: "Vector",
                        name_en: "S3MTiles_vector",
                        thumbnail: "S3MTiles_vector.jpg",
                        fileName: "S3MTiles_vector"
                    }, {
                        name: "PointCloud",
                        name_en: "S3MTiles_pointCloud",
                        thumbnail: "S3MTiles_pointCloud.jpg",
                        fileName: "S3MTiles_pointCloud"
                    },
                    {
                        name: "Underground pipeline",
                        name_en: "showUnderGround",
                        thumbnail: "showUnderGround.jpg",
                        fileName: "showUnderGround"
                    },
                    {
                        name: "Volume rendering",
                        name_en: "S3M_Volume",
                        thumbnail: "S3M_Volume.jpg",
                        fileName: "S3M_Volume"
                    },
                    {
                        name: "Nearest Filter Mode",
                        name_en: "nearestFilterMode",
                        thumbnail: "nearestFilterMode.jpg",
                        fileName: "nearestFilterMode"
                    },
                    {
                        name: "Rransparent Rendering",
                        name_en: "transparentRendering",
                        thumbnail: "transparentRendering.jpg",
                        fileName: "transparentRendering"
                    },
                    {
                        name: "S3MTiles histogram",
                        name_en: "S3MTiles_histogram",
                        thumbnail: "S3MTiles_histogram.jpg",
                        fileName: "S3MTiles_histogram"
                    },
                    {
                        name: "Histogram",
                        name_en: "offset",
                        thumbnail: "offset.jpg",
                        fileName: "offset"
                    }
                ]
            },
            "dynamic-layer": {
                name: "Dynamic Layer",
                name_en: "dynamic layer",
                content: [{
                        name: "Global real-time route data",
                        name_en: "airlines",
                        thumbnail: "airline.jpg",
                        fileName: "airlines"
                    },
                    {
                        name: "Global ship dynamics",
                        name_en: "dynamicLayer",
                        thumbnail: "dynamicLayer.jpg",
                        fileName: "dynamicLayer"
                    },
                    {
                        name: "Fan",
                        name_en: "fan",
                        thumbnail: "fan.jpg",
                        fileName: "fan"
                    },
                    {
                        name: "Traffic Simulation",
                        name_en: "trafficSimulation",
                        thumbnail: "trafficSimulation.jpg",
                        fileName: "trafficSimulation"
                    }
                ]
            }
        }
    },
    "online-base-map": {
        name: "Online base map",
        name_en: "online base map",
        content: {
            "map": {
                name: "Online base map",
                name_en: "online base map",
                content: [{
                        name: "Local picture",
                        name_en: "SingleTileImageryProvider",
                        thumbnail: "SingleTileImageryProvider.jpg",
                        fileName: "image"
                    },
                    {
                        name: "Tianditu",
                        name_en: "tianditu",
                        thumbnail: "tianditu.jpg",
                        fileName: "tianditu"
                    },
                    {
                        name: "BingMap",
                        name_en: "BingMap",
                        thumbnail: "bingMap.jpg",
                        fileName: "bingMap"
                    },
                    {
                        name: "STK terrain",
                        name_en: "STKterrain",
                        thumbnail: "STKterrain.jpg",
                        fileName: "STKterrain"
                    }
                ]
            }
            /*,
                        "data": {
                            name: "data",
                            name_en: "data service",
                            content: [
                                {
                                    name: "Night map",
                                    name_en: "flightFly.html",
                                    thumbnail: "flightFly.jpg",
                                    fileName: "flightFly"
                                },
                                {
                                    name: "3D tiles",
                                    name_en: "3D Tiles Photogrammetry",
                                    thumbnail: "3D Tiles Photogrammetry.jpg",
                                    fileName: "3D Tiles Photogrammetry"
                                },
                                {
                                    name: "Draw a dotted line",
                                    name_en: "draw",
                                    thumbnail: "draw.jpg",
                                    fileName: "draw"
                                }
                            ]
                        },
                        "spatialAnalyst": {
                            name: "Spatial Analysis",
                            name_en: "spatial analysis service",
                            content: [     {
                                name: "PM2.5",
                                name_en: "pm",
                                thumbnail: "pm.jpg",
                                fileName: "pm"
                            }, ]
                        },
                        "processingService": {
                            name: "Distributed analysis",
                            name_en: "distributed analysis services",
                            content: [  {
                                name: "STK terrain",
                                name_en: "STKterrain",
                                thumbnail: "STKterrain.jpg",
                                fileName: "STKterrain"
                            }, {
                                name: "Scene mode switching",
                                name_en: "switchSceneMode",
                                thumbnail: "switchSceneMode.jpg",
                                fileName: "switchSceneMode"
                            }]
                        }*/
        }
    },
    "Scene": {
        name: "Scenes",
        name_en: "Scene",
        content: {
            "PostProcessing": {
                name: "Scenes",
                name_en: "PostProcessing",
                content: [{
                        name: "Color correction",
                        name_en: "colorCorrection",
                        thumbnail: "colorCorrection.jpg",
                        fileName: "colorCorrection"
                    },
                    {
                        name: "Post effects",
                        name_en: "aftertreatment",
                        thumbnail: "aftertreatment.jpg",
                        fileName: "aftertreatment"
                    },
                    {
                        name: "Wireframe",
                        name_en: "wireframe",
                        thumbnail: "wireframe.jpg",
                        fileName: "wireframe"
                    },
                    {
                        name: "LightSource",
                        name_en: "lightSource",
                        thumbnail: "lightSource.jpg",
                        fileName: "lightSource"
                    },
                    {
                        name: "Visible By Feature Value",
                        name_en: "visibleByFeatureValue",
                        thumbnail: "visibleByFeatureValue.jpg",
                        fileName: "visibleByFeatureValue"
                    }
                ]
            },
            "split": {
                name: "Split Screen",
                name_en: "split",
                content: [{
                        name: "Split screen display",
                        name_en: "multiViewport",
                        thumbnail: "multiViewport.jpg",
                        fileName: "multiViewport"
                    },
                    {
                        name: "Splitter",
                        name_en: "split",
                        thumbnail: "split.jpg",
                        fileName: "split"
                    }
                ]
            },
            "globe-mode": {
                name: "Earth mode",
                name_en: "globe mode",
                content: [{
                        name: "Mode switching",
                        name_en: "switchGlobeMode",
                        thumbnail: "switchGlobeMode.jpg",
                        fileName: "switchGlobeMode"
                    },
                    {
                        name: "2D switching",
                        name_en: "sceneModeSwitching",
                        thumbnail: "sceneModeSwitching.jpg",
                        fileName: "sceneModeSwitching"
                    }
                ]
            },
            "position-info": {
                name: "location information",
                name_en: "position information",
                content: [{
                    name: "Picking position",
                    name_en: "pickPosition",
                    thumbnail: "pickPosition.jpg",
                    fileName: "pickPosition"
                }]
            },
            "output-Of-Scene": {
                name: "Scene plot",
                name_en: "Screenshot of scene",
                content: [{
                    name: "Scene plot",
                    name_en: "Screenshot of scene",
                    thumbnail: "S3MTiles_niaochao_water.jpg",
                    fileName: "outputScene"
                }]
            }
        }
    },
    "search": {
        name: "Inquire",
        name_en: "search",
        content: {
            "online-search": {
                name: "Online search",
                name_en: "online search",
                content: [{
                    name: "POI search",
                    name_en: "location",
                    thumbnail: "location.jpg",
                    fileName: "location"
                }]
            },
            "attribute-search": {
                name: "Attribute query",
                name_en: "attribute search",
                content: [{
                        name: "Oblique photogrammtric attribute query",
                        name_en: "S3MTiles",
                        thumbnail: "S3MTiles.jpg",
                        fileName: "S3MTiles"
                    },
                    {
                        name: "SQL query",
                        name_en: "getFeatureBySQL",
                        thumbnail: "getFeatureBySQL.jpg",
                        fileName: "getFeatureBySQL"
                    },
                    {
                        name: "Spatial query",
                        name_en: "getFeatureByGeometry",
                        thumbnail: "getFeatureByGeometry.jpg",
                        fileName: "getFeatureByGeometry"
                    },
                    {
                        name: "Hierarchical household inquiry",
                        name_en: "individualInformation",
                        thumbnail: "individualInformation.jpg",
                        fileName: "individualInformation"
                    },
                    {
                        name: "Dynamic singulation",
                        name_en: "dynamicDTH",
                        thumbnail: "dynamicDTH.jpg",
                        fileName: "dynamicDTH"
                    }
                ]
            }
        }
    },
    "measurement": {
        name: "Measure",
        name_en: "measurement",
        content: {
            "measurement": {
                name: "Measure",
                name_en: "online measurement",
                content: [{
                    name: "Measure",
                    name_en: "measurement",
                    thumbnail: "measureHandler.jpg",
                    fileName: "measureHandler"
                }]
            }
        }
    },
    "analysis": {
        name: "analysis",
        name_en: "analysis",
        content: {
            "hypsometric": {
                name: "Analysis",
                name_en: "hypsometric",
                content: [{
                        name: "Submerged analysis (model)",
                        name_en: "flood",
                        thumbnail: "flood.jpg",
                        fileName: "flood"
                    },
                    {
                        name: "Submerged analysis (terrain)",
                        name_en: "floodex",
                        thumbnail: "floodex.jpg",
                        fileName: "floodex"
                    }
                ]
            },
            "3D anylysis": {
                name: "3D analysis",
                name_en: "3D anylysis",
                content: [{
                        name: "Visual analysis",
                        name_en: "sightline",
                        thumbnail: "sightline.jpg",
                        fileName: "sightline"
                    },
                    {
                        name: "Visual domain analysis",
                        name_en: "viewshed3D",
                        thumbnail: "viewshed3D.jpg",
                        fileName: "viewshed3D"
                    },
                    {
                        name: "Shadow analysis",
                        name_en: "shadowQuery",
                        thumbnail: "shadowQuery.jpg",
                        fileName: "shadowQuery"
                    },
                    {
                        name: "Skyline Analysis",
                        name_en: "skyline",
                        thumbnail: "skyline.jpg",
                        fileName: "skyline"
                    },
                    {
                        name: "Profile analysis",
                        name_en: "profile",
                        thumbnail: "profile.jpg",
                        fileName: "profile"
                    },
                    {
                        name: "Video delivery",
                        name_en: "projectionImage",
                        thumbnail: "RTSPprojectionImage.jpg",
                        fileName: "projectionImage"
                    },
                    /*{
                        name: "RTSP video delivery",
                        name_en: "RTSPprojectionImage",
                        thumbnail: "RTSPprojectionImage.jpg",
                        fileName: "RTSP"
                    },*/
                    {
                        name: "Crop",
                        name_en: "clip",
                        thumbnail: "clip.jpg",
                        fileName: "clip"
                    },
                    {
                        name: "Crop",
                        name_en: "clipbox",
                        thumbnail: "clipbox.jpg",
                        fileName: "clipbox"
                    },
                    {
                        name: "Regional cropping",
                        name_en: "clipCross",
                        thumbnail: "clipCross.jpg",
                        fileName: "clipCross"
                    },
                    {
                        name: "Clip Polygon",
                        name_en: "clipPolygon",
                        thumbnail: "clipPolygon.jpg",
                        fileName: "clipPolygon"
                    },
                    {
                        name: "Clip by Id",
                        name_en: "clipById",
                        thumbnail: "clipById.jpg",
                        fileName: "clipById"
                    },
                    {
                        name: "Clip With Seal",
                        name_en: "clipWithSeal",
                        thumbnail: "clipWithSeal.jpg",
                        fileName: "clipWithSeal"
                    },
                    {
                        name: "Terrain Slope Analysis",
                        name_en: "terrainSlopeAnalysis",
                        thumbnail: "terrainSlopeAnalysis.jpg",
                        fileName: "terrainSlopeAnalysis"
                    },
                    {
                        name: "Edut Terrain",
                        name_en: "digTerrain",
                        thumbnail: "digTerrain.jpg",
                        fileName: "digTerrain"
                    },
                    {
                        name: "Terrain excavation",
                        name_en: "modifyTerrain",
                        thumbnail: "modifyTerrain.jpg",
                        fileName: "modifyTerrain"
                    },
                    {
                        name: "Back Line Analysis",
                        name_en: "backLineAnalysis",
                        thumbnail: "backLineAnalysis.jpg",
                        fileName: "backLineAnalysis"
                    },
                    {
                        name: "Limit Height Analysis",
                        name_en: "limitHeightAnalysis",
                        thumbnail: "limitHeightAnalysis.jpg",
                        fileName: "limitHeightAnalysis"
                    },
                    {
                        name: "Online Analysis",
                        name_en: "onLineAnalysis",
                        thumbnail: "onLineAnalysis.jpg",
                        fileName: "onLineAnalysis"
                    },
                    {
                        name: "Service Area Analysis",
                        name_en: "serviceAreaAnalysis",
                        thumbnail: "serviceAreaAnalysis.jpg",
                        fileName: "serviceAreaAnalysis"
                    }
                ]
            }
            /*,
                        "2D analysis":{
                            name: "Two-dimensional spatial analysis",
                            name_en: "2D anylysis",
                            content:[
                                {
                                    name: "Profile analysis",
                                    name_en: "profileAnalyze",
                                    thumbnail: "profileAnalyze.jpg",
                                    fileName: "profileAnalyze"
                                },
                                {
                                    name: "Buffer analysis",
                                    name_en: "bufferAnalyze",
                                    thumbnail: "bufferAnalyze.jpg",
                                    fileName: "bufferAnalyze"

                                },
                                {
                                    name: "Overlay analysis",
                                    name_en: "overlayAnalyze",
                                    thumbnail: "overlayAnalyze.jpg",
                                    fileName: "overlayAnalyze"
                                },
                                {
                                    name: "Raster Operatopm",
                                    name_en: "mathExpression",
                                    thumbnail: "mathExpression.jpg",
                                    fileName: "mathExpression"
                                },
                                {
                                    name: "Topographic curvature",
                                    name_en: "terrainCurvature",
                                    thumbnail: "terrainCurvature.jpg",
                                    fileName: "terrainCurvature"
                                }
                            ]
                        }*/
        }
    },
    "fly": {
        name: "flight",
        name_en: "fly",
        content: {
            "fly": {
                name: "flight",
                name_en: "fly",
                content: [{
                    name: "Flying along the line",
                    name_en: "flyRoute",
                    thumbnail: "flyRoute.jpg",
                    fileName: "flyRoute"
                }]
            }
        }
    },
    "KMLAndModel": {
        name: "KML& model",
        name_en: "KML&model",
        content: {
            "model-edit": {
                name: "Model editing",
                name_en: "model edit",
                content: [{
                    name: "Model editing (rotation, translation, scaling)",
                    name_en: "KML_edit",
                    thumbnail: "KML_edit.jpg",
                    fileName: "KML_edit"
                }]
            },
            "animation-model": {
                name: "Animated model",
                name_en: "animation model",
                content: [{
                        name: "Hanging tower",
                        name_en: "KML_crane",
                        thumbnail: "KML_crane.jpg",
                        fileName: "KML_crane"
                    },
                    {
                        name: "gltf",
                        name_en: "gltf",
                        thumbnail: "gltf.JPG",
                        fileName: "gltf"
                    }
                ]
            },
            "node-animation": {
                name: "Node animation",
                name_en: "node animation",
                content: [{
                    name: "Trolley movement",
                    name_en: "KML_car",
                    thumbnail: "KML_car.jpg",
                    fileName: "KML_car"
                }]
            },
            "line-snap-to-ground": {
                name: "Clamp to object/ground",
                name_en: "line snap to ground",
                content: [{
                        name: "Beijing subway route and site marking",
                        name_en: "KML_beijing",
                        thumbnail: "KML_beijing.jpg",
                        fileName: "KML_beijing"
                    },
                    {
                        name: "Siguniang Mountain Hiking Route",
                        name_en: "KML_route",
                        thumbnail: "KML_route.jpg",
                        fileName: "KML_route"
                    },
                ]
            },
            "polygon-snap-to-ground": {
                name: "Paste/post object",
                name_en: "polygon snap to ground",
                content: [{
                        name: "Vector surface",
                        name_en: "Polygon",
                        thumbnail: "Polygon.jpg",
                        fileName: "Polygon"
                    },
                    {
                        name: "Vector surface stretching",
                        name_en: "extrude",
                        thumbnail: "extrude.jpg",
                        fileName: "extrude"
                    }
                ]
            }
        }
    },
    "online-draw": {
        name: "Vector surface stretching",
        name_en: "online draw",
        content: {
            "point-polyline-polygon-drawing": {
                name: "Vector surface stretching",
                name_en: "point/polyline/polygon drawing",
                content: [{
                        name: "Draw a dotted line",
                        name_en: "drawHandler",
                        thumbnail: "drawHandler.jpg",
                        fileName: "drawHandler"
                    },
                    {
                        name: "Line type",
                        name_en: "Polyline",
                        thumbnail: "Polyline.jpg",
                        fileName: "Polyline"
                    }
                ]
            },
            "geometry": {
                name: "Geometry object",
                name_en: "geometry",
                content: [{
                    name: "Geometry object",
                    name_en: "Geometry",
                    thumbnail: "Geometry.jpg",
                    fileName: "Geometry"
                }]
            },
            "online-symbol": {
                name: "Online symbol",
                name_en: "online symbol",
                content: [{
                    name: "Add a small piece",
                    name_en: "addSymbols",
                    thumbnail: "addSymbols.jpg",
                    fileName: "addSymbols"
                }]
            }
        }
    },
    "visualization": {
        name: "Visualization",
        name_en: "visualization",
        content: {
            "air-quality": {
                name: "air quality",
                name_en: "air quality",
                content: [{
                    name: "Global real-time air quality status",
                    name_en: "aqi",
                    thumbnail: "aqi.jpg",
                    fileName: "aqi"
                }]
            },
            /*"air-direction-map": {
                name: "Wind direction map",
                name_en: "air direction map",
                content: [
                    {
                        name: "Wind map",
                        name_en: "Wind map",
                        thumbnail: "windmap.jpg",
                        fileName: "windmap"
                    }
                ]
            },*/
            "split-comparation": {
                name: "Rolling curtain contrast",
                name_en: "split comparation",
                content: [{
                        name: "Light data roller blind contrast",
                        name_en: "Nightlight",
                        thumbnail: "Nightlight.jpg",
                        fileName: "Nightlight"
                    },
                    {
                        name: "Light data roller blind contrast",
                        name_en: "rollerShutter",
                        thumbnail: "rollerShutter.jpg",
                        fileName: "rollerShutter"
                    }
                ]
            },
            "time-space-effect": {
                name: "Time and space effect",
                name_en: "time&space effect",
                content: [{
                    name: "Time and space effects of global terrestrial temperature changes",
                    name_en: "LandTemChange",
                    thumbnail: "LandTemChange.jpg",
                    fileName: "LandTemChange"
                }]
            },
            "heat-map": {
                name: "Thermal map",
                name_en: "heat map",
                content: [{
                    name: "Thermal map",
                    name_en: "Project_heatmap",
                    thumbnail: "Project_heatmap.jpg",
                    fileName: "Project_heatmap"
                }]
            },
            "particle": {
                name: "Particle",
                name_en: "particle",
                content: [{
                        name: "flame",
                        name_en: "flame",
                        thumbnail: "flame.jpg",
                        fileName: "Particle System"
                    },
                    {
                        name: "Bird's Nest Torch",
                        name_en: "Particle System_Fire",
                        thumbnail: "Particle System_Fire.jpg",
                        fileName: "Particle System_Fire"
                    },
                    {
                        name: "Fountain",
                        name_en: "Particle System_fountain",
                        thumbnail: "Particle System_fountain.jpg",
                        fileName: "Particle System_fountain"
                    },
                    {
                        name: "Rainwater",
                        name_en: "Particle System_rain",
                        thumbnail: "Particle System_rain.jpg",
                        fileName: "Particle System_rain"
                    }
                ]
            },
            "stream-map": {
                name: "Stream Map",
                name_en: "stream map",
                content: [{
                        name: "Taxi flow",
                        name_en: "taxiFlow",
                        thumbnail: "taxiFlow.jpg",
                        fileName: "taxiFlow"
                    },
                    {
                        name: "Aircraft route dynamic visualization",
                        name_en: "Dynamic flight visualization",
                        thumbnail: "flightnew.jpg",
                        fileName: "flightnew"
                    },
                    {
                        name: "Population migration flow map",
                        name_en: "migration",
                        thumbnail: "migration.jpg",
                        fileName: "migration"
                    },
                    {
                        name: "Halo",
                        name_en: "polylingGlow",
                        thumbnail: "polylingGlow.jpg",
                        fileName: "polylineGlow"
                    },
                    {
                        name: "Scanning line",
                        name_en: "scanEffect",
                        thumbnail: "scanEffect.jpg",
                        fileName: "scanEffect"
                    },
                ]
            },
            "special-effect": {
                name: "Special Effect",
                name_en: "special effect",
                content: [{
                        name: "ScanLine",
                        name_en: "scanLine",
                        thumbnail: "scanLine.jpg",
                        fileName: "scanLine"
                    },
                    {
                        name: "TrailLine",
                        name_en: "trailLine",
                        thumbnail: "trailLine.jpg",
                        fileName: "airlinesTrailLines"
                    },
                    {
                        name: "Emission Texture",
                        name_en: "emissionTexture",
                        thumbnail: "emissionTexture.jpg",
                        fileName: "emissionTexture"
                    },
                    // {
                    //     name: "Car Lamp",
                    //     name_en: "carLamp",
                    //     thumbnail: "carLamp.jpg",
                    //     fileName: "carLamp"
                    // },
                    {
                        name: "Light Source",
                        name_en: "tx_lightSource",
                        thumbnail: "tx_lightSource.jpg",
                        fileName: "tx_lightSource"
                    },
                ]
            }
        }
    },
    "stereoscopic-show": {
        name: "Stereo display",
        name_en: "stereoscopic show",
        content: {
            "polarization": {
                name: "Polarized stereo",
                name_en: "polarization stereoscopic show",
                content: [{
                    name: "Polarized stereo",
                    name_en: "polarizedStereoscopic",
                    thumbnail: "polarizedStereoscopic.jpg",
                    fileName: "polarizedStereoscopic"
                }]
            }
        }
    },
    "plot": {
        name: "3D Plotting",
        name_en: "3D plotting",
        content: {
            "plotting": {
                name: "Plotting",
                name_en: "plotting",
                content: [{
                        name: "Dynamic plot",
                        name_en: "dynamic plot",
                        thumbnail: "plot_dynamicPlot.jpg",
                        fileName: "plot_dynamicPlot"
                    },
                    {
                        name: "Modify symbol style",
                        name_en: "modify symbol style",
                        thumbnail: "plot_modifySymbolStyle.jpg",
                        fileName: "plot_modifySymbolStyle"
                    },
                    {
                        name: "Default symbol style",
                        name_en: "default symbol style",
                        thumbnail: "plot_defaultStyle.jpg",
                        fileName: "plot_defaultStyle"
                    },
                    {
                        name: "Extend symbol properties",
                        name_en: "extend symbol properties",
                        thumbnail: "plot_symbolExtendProperty.jpg",
                        fileName: "plot_symbolExtendProperty"
                    },
                    {
                        name: "Annotations",
                        name_en: "annotations",
                        thumbnail: "plot_Annotations.jpg",
                        fileName: "plot_Annotations"
                    },
                    {
                        name: "Load symbol library",
                        name_en: "load symbol library",
                        thumbnail: "plot_loadSymbolLib.jpg",
                        fileName: "plot_loadSymbolLib"
                    },
                    {
                        name: "Query symbol",
                        name_en: "query symbol",
                        thumbnail: "plot_querySymbolLib.jpg",
                        fileName: "plot_querySymbolLib"
                    }

                ]
            },
            "Situational inference": {
                name: "̬Situational inference",
                name_en: "situational inference",
                content: [{
                        name: "̬Situational inference",
                        name_en: "situational inference",
                        thumbnail: "plot_plotGOAnimation.jpg",
                        fileName: "plot_plotGOAnimation"
                    },
                    {
                        name: "̬Situational map superposition",
                        name_en: "situational map superposition",
                        thumbnail: "plot_addfile.jpg",
                        fileName: "plot_addfile"
                    },
                    {
                        name: "Plot symbol file upload and download",
                        name_en: "plot symbol file upload and download",
                        thumbnail: "plot_filetransfer.jpg",
                        fileName: "plot_filetransfer"
                    }

                ]
            },
            "Layer operation": {
                name: "Layer operation",
                name_en: "layer operation",
                content: [

                    {
                        name: "Layer operations",
                        name_en: "layer operations",
                        thumbnail: "plot_operPlottingLayer.jpg",
                        fileName: "plot_operPlottingLayer"
                    },
                    {
                        name: "Layer editing",
                        name_en: "layer editing",
                        thumbnail: "plot_editPlottingLayer.jpg",
                        fileName: "plot_editPlottingLayer"
                    }

                ]
            }
        }
    }
};

/**
 *Key value: the key value or fileName value configured for exampleConfig
 *      (The key value is the intermediate node, and the leaf node is the fileName value)
 *Value value: fontawesome font icon name
 *No stratification
 */
var sideBarIconConfig = {
    "online-base-map": "fa-globe",
    "Scene": "fa-university",
    "fly": "fa-send",
    "layer": "fa-object-group",
    "KMLAndModel": "fa-cubes",
    "online-draw": "fa-edit",
    "search": "fa-search",
    "measurement": "fa-arrows-v",
    "analysis": "fa-map",
    "visualization": "fa-eye",
    "stereoscopic-show": "fa-cube",
    "plot": "fa-pencil"
};

/**
 *Key value: the key value configured for exampleConfig
 *Value value: fontawesome font icon name
 *The difference with sideBarIconConfig: sideBarIconConfig includes icons for all hierarchical directories in the sidebar, exampleIconConfig only includes icons for the first level title
 */
var exampleIconConfig = {
    "online-base-map": "fa-globe",
    "Scene": "fa-university",
    "fly": "fa-send",
    "layer": "fa-object-group",
    "KMLAndModel": "fa-cubes",
    "online-draw": "fa-edit",
    "search": "fa-search",
    "measurement": "fa-arrows-v",
    "analysis": "fa-map",
    "visualization": "fa-eye",
    "stereoscopic-show": "fa-cube",
    "plot": "fa-pencil"
};
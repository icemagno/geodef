<?xml version="1.0" encoding="UTF-8"?>
<sld:StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml" version="1.0.0">
  <sld:UserLayer>
    <sld:LayerFeatureConstraints>
      <sld:FeatureTypeConstraint/>
    </sld:LayerFeatureConstraints>
    <sld:UserStyle>
      <sld:Title/>
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        <sld:FeatureTypeName>Feature</sld:FeatureTypeName>
        <sld:Rule>
          <sld:MinScaleDenominator>7500</sld:MinScaleDenominator>
          <sld:RasterSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>grid</ogc:PropertyName>
            </sld:Geometry>
				<ColorMap type="ramp">
                        <ColorMapEntry color="#00BFBF" quantity="-100.0" opacity="0.0" />
						<ColorMapEntry color="#00FF00" quantity="920.0"  opacity="0.0"/>
						<ColorMapEntry color="#00FF00" quantity="920.0" opacity="1.0"/>
						<ColorMapEntry color="#FFFF00" quantity="1940.0" opacity="1.0"/>
						<ColorMapEntry color="#FFFF00" quantity="1940.0" opacity="1.0"/>
						<ColorMapEntry color="#FF7F00" quantity="2960.0" opacity="1.0"/>
						<ColorMapEntry color="#FF7F00" quantity="2960.0" opacity="1.0"/>
						<ColorMapEntry color="#BF7F3F" quantity="3980.0" opacity="1.0"/>
						<ColorMapEntry color="#BF7F3F" quantity="3980.0" opacity="1.0"/>
						<ColorMapEntry color="#141514" quantity="5000.0" opacity="1.0"/>
				</ColorMap>
          </sld:RasterSymbolizer>
        </sld:Rule>
        
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:UserLayer>
</sld:StyledLayerDescriptor>


						

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
          <sld:MinScaleDenominator>3000</sld:MinScaleDenominator>
          <sld:RasterSymbolizer>
            <sld:Geometry>
              <ogc:PropertyName>grid</ogc:PropertyName>
            </sld:Geometry>
				<ColorMap type="ramp">
                        <ColorMapEntry color="#000000" opacity="0.0" quantity="0.0"/>
						<ColorMapEntry color="#211F1F" quantity="50" label="label" opacity="1"/>
						<ColorMapEntry color="#EE0F0F" quantity="100" label="label" opacity="1"/>
						<ColorMapEntry color="#AAAAAA" quantity="200" label="label" opacity="1"/>
						<ColorMapEntry color="#6FEE4F" quantity="250" label="label" opacity="1"/>
						<ColorMapEntry color="#3ECC1B" quantity="300" label="label" opacity="1"/>
						<ColorMapEntry color="#886363" quantity="350" label="label" opacity="1"/>
						<ColorMapEntry color="#5194CC" quantity="400" label="label" opacity="1"/>
						<ColorMapEntry color="#2C58DD" quantity="450" label="label" opacity="1"/>
						<ColorMapEntry color="#DDB02C" quantity="600" label="label" opacity="1"/>
				</ColorMap>
          </sld:RasterSymbolizer>
        </sld:Rule>
        
      </sld:FeatureTypeStyle>
    </sld:UserStyle>
  </sld:UserLayer>
</sld:StyledLayerDescriptor>

<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd"
  xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <NamedLayer>
    <Name></Name>
    <UserStyle>
      <Title>Soundg</Title>
      <FeatureTypeStyle>
        <Rule>
          <Title>Soundg</Title>
			   <TextSymbolizer>
				 <Label>
				   <ogc:PropertyName>depth</ogc:PropertyName>
				 </Label>
				 <Font>
				   <CssParameter name="font-family">Arial</CssParameter>
				   <CssParameter name="font-size">9</CssParameter>
				   <CssParameter name="font-style">normal</CssParameter>
				 </Font>
				 <Fill>
				   <CssParameter name="fill">#000000</CssParameter>
				 </Fill>
			   </TextSymbolizer>
        </Rule>

      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
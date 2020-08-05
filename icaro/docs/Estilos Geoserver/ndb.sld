<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor 
  xmlns="http://www.opengis.net/sld" 
  xmlns:ogc="http://www.opengis.net/ogc" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" 
  xmlns:xlink="http://www.w3.org/1999/xlink" 
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" 
  xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <se:Name>ndb</se:Name>
    <UserStyle>
      <se:Name>ndb</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#ffffff</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#6f2b91</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>8</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:Mark>
                <se:WellKnownName>circle</se:WellKnownName>
                <se:Fill>
                  <se:SvgParameter name="fill">#6f2b91</se:SvgParameter>
                </se:Fill>
                <se:Stroke>
                  <se:SvgParameter name="stroke">#6f2b91</se:SvgParameter>
                </se:Stroke>
              </se:Mark>
              <se:Size>3</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>id</ogc:PropertyName>
            </Label>
            <Font>
              <SvgParameter name="font-family">Arial</SvgParameter>
              <SvgParameter name="font-size">10</SvgParameter>
              <SvgParameter name="font-style">normal</SvgParameter>
              <SvgParameter name="font-weight">bold</SvgParameter>
            </Font>
            <LabelPlacement>
             <PointPlacement>
              <AnchorPoint>
              <AnchorPointX>0.5</AnchorPointX>
              <AnchorPointY>0.0</AnchorPointY>
              </AnchorPoint>
              <Displacement>
               <DisplacementX>0</DisplacementX>
               <DisplacementY>8</DisplacementY>
             </Displacement> 
             </PointPlacement>
            </LabelPlacement>
            <Halo>
             <Radius>2</Radius>
             <Fill>
              <SvgParameter name="fill">#ffffff</SvgParameter>
             </Fill>
            </Halo>
            <Fill>
                <SvgParameter name="fill">#000000</SvgParameter>
            </Fill>
          </TextSymbolizer>          
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>

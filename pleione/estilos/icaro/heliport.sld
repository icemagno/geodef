<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor 
    xmlns="http://www.opengis.net/sld" 
    xmlns:ogc="http://www.opengis.net/ogc" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" 
    xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <Name>Airport</Name>
    <UserStyle>
      <Name>Airport</Name>
      <FeatureTypeStyle>
        <Rule>
                    <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <SvgParameter name="fill">#ffffff</SvgParameter>
                </Fill>
                <Stroke>
                  <SvgParameter name="stroke">#6f2b91</SvgParameter>
                  <SvgParameter name="stroke-width">2</SvgParameter>
                </Stroke>
              </Mark>
              <Size>12</Size>
            </Graphic>
          </PointSymbolizer>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>line</WellKnownName>
                <Fill>
                  <SvgParameter name="fill">#ffffff</SvgParameter>
                  <SvgParameter name="fill-opacity">0.00</SvgParameter>
                </Fill>
                <Stroke>
                  <SvgParameter name="stroke">#6f2b91</SvgParameter>
                  <SvgParameter name="stroke-width">1</SvgParameter>
                </Stroke>
              </Mark>
              <Size>6</Size>
              <Displacement>
                <DisplacementX>-2</DisplacementX>
                <DisplacementY>0</DisplacementY>
              </Displacement>
            </Graphic>
          </PointSymbolizer>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>line</WellKnownName>
                <Fill>
                  <SvgParameter name="fill">#ff0000</SvgParameter>
                  <SvgParameter name="fill-opacity">0.00</SvgParameter>
                </Fill>
                <Stroke>
                  <SvgParameter name="stroke">#6f2b91</SvgParameter>
                  <SvgParameter name="stroke-width">1</SvgParameter>
                </Stroke>
              </Mark>
              <Size>4</Size>
              <Rotation>
                <ogc:Literal>90</ogc:Literal>
              </Rotation>
            </Graphic>
          </PointSymbolizer>
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>line</WellKnownName>
                <Fill>
                  <SvgParameter name="fill">#ff0000</SvgParameter>
                  <SvgParameter name="fill-opacity">0.00</SvgParameter>
                </Fill>
                <Stroke>
                  <SvgParameter name="stroke">#6f2b91</SvgParameter>
                  <SvgParameter name="stroke-width">1</SvgParameter>
                </Stroke>
              </Mark>
              <Size>6</Size>
              <Displacement>
                <DisplacementX>2</DisplacementX>
                <DisplacementY>0</DisplacementY>
              </Displacement>
            </Graphic>
          </PointSymbolizer>
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
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>

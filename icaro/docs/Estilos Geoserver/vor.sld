<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor 
    xmlns="http://www.opengis.net/sld" 
    xmlns:ogc="http://www.opengis.net/ogc" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1.1.0" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" 
    xmlns:se="http://www.opengis.net/se">
  <NamedLayer>
    <Name>VOR</Name>
    <UserStyle>
      <Name>VOR</Name>
      <FeatureTypeStyle>
        <Rule>
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:type="simple" xlink:href="VOR.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>30</Size>
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

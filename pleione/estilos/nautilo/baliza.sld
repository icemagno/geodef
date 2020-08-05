<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" version="1.1.0" xmlns:se="http://www.opengis.net/se" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink">
  <NamedLayer>
    <se:Name>balizaPoint</se:Name>
    <UserStyle>
      <se:Name>balizaPoint</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>Baliza Lateral - BCNLAT</se:Name>
          <se:Description>
            <se:Title>Baliza Lateral - BCNLAT</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Lateral BCNLAT</se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Lateral BCNLAT</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="LatticerBeacon1.svg"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <se:Size>24</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Cardinal - BCNCAR</se:Name>
          <se:Description>
            <se:Title>Cardinal - BCNCAR</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Cardinal BCNCAR</se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Cardinal BCNCAR</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="Beacon_Cardinal_West.svg"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <se:Size>24</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Baliza Perigo Isolado - BCNISD</se:Name>
          <se:Description>
            <se:Title>Baliza Perigo Isolado - BCNISD</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Perigo isolado BCNISD' </se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Perigo isolado BCNISD</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="TowerBeacon_Red.svg"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <se:Size>48</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Baliza Águas seguras - BCNSAW</se:Name>
          <se:Description>
            <se:Title>Baliza Águas seguras - BCNSAW</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Águas seguras BCNSAW' </se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Águas seguras BCNSAW</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="Beacon_Green_CylindricalTM.svg"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <se:Size>48</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Baliza Propósito Especial - BCNSPP</se:Name>
          <se:Description>
            <se:Title>Baliza Propósito Especial - BCNSPP</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Propósito especial BCNSPP' </se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Propósito especial BCNSPP</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="Stake.svg"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <se:Size>56</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd" version="1.1.0" xmlns:se="http://www.opengis.net/se" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink">
  <NamedLayer>
    <se:Name>boia</se:Name>
    <UserStyle>
      <se:Name>boia</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>Boia Lateral - BOYLAT</se:Name>
          <se:Description>
            <se:Title>Boia Lateral - BOYLAT</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Lateral BOYLAT</se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Lateral BOYLAT</ogc:Literal>
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
          <se:Name>Cardinal - BOYCAR</se:Name>
          <se:Description>
            <se:Title>Cardinal - BOYCAR</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Cardinal BOYCAR</se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Cardinal BOYCAR</ogc:Literal>
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
          <se:Name>Boia Perigo Isolado - BOYISD</se:Name>
          <se:Description>
            <se:Title>Boia Perigo Isolado - BOYISD</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Perigo isolado BOYISD' </se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Perigo isolado BOYISD</ogc:Literal>
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
          <se:Name>Boia Águas seguras - BOYSAW</se:Name>
          <se:Description>
            <se:Title>Boia Águas seguras - BOYSAW</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Águas seguras BOYSAW' </se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Águas seguras BOYSAW</ogc:Literal>
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
          <se:Name>Boia Propósito Especial - BOYSPP</se:Name>
          <se:Description>
            <se:Title>Boia Propósito Especial - BOYSPP</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Propósito especial BOYSPP' </se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Propósito especial BOYSPP</ogc:Literal>
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
        <se:Rule>
          <se:Name>Instalação - BOYINB</se:Name>
          <se:Description>
            <se:Title>Instalação - BOYINB</se:Title>
            <se:Abstract> "categoriadesinal"  =  'Instalação BOYINB' </se:Abstract>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>categoriadesinal</ogc:PropertyName>
              <ogc:Literal>Instalação BOYINB</ogc:Literal>
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
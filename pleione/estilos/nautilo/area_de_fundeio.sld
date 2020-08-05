<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:se="http://www.opengis.net/se" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ogc="http://www.opengis.net/ogc" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <se:Name>area_de_fundeio</se:Name>
    <UserStyle>
      <se:Name>area_de_fundeio</se:Name>
      <se:FeatureTypeStyle>
        <se:Rule>
          <se:Name>Area_De_Fundeio_Tipo_Irrestrito</se:Name>
          <se:Description>
            <se:Title>Area_De_Fundeio_Tipo_Irrestrito</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipoareadefundeio</ogc:PropertyName>
              <ogc:Literal>Fundeio irrestrito</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:PointSymbolizer>
            <se:Graphic>
              <se:ExternalGraphic>
                <se:OnlineResource xlink:type="simple" xlink:href="Anchorage_Area.svg"/>
                <se:Format>image/svg+xml</se:Format>
              </se:ExternalGraphic>
              <se:Size>15</se:Size>
            </se:Graphic>
          </se:PointSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Area_De_Fundeio_Tipo_Fundeio_De_Navios_Tanque</se:Name>
          <se:Description>
            <se:Title>Area_De_Fundeio_Tipo_Fundeio_De_Navios_Tanque</se:Title>            
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>tipoareadefundeio</ogc:PropertyName>
              <ogc:Literal>Fundeio de navios tanque</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
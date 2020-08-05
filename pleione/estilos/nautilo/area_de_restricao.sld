<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:se="http://www.opengis.net/se" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ogc="http://www.opengis.net/ogc" version="1.1.0" xmlns:xlink="http://www.w3.org/1999/xlink" xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.1.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <se:Name>area_de_fundeio</se:Name>
    <UserStyle>
      <se:Name>area_de_fundeio</se:Name>
      <se:FeatureTypeStyle>
        <!--INICIO REGRA DE POLIGONO-->
        <se:Rule>
          <se:Name>Area_De_Restricao_Tipo_de_Restricao</se:Name>
          <se:Description>
            <se:Title>Area a ser evitada - IMO</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>restricao</ogc:PropertyName>
              <ogc:Literal>Area a ser evitada - IMO</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                    <se:OnlineResource xlink:type="simple" xlink:href="minor-light.svg"/>
                	<se:Format>image/svg+xml</se:Format>
                    <se:MarkIndex>84</se:MarkIndex>
                    <se:Fill>
                      <se:SvgParameter name="fill">#0ef234</se:SvgParameter>
                    </se:Fill>
                  </se:Mark>
                  <se:Size>2</se:Size>
                </se:Graphic>
                <se:Gap>
                  <ogc:Literal>19</ogc:Literal>
                </se:Gap>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Area_De_Restricao_Tipo_de_Restricao</se:Name>
          <se:Description>
            <se:Title>Entrada proibida</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>restricao</ogc:PropertyName>
              <ogc:Literal>Entrada proibida</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                    <se:OnlineResource xlink:type="simple" xlink:href="minor-light.svg"/>
                	<se:Format>image/svg+xml</se:Format>
                    <se:MarkIndex>84</se:MarkIndex>
                    <se:Fill>
                      <se:SvgParameter name="fill">#a8314d</se:SvgParameter>
                    </se:Fill>
                  </se:Mark>
                  <se:Size>2</se:Size>
                </se:Graphic>
                <se:Gap>
                  <ogc:Literal>19</ogc:Literal>
                </se:Gap>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Area_De_Restricao_Tipo_de_Restricao</se:Name>
          <se:Description>
            <se:Title>Pesca é restrita</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>restricao</ogc:PropertyName>
              <ogc:Literal>Pesca restrita</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                    <se:OnlineResource xlink:type="simple" xlink:href="minor-light.svg"/>
                	<se:Format>image/svg+xml</se:Format>
                    <se:MarkIndex>84</se:MarkIndex>
                    <se:Fill>
                      <se:SvgParameter name="fill">#22207d</se:SvgParameter>
                    </se:Fill>
                  </se:Mark>
                  <se:Size>2</se:Size>
                </se:Graphic>
                <se:Gap>
                  <ogc:Literal>19</ogc:Literal>
                </se:Gap>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <se:Rule>
          <se:Name>Area_De_Restricao_Tipo_de_Restricao</se:Name>
          <se:Description>
            <se:Title>Fundeio proibido</se:Title>
          </se:Description>
          <ogc:Filter xmlns:ogc="http://www.opengis.net/ogc">
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>restricao</ogc:PropertyName>
              <ogc:Literal>Fundeio proibido</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <se:LineSymbolizer>
            <se:Stroke>
              <se:GraphicStroke>
                <se:Graphic>
                  <se:Mark>
                    <se:OnlineResource xlink:type="simple" xlink:href="minor-light.svg"/>
                	<se:Format>image/svg+xml</se:Format>
                    <se:MarkIndex>84</se:MarkIndex>
                    <se:Fill>
                      <se:SvgParameter name="fill">#cccf19</se:SvgParameter>
                    </se:Fill>
                  </se:Mark>
                  <se:Size>2</se:Size>
                </se:Graphic>
                <se:Gap>
                  <ogc:Literal>19</ogc:Literal>
                </se:Gap>
              </se:GraphicStroke>
            </se:Stroke>
          </se:LineSymbolizer>
        </se:Rule>
        <!--FIM REGRA DE POLIGONO-->
      </se:FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>
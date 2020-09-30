<?xml version="1.0" encoding="UTF-8"?><sld:StyledLayerDescriptor xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:gml="http://www.opengis.net/gml" xmlns:ogc="http://www.opengis.net/ogc" version="1.0.0">
  <sld:NamedLayer>
    <sld:Name>Default Styler</sld:Name>
    <sld:UserStyle>
      <sld:Name>Default Styler</sld:Name>
      
      <sld:FeatureTypeStyle>
        <sld:Name>name</sld:Name>
        
        <sld:Rule>
          <Name>2</Name>
          <Title>2</Title>
          <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:Function name="GeometryType">
	                <ogc:PropertyName>the_geom</ogc:PropertyName>
                </ogc:Function>
                <ogc:Literal>Polygon</ogc:Literal>
              </ogc:PropertyIsEqualTo>            
          </ogc:Filter> 
          
          <PolygonSymbolizer>
            <Fill>
              <sld:CssParameter name="fill">
                <ogc:Function name="Recode">
                   <ogc:PropertyName>gridcode</ogc:PropertyName>

                   <ogc:Literal>2</ogc:Literal>
                   <ogc:Literal>#dbffff</ogc:Literal>

                   <ogc:Literal>3</ogc:Literal>
                   <ogc:Literal>#c1f7fd</ogc:Literal>

                   <ogc:Literal>4</ogc:Literal>
                   <ogc:Literal>#a6f1fc</ogc:Literal>

                   <ogc:Literal>5</ogc:Literal>
                   <ogc:Literal>#92dff8</ogc:Literal>

                   <ogc:Literal>6</ogc:Literal>
                   <ogc:Literal>#82d2f5</ogc:Literal>

                   <ogc:Literal>7</ogc:Literal>
                   <ogc:Literal>#72c6f1</ogc:Literal>

                   <ogc:Literal>8</ogc:Literal>
                   <ogc:Literal>#63b6ec</ogc:Literal>

                   <ogc:Literal>9</ogc:Literal>
                   <ogc:Literal>#57a3e7</ogc:Literal>

                   <ogc:Literal>10</ogc:Literal>
                   <ogc:Literal>#4e92e0</ogc:Literal>

                   <ogc:Literal>11</ogc:Literal>
                   <ogc:Literal>#4283da</ogc:Literal>

                   <ogc:Literal>12</ogc:Literal>
                   <ogc:Literal>#3a76d3</ogc:Literal>

                   <ogc:Literal>13</ogc:Literal>
                   <ogc:Literal>#3067cb</ogc:Literal>

                   <ogc:Literal>14</ogc:Literal>
                   <ogc:Literal>#285cc1</ogc:Literal>

                   <ogc:Literal>15</ogc:Literal>
                   <ogc:Literal>#214fb7</ogc:Literal>

                   <ogc:Literal>16</ogc:Literal>
                   <ogc:Literal>#1c43aa</ogc:Literal>

                   <ogc:Literal>17</ogc:Literal>
                   <ogc:Literal>#16399d</ogc:Literal>

                   <ogc:Literal>18</ogc:Literal>
                   <ogc:Literal>#122e8f</ogc:Literal>

                   <ogc:Literal>19</ogc:Literal>
                   <ogc:Literal>#0d247f</ogc:Literal>

                   <ogc:Literal>20</ogc:Literal>
                   <ogc:Literal>#091b6e</ogc:Literal>

                   <ogc:Literal>21</ogc:Literal>
                   <ogc:Literal>#051258</ogc:Literal>

                   <ogc:Literal>22</ogc:Literal>
                   <ogc:Literal>#020c44</ogc:Literal>

                   <ogc:Literal>23</ogc:Literal>
                   <ogc:Literal>#000530</ogc:Literal>

                   <ogc:Literal>24</ogc:Literal>
                   <ogc:Literal>#000525</ogc:Literal>

                   <ogc:Literal>25</ogc:Literal>
                   <ogc:Literal>#000520</ogc:Literal>

                   <ogc:Literal>26</ogc:Literal>
                   <ogc:Literal>#000515</ogc:Literal>

                   <ogc:Literal>27</ogc:Literal>
                   <ogc:Literal>#000000</ogc:Literal>

                </ogc:Function>
              </sld:CssParameter>
            </Fill>
          </PolygonSymbolizer>
        </sld:Rule>

        
        
      </sld:FeatureTypeStyle>
      
      
    </sld:UserStyle>
  </sld:NamedLayer>
</sld:StyledLayerDescriptor>


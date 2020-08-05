package br.mil.defesa.sisgeodef.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.misc.BlockedArea;
import br.mil.defesa.sisgeodef.misc.PoiRequest;
import br.mil.defesa.sisgeodef.misc.Point;
import br.mil.defesa.sisgeodef.misc.RouteRequest;

@Controller
public class RouteController {
	
	@Value("${openstreetmap.database.url}")
	private String osmDbUrl;   	

	@Value("${openstreetmap.database.user}")
	private String osmDbUser;   	
	
	@Value("${openstreetmap.database.password}")
	private String osmDbPassword;   	
	
	@Value("${routeserver.api.url}")
	private String routeApi;   	
	
	/*
	
                var criteria = '';
                var source = [];
                switch (featureId) {
                    case 'hospital-button':
                        criteria = "amenity = 'hospital'";
                        source.push('planet_osm_point');
                        break;
                    case 'clinic-button':
                        criteria = "amenity = 'clinic' or tags->'healthcare'='clinic'";
                        source.push('planet_osm_point');
                        break;
                    case 'blood-button':
                        criteria = "tags->'healthcare'='blood_donation' or tags->'healthcare'='blood_bank'";
                        source.push('planet_osm_point');
                        break;
                    case 'obras-button':
                        criteria = "bridge = 'viaduct'";
                        source.push('planet_osm_line');
                        break;
                    case 'ponte-button':
                        criteria = "bridge = 'yes'";
                        source.push('planet_osm_line');
                        break;
                    case 'rodoviaria-button':
                        criteria = "amenity = 'bus_station'";
                        source.push('planet_osm_point');
                        break;
                    case 'estadio-button':
                        criteria = "leisure = 'stadium'";
                        source.push('planet_osm_point');
                        break;
                    case 'police-button':
                        criteria = "amenity='police'";
                        source.push('planet_osm_point');
                        break;
                    case 'prf-button':
                        criteria = "amenity='police'";
                        source.push('planet_osm_point');
                        break;
                    case 'toll-button':
                        criteria = "barrier='toll_booth'";
                        source.push('planet_osm_point');
                        break;
                    case 'helipad-button':
                        criteria = "aeroway='helipad'";
                        source.push('planet_osm_polygon');
                        break;
                    case 'prison-button':
                        criteria = "amenity='prison'";
                        source.push('planet_osm_polygon');
                        source.push('planet_osm_point');
                        break;
                    case 'gasolina-button':
                        criteria = "amenity='fuel'";
                        source.push('planet_osm_point');
                        break;
                    case 'airport-button':
                        criteria = "aeroway='aerodrome'";
                        source.push('planet_osm_point');
                        source.push('planet_osm_polygon');
                        break;
                    case 'levelcrossing-button':
                        criteria = "railway='level_crossing'";
                        source.push('planet_osm_point');
                        break;
                    case 'school-button':
                        criteria = "amenity='college' or amenity='university' or amenity='school'";
                        source.push('planet_osm_point');
                        source.push('planet_osm_polygon');
                        break;
                    case 'railway-button':
                        criteria = "railway='rail'";
                        source.push('planet_osm_line');
                        break;
                    case 'port-button':
                        criteria = "(landuse='industrial' and tags->'industrial'='port') or landuse='harbour' or landuse='port'";
                        source.push('planet_osm_polygon');
                        break;
                    case 'trainstation-button':
                        criteria = "railway='station'";
                        source.push('planet_osm_polygon');
                        source.push('planet_osm_point');
                        break;
                }	
	
	*/
	
	@RequestMapping(value = "/getpoi", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE )
	public @ResponseBody String getPointsNearRoute( @RequestBody PoiRequest poiRequest ) {

        String sql = "SELECT CAST(row_to_json(fc) AS TEXT) AS featurecollection "
                + "FROM ( SELECT 'FeatureCollection' As type, array_to_json( array_agg( f ) ) As features "
                + "FROM (SELECT 'Feature' As type, "
                + "ST_AsGeoJSON( ST_Transform(way,4326) )::json As geometry, "
                + "row_to_json((SELECT l FROM (SELECT distance,name,admin_level,tags,operator,'" + poiRequest.getType() + "' as tipo) As l)) As properties "
                + "FROM pointscanner(?, ?, ?) As l where round(distance::numeric, 5) < ?) As f) as fc; ";

        String result = "";
		
        String url = osmDbUrl; 			// "jdbc:postgresql://10.5.115.122:5432/osm?ApplicationName=Atlas";
        String user = osmDbUser; 		// "postgres";
        String pass = osmDbPassword; 	// "admin";

        try (Connection connection = DriverManager.getConnection(url, user, pass); PreparedStatement preparedStatement = connection.prepareStatement( sql )) {

            preparedStatement.setString(1, poiRequest.getRoutegeom());
            preparedStatement.setString(2, poiRequest.getCriteria() );
            preparedStatement.setString(3, poiRequest.getSource() );
            preparedStatement.setInt(4, Integer.parseInt( poiRequest.getDistance() ) );

            try ( ResultSet resultSet = preparedStatement.executeQuery() ) {
                while ( resultSet.next() ) result = resultSet.getString("featurecollection");
            }
            
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
		
		return result;
	}
	
	
	
	
	@RequestMapping(value = "/computeroute", method = RequestMethod.POST,consumes = MediaType.APPLICATION_JSON_VALUE )
	public @ResponseBody String TestRouting( @RequestBody RouteRequest routeRequest ) {

		// http://osm.casnav.mb:8989/route?point=-22.863522%2C-43.566971&point=-22.912231%2C-43.072586&locale=pt-BR&vehicle=car&weighting=fastest&elevation=false&use_miles=false&layer=OpenStreetMap&points_encoded=false
		/*
			&block_area=lat, lon; //para pontos
			&block_area=lat, lon, radius; //para circunferências
			&block_area=lat, lon, lat,lon; //para retângulos	
		*/
		
		
		//ConfigModel cm = new ConfigService().getConfig();
		String alternatives = "";
		
		if ( routeRequest != null  ) {
			
			String chDisable = "";
			if ( routeRequest.getAlternatives() ) {
				chDisable = "&ch.disable=true";
				alternatives = "&algorithm=alternative_route" + chDisable +  "&alternative_route.max_share_factor=1&max_paths=2";
			}
			
			StringBuilder blocked = new StringBuilder();
			String blSep = "";
			if ( routeRequest.getBlockedAreas().size() > 0 )  {
				
				if( chDisable.equals("") ) {
					blocked.append( "&ch.disable=true" );
				}
				
				blocked.append("&block_area=");
				for( BlockedArea blockedArea : routeRequest.getBlockedAreas() ) {
					blocked.append( blSep );
					blocked.append( blockedArea.getLatitude() );
					blocked.append( "," );
					blocked.append( blockedArea.getLongitude() );
					blocked.append( "," );
					blocked.append( blockedArea.getRaio() );
					blSep = ";";
				}
			}
			
			StringBuilder sb = new StringBuilder();
			for( Point point : routeRequest.getPoints() ) {
				sb.append( "point=" );
				sb.append( point.getLatitude() );
				sb.append(",");
				sb.append( point.getLongitude() );
				sb.append("&");
			}

			
			String uri = routeApi + "route?" + sb.toString() + "locale=pt-BR&vehicle=car" + blocked.toString() + 
					"&weighting=fastest&elevation=false&use_miles=false&layer=OpenStreetMap&points_encoded=false" + alternatives;

			RestTemplate restTemplate = new RestTemplate();
			String responseBody;
			try {
				ResponseEntity<String> result = restTemplate.getForEntity(uri, String.class);
				responseBody = result.getBody().toString();
			} catch (HttpClientErrorException e) {
			    responseBody = e.getResponseBodyAsString();
			    String statusText = e.getStatusText();
			    
			    System.out.println( statusText );
			    
			}	
			
			/*
			if( result.getStatusCodeValue() == 200 ) {
				
				return rr;
			} else {
				return "error code " + result.getStatusCodeValue() ;
			}
			*/
			return responseBody;
		}
		
		return "error";
		
	}		
	
}

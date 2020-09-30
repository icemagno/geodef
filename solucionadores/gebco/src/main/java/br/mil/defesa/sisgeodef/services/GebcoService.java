package br.mil.defesa.sisgeodef.services;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Service
@EnableScheduling
public class GebcoService {

	@Autowired
    JdbcTemplate jdbcTemplate;		
	
    @Autowired
    private AuthService authService;


	@Value("${proxy.useProxy}")
	private Boolean useProxy; 	
	
	private Logger logger = LoggerFactory.getLogger(GebcoService.class);
	private int currentFeature = 0;
	private boolean working = false;
	
	@Scheduled(cron = "0/7 * * * * *") 
	public void doImport() {
		if (!working) {
			working = true;
			currentFeature++;
			String featureToImport = "gebco_poly_2014." + currentFeature;
			String feature = getFeature(featureToImport);
			insert( feature );
		}
	}
	
	
	private ClientHttpRequestFactory getClientHttpRequestFactory() {
	    int timeout = 15000;
	    HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
	    clientHttpRequestFactory.setConnectTimeout(timeout);
	    return clientHttpRequestFactory;
	}	

	
	private void insert( String feature ) {
		try {
			JSONObject collection = new JSONObject( feature );
			JSONArray features = collection.getJSONArray("features");
			JSONObject ft = features.getJSONObject(0);
			String id = ft.getString("id");
			JSONObject geometry = ft.getJSONObject("geometry");
			JSONObject properties = ft.getJSONObject("properties");
			JSONArray coordinates = geometry.getJSONArray("coordinates");
			
			String coord = coordinates.getJSONArray(0).toString().replace("],[", ")*(").replace(","," ").replace(")*(", ",").replace("[[[", "(((").replace("]]]", ")))"); 
			
			Integer objectid = properties.getInt("objectid");
			Integer gridcode = properties.getInt("gridcode");
			Long shape_leng = properties.getLong("shape_leng");
			Long shape_area = properties.getLong("shape_area");
			
			String sql = "INSERT INTO bat (id,featureid,the_geom,objectid,gridcode,shape_length,shape_area) VALUES (" +
				    currentFeature + ", '" + id + "', ST_GeomFromText('MULTIPOLYGON"+coord+"',4326)," +
				    objectid + "," + gridcode + "," + shape_leng + "," + shape_area + ");";
	
			System.out.println( sql );
			jdbcTemplate.update( sql );
			
			working = false;
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		
	}
	
	public String getFeature( String featureId ) {
		
		String sourceUrl = "http://osm.franken.de:8080/geoserver/gebco/ows?service=wfs"
				+ "&version=2.0.0"
				+ "&request=GetFeature"
				+ "&typeName=gebco:gebco_poly_2014"
				+ "&outputFormat=application/json"
				+ "&featureID=";
		
		String uri = sourceUrl +  featureId;

		String responseBody = "[]";
		
		RestTemplate restTemplate;
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate( getClientHttpRequestFactory() );
		}		
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
			responseBody = e.getResponseBodyAsString();
			String statusText = e.getStatusText();
			logger.info( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}
	

}

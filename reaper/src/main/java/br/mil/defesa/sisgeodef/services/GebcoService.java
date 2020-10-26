package br.mil.defesa.sisgeodef.services;

import java.math.BigDecimal;

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
	private int count = 2000;
	private int startIndex = 0;
	private boolean working = false;
	private long total = 0;
	private boolean stop = false;
	
	@Scheduled(cron = "0/7 * * * * *") 
	public void doImport() {
		if (!working && !stop ) {
			working = true;
			String features = getFeatures();
			insert( features );
		}
	}
	
	
	private ClientHttpRequestFactory getClientHttpRequestFactory() {
		int timeout = 50000 * 60 * 60;
	    HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
	    clientHttpRequestFactory.setConnectTimeout(timeout);
	    return clientHttpRequestFactory;
	}	

	
	private void insert( String fc ) {
		try {
			JSONObject collection = new JSONObject( fc );
			JSONArray features = collection.getJSONArray("features");
			int length = features.length();
			total = total + length;
			
			if( length == 0 ) {
				stop = true;
				logger.info("Requisição retornou 0. Processei um total de " + total + "registros.");
			} else {
				logger.info("Processei mais " + length + " registros. Total: " + total );
			}
			
			
			
			for( int x=0; x<length; x++ ) {
				JSONObject ft = features.getJSONObject( x );
				String id = ft.getString("id");
				JSONObject geometry = ft.getJSONObject("geometry");
				JSONObject properties = ft.getJSONObject("properties");
				Integer objectid = properties.getInt("objectid");
				Integer gridcode = properties.getInt("gridcode");
				float shape_leng = BigDecimal.valueOf( properties.getDouble("shape_leng") ).floatValue();
				float shape_area = BigDecimal.valueOf( properties.getDouble("shape_area") ).floatValue();
				
				String geomTextFromJson = geometry.toString();
				
				String sql = "INSERT INTO bat (id,featureid,the_geom,objectid,gridcode,shape_length,shape_area) VALUES (" +
						objectid + ", '" + id + "', ST_GeomFromGeoJSON('"+geomTextFromJson+"')," +
					    objectid + "," + gridcode + "," + shape_leng + "," + shape_area + ");";

				
				jdbcTemplate.update( sql );
				
			}
			
			startIndex = startIndex + count;
			working = false;
			
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		
	}
	
	public String getFeatures() {
		
		String sourceUrl = "http://osm.franken.de:8080/geoserver/gebco/ows?service=wfs"
				+ "&version=2.0.0"
				+ "&request=GetFeature"
				+ "&typeName=gebco:gebco_poly_2014"
				+ "&outputFormat=application/json"
				+ "&count=" + count
				+ "&startIndex=";
		
		// http://osm.franken.de:8080/geoserver/gebco/ows?service=WFS&version=2.0.0&request=GetFeature&typeName=gebco:gebco_poly_2014&count=2&startIndex=2&outputFormat=application%2Fjson
		
		String uri = sourceUrl +  startIndex;

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

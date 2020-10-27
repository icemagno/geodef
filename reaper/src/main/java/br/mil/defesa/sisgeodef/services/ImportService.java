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
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Service
public class ImportService {

	@Autowired
    JdbcTemplate jdbcTemplate;		
	
    @Autowired
    private AuthService authService;


	@Value("${proxy.useProxy}")
	private Boolean useProxy; 	
	
	private Logger logger = LoggerFactory.getLogger(ImportService.class);
	
	private ClientHttpRequestFactory getClientHttpRequestFactory() {
		int timeout = 50000 * 60 * 60;
	    HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
	    clientHttpRequestFactory.setConnectTimeout(timeout);
	    return clientHttpRequestFactory;
	}	

	
	public synchronized void insert( JSONArray features, String userCpf, String opId ) {
		try {
			for( int x=0; x < features.length(); x++ ) {
				JSONObject ft = features.getJSONObject( x );
				JSONObject geometry = ft.getJSONObject("geometry");
				JSONObject properties = ft.getJSONObject("properties");
				String geomTextFromJson = geometry.toString();
				
				String sql = "INSERT INTO geodata ( id, user_cpf, op_id, geo_json, the_geom ) VALUES (default,'" +
				userCpf + "','" +opId+ "', jsonb_insert('" + properties + "'),  ST_GeomFromGeoJSON('"+geomTextFromJson+"');";

				System.out.println( sql  );
				jdbcTemplate.update( sql );
			}
			
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		
	}
	
	public String getFeatures( String uri ) {
		String responseBody = "[]";
		
		System.out.println( uri );
		
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

package br.mil.defesa.sisgeodef.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class AisWebService {
	
	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	@Value("${spring.datasource.url}")
	private String connectionString;  	

	@Value("${spring.datasource.username}")
	private String user;  	

	@Value("${spring.datasource.password}")
	private String password;  		
	
	
	// LINESTRING(-43.5763491352785 -22.405300535515252,-43.575770503011086 -22.885701042358264,-42.89193825941143 -22.924609032557,-42.51131533563798 -22.480900032582642,-42.80822499135502 -22.229932275691375,-43.5763491352785 -22.405300535515252)
	public String getAerodromos(String polygon) {
		String result = "{}";
		String sql = "select * from getaerodromos('" + polygon + "') as resultset";
		
		try (
			Connection sqlConnection  =  DriverManager.getConnection(connectionString, user, password);
			PreparedStatement ps = sqlConnection.prepareStatement( sql ); 
	        ResultSet rs = ps.executeQuery() ) {
		    while (rs.next() ) {
		        result = rs.getString("resultset");
		        JSONObject job = new JSONObject( result );
		        result = job.toString();
			}
        } catch (SQLException e) {
        	e.printStackTrace();
	    }
		
		return result;
		
	}



	private JSONObject getXMLAsJson( String url ) {
		JSONObject result = new JSONObject();
		try {
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			headers.setAccept(Arrays.asList(MediaType.APPLICATION_XML));
			HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			result = XML.toJSONObject( response.getBody() ); 
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return result;
	}		
	
	
	
	
	@Cacheable("previsaoAerodromo")
	public String getPrevisaoAerodromo(String icao) {
		String uri = "http://aisweb.decea.gov.br/api/?apiKey=2046730488&apiPass=adc9f816-5cf6-11e7-a4c1-00505680c1b4&area=met&icaoCode=" + icao;
		System.out.println( uri );
		return getXMLAsJson( uri ).toString();
	}
	

}

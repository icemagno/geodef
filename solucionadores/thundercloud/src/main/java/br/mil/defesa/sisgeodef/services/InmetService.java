package br.mil.defesa.sisgeodef.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Service
public class InmetService {

	@Value("${proxy.useProxy}")
	private boolean useProxy;		
	
    @Autowired
    AuthService authService;
    
	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	@Value("${spring.datasource.url}")
	private String connectionString;  	

	@Value("${spring.datasource.username}")
	private String user;  	

	@Value("${spring.datasource.password}")
	private String password;  		
	
	// LINESTRING(-43.5763491352785 -22.405300535515252,-43.575770503011086 -22.885701042358264,-42.89193825941143 -22.924609032557,-42.51131533563798 -22.480900032582642,-42.80822499135502 -22.229932275691375,-43.5763491352785 -22.405300535515252)
	public String getestacoes(String polygon) {
		String result = "{}";
		String sql = "select * from getestacoes('" + polygon + "') as resultset";
		
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

	@Cacheable("imagemGoes")
	public String getGoesImage( String regiao, String parametro, String data ) {
		// Regiao = [ AS, BRA, CO, NE, N, SE, S ]
		// Parametro = [{"sigla":"IV","nome":"Infravermelho Termal"},{"sigla":"TN","nome":"Topo das Nuvens (T ºC)"},{"sigla":"VA","nome":"Vapor d'Água"},{"sigla":"VI","nome":"Visível"},{"sigla":"VP","nome":"Vapor d'Água Realçado"}]
		
		String uri = "https://apisat.inmet.gov.br/GOES/"+regiao+"/"+parametro+"/" + data;
		System.out.println( uri );
		
		String responseBody = "[]";

		
		RestTemplate restTemplate;
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate( );
		}
				
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}
	
	@Cacheable("previsaoMunicipio")
	public String getPrevisaoMunicipio(String geocode) {
		String uri = "https://apiprevmet3.inmet.gov.br/previsao/" + geocode;
		System.out.println( uri );
		
		String responseBody = "[]";

		RestTemplate restTemplate;
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate( );
		}
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}


	public String getestacao(String cdwmo) {
		return "{}";
	}

	public String getGoesImageHour(String regiao, String parametro, String data, String hora) {
		String uri = "https://apisat.inmet.gov.br/GOES/"+regiao+"/"+parametro+"/" + data+"/" + hora;
		System.out.println( uri );
		String responseBody = "[]";

		RestTemplate restTemplate;
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate( );
		}
		
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}

	
	
	
}

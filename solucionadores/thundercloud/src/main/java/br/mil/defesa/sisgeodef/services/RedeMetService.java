package br.mil.defesa.sisgeodef.services;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Service
public class RedeMetService {

	private String getData( String url ) {
		
		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( url, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			ex.printStackTrace();
		}		
		return responseBody ;
	}
	
	
	public String getRadarCappi(String local) {
		// YZlqb8topU3REtHE84US2VtvGRuShzcKop71XpP3 
		String url = "https://api-redemet.decea.gov.br/produtos/radar/maxcappi?api_key=YZlqb8topU3REtHE84US2VtvGRuShzcKop71XpP3&anima=15";
		return getData( url );
	}
	
	
}

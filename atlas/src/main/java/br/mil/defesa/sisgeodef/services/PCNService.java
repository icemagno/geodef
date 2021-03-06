package br.mil.defesa.sisgeodef.services;

import java.io.ByteArrayInputStream;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.misc.PCNParameters;

@Service
public class PCNService {

    @Autowired
    private LoadBalancerClient loadBalancer;

	@Autowired
	GeneratePCNPdfReport generatePCNPdfReport;	
	
	private String getDaedalus() {
		ServiceInstance daedalusInstance = loadBalancer.choose("daedalus");
		return daedalusInstance.getUri().toString(); 
	}
	
	// http://sisgeodef.defesa.mil.br:36002/v1/runways?pcn=-1&pavimento=*&resistencia=*&pressao=*&avaliacao=*&comprimento=-1&largura=-1&ICAO=*	
	public String getRunWays( Integer pcn, String pavimento, String resistencia, String pressao, String avaliacao, 
			Integer comprimento, Integer largura, String icao ) {
    	
		String uri = getDaedalus() + "/v1/runways?pcn="+pcn+"&pavimento="+pavimento+"&resistencia="+resistencia+"&pressao="+pressao+
				"&avaliacao="+avaliacao+"&comprimento="+comprimento+"&largura="+largura+"&icao=" + icao;
		
		RestTemplate restTemplate = new RestTemplate();
		String responseBody;
		try {
			ResponseEntity<String> result = restTemplate.getForEntity(uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		}	
		return responseBody;    	
    }
	
	
	public ResponseEntity<InputStreamResource> getRunWaysAsPDF( 
			Integer pcn, 
			String pavimento, 
			String resistencia, 
			String pressao, 
			String avaliacao, 
			Integer comprimento, 
			Integer largura,
			String icao ) {
    	
		String uri = getDaedalus() + "/v1/runways?pcn="+pcn+"&pavimento="+pavimento+"&resistencia="+resistencia+"&pressao="+pressao+
				"&avaliacao="+avaliacao+"&comprimento="+comprimento+"&largura="+largura+"&icao=" + icao;
		
		RestTemplate restTemplate = new RestTemplate();
		
		try {
		
			PCNParameters params = new PCNParameters(pcn, pavimento,resistencia, pressao, avaliacao, comprimento, largura, icao );
			
			ResponseEntity<String> result = restTemplate.getForEntity(uri, String.class);
			JSONObject json = new JSONObject(  result.getBody().toString() );
			
	        ByteArrayInputStream bis = generatePCNPdfReport.getPCNReport( json, params );

	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Content-Disposition", "inline; filename=relatoriopcn.pdf");

	        return ResponseEntity
	                .ok()
	                .headers(headers)
	                .contentType(MediaType.APPLICATION_PDF)
	                .body( new InputStreamResource(bis) );		
			
			
		} catch ( Exception e ) {
		    e.printStackTrace();
	        return null;
		}
    	
    }
	
	
	
}

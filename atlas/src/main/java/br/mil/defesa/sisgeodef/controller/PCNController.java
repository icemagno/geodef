package br.mil.defesa.sisgeodef.controller;

import java.io.ByteArrayInputStream;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.misc.PCNParameters;
import br.mil.defesa.sisgeodef.services.GeneratePCNPdfReport;

@Controller
public class PCNController {
	
	@Value("${daedalus.url}")
	private String daedalusUrl;  	// http://sisgeodef.defesa.mil.br:36002
	
	@Autowired
	GeneratePCNPdfReport generatePCNPdfReport;
	
	// http://sisgeodef.defesa.mil.br:36002/v1/runways?pcn=-1&pavimento=*&resistencia=*&pressao=*&avaliacao=*&comprimento=-1&largura=-1&ICAO=*	
    @RequestMapping(value = "/runways", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getRunWays( 
			@RequestParam(value="pcn",required=true) Integer pcn, 
			@RequestParam(value="pavimento",required=true) String pavimento, 
			@RequestParam(value="resistencia",required=true) String resistencia, 
			@RequestParam(value="pressao",required=true) String pressao, 
			@RequestParam(value="avaliacao",required=true) String avaliacao, 
			@RequestParam(value="comprimento",required=true) Integer comprimento, 
			@RequestParam(value="largura",required=true) Integer largura,
			@RequestParam(value="icao", required=false) String icao ) {
    	
		String uri = daedalusUrl + "/v1/runways?pcn="+pcn+"&pavimento="+pavimento+"&resistencia="+resistencia+"&pressao="+pressao+
				"&avaliacao="+avaliacao+"&comprimento="+comprimento+"&largura="+largura+"&icao=" + icao;
		
		System.out.println( uri );
		
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
		return responseBody;    	
    	
    }

    
    
    
    @RequestMapping(value = "/runwayspdf", method = RequestMethod.GET, produces = MediaType.APPLICATION_PDF_VALUE )
	public ResponseEntity<InputStreamResource> getRunWaysAsPDF( 
			@RequestParam(value="pcn",required=true) Integer pcn, 
			@RequestParam(value="pavimento",required=true) String pavimento, 
			@RequestParam(value="resistencia",required=true) String resistencia, 
			@RequestParam(value="pressao",required=true) String pressao, 
			@RequestParam(value="avaliacao",required=true) String avaliacao, 
			@RequestParam(value="comprimento",required=true) Integer comprimento, 
			@RequestParam(value="largura",required=true) Integer largura,
			@RequestParam(value="icao", required=false) String icao ) {
    	
		String uri = daedalusUrl + "/v1/runways?pcn="+pcn+"&pavimento="+pavimento+"&resistencia="+resistencia+"&pressao="+pressao+
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


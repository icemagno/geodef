package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.services.AuthService;
import br.mil.defesa.sisgeodef.services.VectorTileService;

@RestController
@RequestMapping("/cbers4")
public class CBERS4Controller {
	
    @Autowired
    private AuthService authService;

	@Autowired
    private VectorTileService vts;
    
	@Value("${proxy.useProxy}")
	private Boolean useProxy; 
    	
	
    // https://cbers.services.remotepixel.ca/search?row=126&path=151
	// https://search.remotepixel.ca/#6.06/-23.244/-48.011

	@RequestMapping(value = "/test", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String test( ) {
		String result = "CBERS-4";
		
		try {
			result = doRequestGet("https://cbers.services.remotepixel.ca/search?row=126&path=151");
			vts.readVT();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}	
  

	private String doRequestGet( String uri ) {
		System.out.println( uri );
		String responseBody = "";
		RestTemplate restTemplate;
		
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate();
		}
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}

	
	
}


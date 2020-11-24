package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/aviso")
public class AvisoRadioController {

    @Autowired
    private LoadBalancerClient loadBalancer;
    
	private String doRequestGet( String url ) {
		
		ServiceInstance poseidonInstance = loadBalancer.choose("poseidon");
		String poseidonAddress = poseidonInstance.getUri().toString(); 
			
		String uri = poseidonAddress +  url;
		System.out.println( "Request: " + uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody ;
	}
		
	
	@RequestMapping(value = "/getavisos", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getAvisos( @RequestParam(value="mock",required=true) Boolean mock ) {
		if( mock ) {
			return doRequestGet("/avisos/mock" ); 
		} else	return doRequestGet("/avisos" );
	}

	@RequestMapping(value = "/getareas", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getAreas( ) {
		return doRequestGet("/areas/" );
	}

	
}

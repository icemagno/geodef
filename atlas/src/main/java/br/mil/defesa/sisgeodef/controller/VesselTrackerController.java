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
@RequestMapping("/vtracker")
public class VesselTrackerController {

    @Autowired
    private LoadBalancerClient loadBalancer;
    
	private String doRequestGet( String url ) {
		
		ServiceInstance gaiaInstance = loadBalancer.choose("vesseltracker");
		String gaiaAddress = gaiaInstance.getUri().toString(); 
			
		String uri = gaiaAddress +  url;
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
		
	
	@RequestMapping(value = "/search", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String searchShips(  @RequestParam("term") String term ) {
		// https://www.vesseltracker.com/en/search?term=9375733
		return doRequestGet( "/v1/searchinfo?term=" + term );
	}

	
}

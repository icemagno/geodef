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
@RequestMapping("/sistram")
public class SistramController {

    @Autowired
    private LoadBalancerClient loadBalancer;
    
	private String doRequestGet( String url ) {
		
		ServiceInstance serviceInstance = loadBalancer.choose("sistram");
		String sistramAddress = serviceInstance.getUri().toString(); 
			
		String uri = sistramAddress +  url;
		System.out.println( uri );
		
		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
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
		return responseBody ;
	}
		
	
	@RequestMapping(value = "/plataformas", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getPlataformas( ) {
		return doRequestGet("/v1/plataformas" );
	}

	@RequestMapping(value = "/scan", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String scan( @RequestParam("lat") String lat, @RequestParam("lon") String lon, @RequestParam("raio") String raio ) {
		return doRequestGet( "/v1/scan?lon="+lon+"&lat="+lat+"&raio=" + raio);
	}
		
	
}

package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.core.env.Environment;
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
@RequestMapping("/cor")
public class CorMeteoroController {

	@Autowired
	private Environment env;	
	
    @Autowired
    private LoadBalancerClient loadBalancer;
    
	private String doRequestGet( String url ) {
		
		String gaiaAddress = env.getProperty("gaia.url");
		if( gaiaAddress == null ) {
			ServiceInstance gaiaInstance = loadBalancer.choose("gaia");
			gaiaAddress = gaiaInstance.getUri().toString(); 
		}
			
		String uri = gaiaAddress +  url;
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
		
	
	@RequestMapping(value = "/getcolors", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getColors( @RequestParam(value="mock", required=true) Boolean isMock  ) {
		if( isMock ) return doRequestGet("/thundercloud/v1/mockall" ); else
			return doRequestGet("/thundercloud/v1/retrieve" );
	}


	
}

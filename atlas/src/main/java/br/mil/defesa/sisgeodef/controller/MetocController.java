package br.mil.defesa.sisgeodef.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/metoc")
public class MetocController {

    @Autowired
    private LoadBalancerClient loadBalancer;
    
    private String getMunicipios( String url, String data ) {
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress +  url;
		System.out.println( uri );

		RestTemplate restTemplate = new RestTemplate();
    	
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType( MediaType.APPLICATION_JSON );    	
		
	    JSONObject jsonObj = new JSONObject();
	    jsonObj.put("lineString", data);
        HttpEntity<String> request = new HttpEntity<String>( jsonObj.toString() , headers);
        String result = restTemplate.postForObject( uri, request, String.class);        
    	
        return result;
        
    }
    
    /*
	private String doRequestGet( String url ) {
		
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress +  url;
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
	*/	
	
	@RequestMapping(value = "/municipios", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String municipios( @RequestParam(value="lineString",required=true) String lineString ) {
		return getMunicipios( "/ibge/municipios", lineString );
	}	

	
}

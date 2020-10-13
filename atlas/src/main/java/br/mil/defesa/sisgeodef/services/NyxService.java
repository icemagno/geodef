package br.mil.defesa.sisgeodef.services;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Service
public class NyxService {
	
    @Autowired
    private LoadBalancerClient loadBalancer;	

    public String getMetadata( String uuid ) {
		ServiceInstance nyxInstance = loadBalancer.choose("nyx");
		String nyxAddress = nyxInstance.getUri().toString(); 
			
		String url = nyxAddress + "/api/records/"+uuid+"/formatters/xml";
		RestTemplate restTemplate = new RestTemplate();
		
		String responseBody;
		try {
			
			HttpHeaders headers = new HttpHeaders();
			headers.setAccept( Arrays.asList( MediaType.APPLICATION_JSON_UTF8) );
			HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
			
	        ResponseEntity<String> result = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    //String statusText = e.getStatusText();
		}	
		return responseBody;    	
    }	
	

}

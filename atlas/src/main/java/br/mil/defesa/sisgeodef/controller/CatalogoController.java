package br.mil.defesa.sisgeodef.controller;

import java.util.Arrays;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Controller
public class CatalogoController {
	
	@Value("${nyx.catalog.url}")
	private String nyxCatalogUrl;  // http://nyx:36318/geonetwork/srv/ 		
	
	// http://sisgeodef.defesa.mil.br:36318/geonetwork/srv/api/records/4e879571-ffbe-d57d-2244-5866de14af59/formatters/xml	
    @RequestMapping(value = "/metadado", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getRecord( @RequestParam(value="uuid",required=true) String uuid ) {
    	
		String url = nyxCatalogUrl + "/api/records/"+uuid+"/formatters/xml";
		RestTemplate restTemplate = new RestTemplate();
		
		System.out.println( url );
		
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

/*

		HttpHeaders headers = new HttpHeaders();
		headers.setAccept(Arrays.asList(MediaType.APPLICATION_XML));
		HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);		
		
		RestTemplate restTemplate = new RestTemplate();
		String responseBody;
		try {
			


*/
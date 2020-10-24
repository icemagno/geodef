package br.mil.defesa.sisgeodef.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Controller
@CrossOrigin(origins = "http://sisgeodef.defesa.mil.br", maxAge = 3600)
public class ProxyController {
	
	
	@RequestMapping( value = "/capabilities", method = RequestMethod.GET )
	public String getCapabilities( HttpServletRequest req ) {
		
		StringBuilder urlParameters = new StringBuilder();
		String sep = "";
		Map<String, String[]> parameters = req.getParameterMap();
		for (Map.Entry<String, String[]> entry : parameters.entrySet()) {
		    urlParameters.append( sep + entry.getKey() + "=" + entry.getValue()[0] );
		    sep = "&";
		}		
		
		System.out.println( urlParameters.toString() );
		
		String responseBody = urlParameters.toString();
		/*
		RestTemplate restTemplate = new RestTemplate();
		try {
			HttpHeaders headers = new HttpHeaders();
		    List<MediaType> mediaTypeList = new ArrayList<MediaType>();
		    mediaTypeList.add( ( MediaType.APPLICATION_JSON ) );
		    mediaTypeList.add( ( MediaType.APPLICATION_XML ) );
			headers.setAccept( mediaTypeList );
			
			HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
			
	        ResponseEntity<String> result = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		}
		*/	
		return responseBody;    	
		
		
	}
	
	

	@RequestMapping(
			value = "/geoserver/{workspace}/{layerName}/wfs", method = RequestMethod.GET )
	public @ResponseBody String geoserver(  
			@PathVariable("workspace") String workspace, 
			@PathVariable("layerName") String layerName, 
			HttpServletRequest req ) {
		
		StringBuilder urlParameters = new StringBuilder();
		String sep = "";
		Map<String, String[]> parameters = req.getParameterMap();
		for (Map.Entry<String, String[]> entry : parameters.entrySet()) {
		    urlParameters.append( sep + entry.getKey() + "=" + entry.getValue()[0] );
		    sep = "&";
		}		
		
		String url = "https://geoaisweb.decea.gov.br/geoserver/" + workspace + "/" + layerName + "/wfs?" + urlParameters.toString();
		RestTemplate restTemplate = new RestTemplate();
		
		String responseBody;
		try {
			HttpHeaders headers = new HttpHeaders();
			
		    List<MediaType> mediaTypeList = new ArrayList<MediaType>();
		    mediaTypeList.add( ( MediaType.APPLICATION_JSON ) );
		    mediaTypeList.add( ( MediaType.APPLICATION_XML ) );
			headers.setAccept( mediaTypeList );
			
			HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
			
	        ResponseEntity<String> result = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		}	
		return responseBody;    	
		
	}
	
}
package br.mil.defesa.sisgeodef.controller;

import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/proxy")
@CrossOrigin(origins = "http://sisgeodef.defesa.mil.br", maxAge = 3600)
public class ProxyController {
	

	@RequestMapping( value = "/getlegend", method = RequestMethod.GET )
	public @ResponseBody String getLegend(  ) {
		String path = "/srv/calisto/";
		String folder = "legends";
		String target = path + folder + "/finename.jpg";
		File fil = new File( path + folder );
		fil.mkdirs();
		
		String url = "http://osm.franken.de:8080/geoserver/gebco/wms?REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=gebco:gebco_poly_2014";
		
		try {
			try( InputStream in = new URL( url ).openStream() ){
			    Files.copy( in, Paths.get(target ) );
			}	
		} catch (IOException e) {
			
		}		
		
		return target;
	}
	
	
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
	
	

	@RequestMapping( value = "/geoserver/{workspace}/{layerName}/wfs", method = RequestMethod.GET )
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

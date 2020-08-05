package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Controller
public class MapillaryController {
//https://www.mapillary.com/developer/api-documentation/#the-image
	
	// https://a.mapillary.com/v3/sequences?page=3&per_page=200&client_id=Ymx2LVBGakp6a0xXM3hOWmw1b0pPdzo1ZjM1ZWQ5YzU0ZDE0NDZj
	// https://a.mapillary.com/v3/images/slRsbT2NMJYx4hvZC_DyiQ?client_id=Ymx2LVBGakp6a0xXM3hOWmw1b0pPdzo1ZjM1ZWQ5YzU0ZDE0NDZj
	// https://a.mapillary.com/v3/images?client_id=Ymx2LVBGakp6a0xXM3hOWmw1b0pPdzo1ZjM1ZWQ5YzU0ZDE0NDZj&bbox=16.430300,7.241686,16.438757,7.253186
	// https://a.mapillary.com/v3/images?client_id=Ymx2LVBGakp6a0xXM3hOWmw1b0pPdzo1ZjM1ZWQ5YzU0ZDE0NDZj&closeto=16.430300,7.241686&radius=5000
	
	/*
		https://images.mapillary.com/<IMAGE_KEY>/thumb-320.jpg
		https://images.mapillary.com/<IMAGE_KEY>/thumb-640.jpg
		https://images.mapillary.com/<IMAGE_KEY>/thumb-1024.jpg
		https://images.mapillary.com/<IMAGE_KEY>/thumb-2048.jpg	
	*/
	
	@Value("${mapillary.client.id}")
	private String mapillaryClientId;   	
	
	@RequestMapping(value = "/getImagesNearTo", method = RequestMethod.GET )
	public @ResponseBody String getImagesNearTo( @RequestParam("center") String center, @RequestParam("radius") String radius,
			@RequestParam("perpage") String perPage) {
		String uri = "https://a.mapillary.com/v3/images?client_id="+mapillaryClientId+"&closeto="+center+"&radius=" + radius + "&per_page=" + perPage;
		RestTemplate restTemplate = new RestTemplate();
		String responseBody;
		try {
			ResponseEntity<String> result = restTemplate.getForEntity(uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    
		    System.out.println( statusText );
		    
		}	
		return responseBody;
	}
	
	
}

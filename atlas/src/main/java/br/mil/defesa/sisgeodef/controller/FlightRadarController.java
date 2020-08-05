package br.mil.defesa.sisgeodef.controller;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@RestController
public class FlightRadarController {

	@RequestMapping(value = "/aircrafts", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public String getAircrafts() {
		RestTemplate restTemplate = new RestTemplate();
		String responseBody;
		String url = "https://data-live.flightradar24.com/zones/fcgi/feed.js?bounds=-20,-24,-45,-40&faa=1&mlat=1&flarm=1&adsb=1&gnd=0&air=1&vehicles=1&estimated=1&maxage=1000&gliders=1&stats=1";
		try {
			//ResponseEntity<String> result = restTemplate.getForEntity("http://10.5.115.134/mclm/getAircraftsInBBOX?maxlat=-45&maxlon=-20&minlat=-40&minlon=-24", String.class);
			ResponseEntity<String> result = restTemplate.getForEntity( url , String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    //String statusText = e.getStatusText();
		}	
		return responseBody;
	}
	
	
}

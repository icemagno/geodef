package br.mil.defesa.sisgeodef.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.services.AuthService;

@RestController
@RequestMapping("/v1")
public class VesselTrackerController {
	
    @Autowired
    private AuthService authService;


	@Value("${proxy.useProxy}")
	private Boolean useProxy; 
    
	@RequestMapping(value = "/search", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String search(  @RequestParam("term") String term ) {
		// https://www.vesseltracker.com/en/search?term=9375733
		return doRequestGet("https://www.vesseltracker.com/en/search?term=" + term );
	}

	
	@RequestMapping(value = "/searchinfo", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String searchAndInfo(  @RequestParam("term") String term ) {
		// https://www.vesseltracker.com/en/search?term=9375733
		String shipInfo = "";
		try {
			String shipData = doRequestGet("https://www.vesseltracker.com/en/search?term=" + term );
			JSONArray results = new JSONArray( shipData );
			JSONObject ship = results.getJSONObject(0);
			String shipInfoUrl = ship.getString("url");
			
			JSONObject fullInfo = new JSONObject( shipInfo( shipInfoUrl ) );
			// https://www.vesseltracker.com/webjars/flag-icon-css/flags/4x3/bs.svg
			ship.put("flagImage",  "https://www.vesseltracker.com/webjars/flag-icon-css/flags/4x3/" + ship.getString("countryCode").toLowerCase() + ".svg"  );
			fullInfo.put("Ship Info", ship);
			
			shipInfo = fullInfo.toString();
		} catch ( Exception e) {
			e.printStackTrace();
			shipInfo = e.getMessage();
		}
		
		return shipInfo;
	}
	
	
	@RequestMapping(value = "/shipinfo", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String shipInfo( @RequestParam("url") String url ) {
		// https://www.vesseltracker.com/en/Ships/He-Tong-9375733.html
		String result = doRequestGet( "https://www.vesseltracker.com/" + url );
		
		// https://jsoup.org/cookbook/extracting-data/dom-navigation
		// https://jsoup.org/cookbook/extracting-data/selector-syntax
		Document doc = Jsoup.parse( result );
		Elements divs = doc.select("div .key-value-table .row");
		Elements image = doc.select("div .detail-image a img");
		//Elements dataTables = doc.select("div .data-table .row");
		
		JSONObject resultJson = new JSONObject();
		JSONObject jsonKV = new JSONObject();

		jsonKV.put("Image", image.attr("src") );
		
		for (Element div : divs ) {
			try {
				String key = div.select(".key").text().replace(":", "").trim();
				String value = div.select(".value").text().replace(":", "").trim();
				if( !value.equals("") ) jsonKV.put(key, value);
			} catch ( Exception e ) {
				e.printStackTrace();
			}
		}
		
		
		// Nao estou conseguindo separar as tabelas. Ver isso depoi ou tentar o SISTRAM
		/*
		for ( Element div : dataTables ) {
			Elements header = div.select(".table-header");
			Elements body = div.select(":not(.table-header)");
			
			System.out.println( header.html() );
			System.out.println("-----------------------------------------------------------------------");
			System.out.println( body.html() );
		}
		*/
		

		resultJson.put("General Info", jsonKV);
		return resultJson.toString();
	}
		
	private String doRequestGet( String uri ) {
		System.out.println( uri );
		String responseBody = "";
		RestTemplate restTemplate;
		
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate();
		}
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}

	
	
}


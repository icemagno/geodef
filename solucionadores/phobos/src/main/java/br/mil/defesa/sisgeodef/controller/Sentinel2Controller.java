package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.services.AuthService;

@RestController
@RequestMapping("/sentinel2")
public class Sentinel2Controller {
	
    @Autowired
    private AuthService authService;

	@Value("${proxy.useProxy}")
	private Boolean useProxy; 
    
    // https://sentinel.services.remotepixel.ca/search?utm=23&grid=PQ&lat=K&bbox=-44.0277099609375,-23.595452808573953,-42.944183349609375,-22.593726063929296
	// https://roda.sentinel-hub.com/sentinel-s2-l1c/tiles/23/K/PQ/2019/12/30/0/productInfo.json
	// https://search.remotepixel.ca/#8.65/-22.2959/-41.9048
	// http://processamentodigital.com.br/2016/06/23/imagens-cbers-4-5m-conheca-este-sensor-e-faca-o-download-dessas-imagens-no-site-do-inpe/

	@RequestMapping(value = "/", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getAviso( ) {
		String result = "sentinel2";
		return result;
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


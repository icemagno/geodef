package br.mil.defesa.sisgeodef.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
public class SistramController {
	private Logger logger = LoggerFactory.getLogger(SistramController.class);
	String sistramAddress = "http://www.sistram.mar.mil.br/apolo";    

	@Value("${proxy.useProxy}")
	private boolean useProxy;		
	
    @Autowired
    AuthService authService;	
	
	private String doRequestGet( String url ) {
		String uri = sistramAddress +  url;
		logger.info("Requisição para " + uri );

		String responseBody = "[]";
		
		RestTemplate restTemplate;
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate( );
		}
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class );
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
			responseBody = e.getResponseBodyAsString();
			String statusText = e.getStatusText();
			logger.info( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return "{\"data\":" + responseBody + "}";
	}
	
	@RequestMapping(value = "/plataformas", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getPlataformas( ) {
		return doRequestGet("/BuscaPlataformas.php" );
		//return doRequestGetMock("plataformas" );
	}

	@RequestMapping(value = "/scan", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String scan( @RequestParam("lat") String lat, @RequestParam("lon") String lon, @RequestParam("raio") String raio ) {
		// http://www.sistram.mar.mil.br/apolo/BuscaEmArea.php?long=-40.81010333333333&lat=-22.703833333333332&raio=1000
		// http://sisgeodef.defesa.mil.br:36001/v1/scan?lon=-40.81010333333333&lat=-22.703833333333332&raio=1000
		return doRequestGet( "/BuscaEmArea.php?long="+lon+"&lat="+lat+"&raio=" + raio);
		//return doRequestGetMock( "/scan-navios?lon="+lon+"&lat="+lat+"&raio=" + raio);

	}

}

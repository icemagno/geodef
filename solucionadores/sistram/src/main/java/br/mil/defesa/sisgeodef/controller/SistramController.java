package br.mil.defesa.sisgeodef.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.ClientHttpRequestFactory;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/v1")
public class SistramController {
	private Logger logger = LoggerFactory.getLogger(SistramController.class);

	@Value("classpath:mock/plataformas.json")
	Resource plataformas;

	//@Value("${sistram.api.address}") // http://www.sistram.mar.mil.br/apolo
	String sistramAddress = "http://www.sistram.mar.mil.br/apolo";    

	/*
	@RequestMapping(value = "/mock-plataformas", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getPlataformasMock( ) {
		String result = "";
		try {
			Reader reader = null;
			reader = new InputStreamReader( plataformas.getInputStream() );
			String text = CharStreams.toString(reader);
			JSONObject obj = new JSONObject( text );

			result = obj.toString();
		} catch ( Exception ex ) {
			ex.printStackTrace();
			result = ex.getMessage();
		}
		return result;
	}
	*/

	private String doRequestGet( String url ) {
		String uri = sistramAddress +  url;
		logger.info("Requisição para " + uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate( getClientHttpRequestFactory() );
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
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
	
	private ClientHttpRequestFactory getClientHttpRequestFactory() {
	    int timeout = 15000;
	    HttpComponentsClientHttpRequestFactory clientHttpRequestFactory = new HttpComponentsClientHttpRequestFactory();
	    clientHttpRequestFactory.setConnectTimeout(timeout);
	    return clientHttpRequestFactory;
	}	

	/*
	private String doRequestGetMock( String url ) {
		String uri = "http://nautilo:36309/v1/sistram/" +  url;
		logger.info("Requisição para " + uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
			responseBody = e.getResponseBodyAsString();
			String statusText = e.getStatusText();
			logger.info( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}


		responseBody = responseBody == null ? "{\"data\":\"\"}" : responseBody;

		return responseBody;
	}
	*/
	
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

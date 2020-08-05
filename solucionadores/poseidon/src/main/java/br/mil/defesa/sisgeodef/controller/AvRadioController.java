package br.mil.defesa.sisgeodef.controller;

import java.io.InputStreamReader;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import com.google.common.io.CharStreams;

import br.mil.defesa.sisgeodef.services.AuthService;

@RestController
@RequestMapping("/avisos")
public class AvRadioController {
	
    @Value("classpath:mock/avradio.json")
    private Resource mockAviso;	

    @Value("${apolo.avisoradio.url}")
    private String apoloAvRadioEndpoint;	

    @Autowired
    private AuthService authService;

	@RequestMapping(value = "/mock", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getAvisoMock( ) {
		String result = "";
		try {
			result = CharStreams.toString( new InputStreamReader( mockAviso.getInputStream() ) );
		} catch ( Exception ex ) {
			ex.printStackTrace();
			result = ex.getMessage();
		}
		return result;
	}	


	@RequestMapping(value = "/", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getAviso( ) {
		String result = "";
		try {
			result = doRequestGet( apoloAvRadioEndpoint );
		} catch ( Exception ex ) {
			ex.printStackTrace();
			result = ex.getMessage();
		}
		return result;
	}	


	private String doRequestGet( String uri ) {
		System.out.println( uri );
		String responseBody = "";
		RestTemplate restTemplate = new RestTemplate( authService.getFactory() );
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


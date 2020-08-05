package br.mil.defesa.sisgeodef.controller;

import java.io.InputStreamReader;
import java.io.Reader;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.io.CharStreams;

@RestController
@RequestMapping("/v1")
public class LayerCatalogController {

    @Value("classpath:mock/cartografia_terrestre.json")
    Resource resourceTerrestre;

    @Value("classpath:mock/cartografia_nautica.json")
    Resource resourceNautica;

    @Value("classpath:mock/cartografia_aeronautica.json")
    Resource resourceAeroNautica;
    
	@RequestMapping(value = "/pleione/catalog", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getCatalog( @RequestParam(value="fonte",required=true) String fonte) {
		String text = null;
		String result = "";
		
		try {
			
			Reader reader = null;
			
			if( fonte.equals("terrestre") ) {
				reader = new InputStreamReader( resourceTerrestre.getInputStream() );
			}
			if( fonte.equals("aeronautica") ) {
				reader = new InputStreamReader( resourceAeroNautica.getInputStream() );
			} 
			if( fonte.equals("nautica") ) {
				reader = new InputStreamReader( resourceNautica.getInputStream() );
			}
			
			text = CharStreams.toString(reader);
			JSONObject obj = new JSONObject( text );
			result = obj.toString();
			
		} catch ( Exception ex ) {
			ex.printStackTrace();
			result = ex.getMessage();
		}
		
		return result;
	}



}

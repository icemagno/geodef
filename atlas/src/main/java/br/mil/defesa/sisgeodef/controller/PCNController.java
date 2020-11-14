package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.mil.defesa.sisgeodef.services.PCNService;

@Controller
public class PCNController {
	
	@Autowired
	private PCNService pcnService;
	
    @RequestMapping(value = "/runways", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getRunWays( 
			@RequestParam(value="pcn",required=true) Integer pcn, 
			@RequestParam(value="pavimento",required=true) String pavimento, 
			@RequestParam(value="resistencia",required=true) String resistencia, 
			@RequestParam(value="pressao",required=true) String pressao, 
			@RequestParam(value="avaliacao",required=true) String avaliacao, 
			@RequestParam(value="comprimento",required=true) Integer comprimento, 
			@RequestParam(value="largura",required=true) Integer largura,
			@RequestParam(value="icao", required=false) String icao ) {
    	
		return pcnService.getRunWays(pcn, pavimento, resistencia, pressao, avaliacao, comprimento, largura, icao);    	
    	
    }

    
    
    
    @RequestMapping(value = "/runwayspdf", method = RequestMethod.GET, produces = MediaType.APPLICATION_PDF_VALUE )
	public ResponseEntity<InputStreamResource> getRunWaysAsPDF( 
			@RequestParam(value="pcn",required=true) Integer pcn, 
			@RequestParam(value="pavimento",required=true) String pavimento, 
			@RequestParam(value="resistencia",required=true) String resistencia, 
			@RequestParam(value="pressao",required=true) String pressao, 
			@RequestParam(value="avaliacao",required=true) String avaliacao, 
			@RequestParam(value="comprimento",required=true) Integer comprimento, 
			@RequestParam(value="largura",required=true) Integer largura,
			@RequestParam(value="icao", required=false) String icao ) {

    	return pcnService.getRunWaysAsPDF(pcn, pavimento, resistencia, pressao, avaliacao, comprimento, largura, icao);
    }
    
	
}


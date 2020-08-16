package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.InmetService;

@RestController
@RequestMapping("/inmet")
public class InmetController {

	@Autowired
	InmetService inmetService;
	
	@RequestMapping(value = "/estacoes", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String estacoes( @RequestParam(value="lineString",required=true) String lineString ) {
		return inmetService.getestacoes( lineString );
	}
	
	
	@RequestMapping(value = "/municipio/{geocode}", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String previsaoMunicipio(  @PathVariable("geocode") String geocode ) {
		return inmetService.getPrevisaoMunicipio( geocode );
	}	
	
	
}

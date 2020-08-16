package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.AisWebService;

@RestController
@RequestMapping("/aisweb")
public class AisWebController {

	@Autowired
	AisWebService aiswebService;
	
	@RequestMapping(value = "/aerodromos", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String aerodromos( @RequestParam(value="lineString",required=true) String lineString ) {
		return aiswebService.getAerodromos( lineString );
	}
	
	@RequestMapping(value = "/aerodromo/{icao}", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String previsaoMunicipio(  @PathVariable("icao") String icao ) {
		return aiswebService.getPrevisaoAerodromo( icao );
	}	
	
	
}

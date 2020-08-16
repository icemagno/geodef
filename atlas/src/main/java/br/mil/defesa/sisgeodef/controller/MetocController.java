package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.ThundercloudService;

@RestController
@RequestMapping("/metoc")
public class MetocController {

	@Autowired
	ThundercloudService thundercloud;
	
	@RequestMapping(value = "/municipios", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String municipios( @RequestParam(value="lineString",required=true) String lineString ) {
		return thundercloud.getMunicipios( lineString );
	}	

	
	@RequestMapping(value = "/municipio/{geocode}", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String previsaoMunicipio(  @PathVariable("geocode") String geocode ) {
		return thundercloud.getPrevisaoMunicipio( geocode );
	}	
	

	@RequestMapping(value = "/aerodromo/{icao}", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String previsaoAerodromo(  @PathVariable("icao") String icao ) {
		return thundercloud.getPrevisaoAerodromo( icao );
	}	
	
	
	@RequestMapping(value = "/aerodromos", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String aerodromos( @RequestParam(value="lineString",required=true) String lineString ) {
		return thundercloud.getAerodromos( lineString );
	}	
	
	@RequestMapping(value = "/estacoes", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String estacoes( @RequestParam(value="lineString",required=true) String lineString ) {
		return thundercloud.getEstacoes( lineString );
	}	

	
}

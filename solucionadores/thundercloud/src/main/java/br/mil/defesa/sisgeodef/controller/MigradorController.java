package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.ImportadorService;

@RestController
@RequestMapping("/migrador")
public class MigradorController {
	
	@Autowired
	ImportadorService importadorService;
	
	@RequestMapping(value = "/estacoes", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String estacoes()  {
		return importadorService.importEstacoes();
	}	
	

	@RequestMapping(value = "/aerodromos", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String aerodromos()  {
		return importadorService.importAerodromos();
	}	
	
	
}

package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.IbgeService;

@RestController
@RequestMapping("/ibge")
public class IbgeController {

	@Autowired
	IbgeService ibgeService;
	
	@RequestMapping(value = "/municipios", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String municipios( @RequestParam(value="lineString",required=true) String lineString ) {
		return ibgeService.getMunicipios( lineString );
	}
	
}

package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.service.GebcoService;

@RestController
public class SistramController {
	
	@Autowired
	private GebcoService gebcoService;
	
	@RequestMapping(value = "/getfeature", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getFeature( ) {
		return  gebcoService.getFeature("gebco_poly_2014.1" );
	}


}

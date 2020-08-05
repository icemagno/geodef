package br.com.cmabreu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import br.com.cmabreu.services.PrevisaoDLLService;

@Controller
public class ConfigController {

	@Autowired
	PrevisaoDLLService previsaoDLLService; 

	
	@RequestMapping(value = "/config/geraarqconst", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE )	
	public String setGeraArqConst(@PathVariable("enabled") Boolean value ) {
		previsaoDLLService.setGeraArqConst( value );
		return "{\"result\":\"ok\"}";
	}
	
	
}

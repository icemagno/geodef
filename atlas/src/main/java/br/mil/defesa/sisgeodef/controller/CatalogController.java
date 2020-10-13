package br.mil.defesa.sisgeodef.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.model.CatalogTopics;
import br.mil.defesa.sisgeodef.repository.CatalogTopicsService;

@RestController
@RequestMapping("/catalog")
public class CatalogController {
	
	@Autowired
	private CatalogTopicsService catalogService;
	
	@RequestMapping(value = "/topics", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody List<CatalogTopics> getTopics() {
		return catalogService.findAll();
	}

}

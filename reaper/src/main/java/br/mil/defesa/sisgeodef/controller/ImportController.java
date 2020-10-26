package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.CronService;

@RestController
public class ImportController {
	
	@Autowired
	private CronService cronService;
	
	@RequestMapping(value = "/import", method = RequestMethod.POST, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String startImport( 
			@RequestParam(value="bn",required=true ) String bn,
			@RequestParam(value="bs",required=true ) String bs,
			@RequestParam(value="be",required=true ) String be,
			@RequestParam(value="bw",required=true ) String bw,
			@RequestParam(value="layer",required=true) String layerName,
			@RequestParam(value="userId",required=true) String userId,
			@RequestParam(value="url",required=true) String url
		) {
		return cronService.addWork( url, userId, layerName, bn, bs, be, bw );
	}


}

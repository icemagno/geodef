package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.CronService;
import br.mil.defesa.sisgeodef.worker.Worker;

@RestController
public class ImportController {
	
	@Autowired
	private CronService cronService;
	
	@RequestMapping(value = "/import", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String startImport( ) {
		
		String url = "http://osm.franken.de:8080/geoserver/gebco/ows";
		Worker wk = new Worker( url );
		return cronService.addWork(wk);
		
	}


}

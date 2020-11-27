package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.RedeMetService;

@RestController
@RequestMapping("/cappi")
public class RadarCappiController {

    @Autowired
    private RedeMetService redeMetService;
    

	@RequestMapping(value = "/{local}", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getRadarCappi( @PathVariable("local") String local ) {
		return redeMetService.getRadarCappi( local );
	}


	
}

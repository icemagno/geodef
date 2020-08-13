package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.ThundercloudService;

@RestController
@RequestMapping("/cor")
public class CorMeteoroController {

    @Autowired
    private ThundercloudService thundercloud;
    

	@RequestMapping(value = "/getcolors", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getColors( ) {
		return thundercloud.getCorMeteorologica();
	}


	
}

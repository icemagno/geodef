package br.mil.defesa.sisgeodef.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.model.CatalogTopics;
import br.mil.defesa.sisgeodef.repository.CatalogTopicsRepository;
import br.mil.defesa.sisgeodef.services.CartografiaIndexService;
import br.mil.defesa.sisgeodef.services.CatalogImporterService;
import br.mil.defesa.sisgeodef.services.NyxService;

@RestController
@RequestMapping("/catalog")
public class CatalogController {
	
	@Autowired
	private CatalogTopicsRepository catalogRepository;
	
	@Autowired
	private CatalogImporterService catalogImporterService;
	
	@Autowired
	private CartografiaIndexService cartografiaService;	

	@Autowired
	private NyxService nyxService;
	
	// http://sisgeodef.defesa.mil.br:36318/geonetwork/srv/api/records/4e879571-ffbe-d57d-2244-5866de14af59/formatters/xml	
    @RequestMapping(value = "/metadata", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getRecord( @RequestParam(value="uuid",required=true) String uuid ) {
    	return nyxService.getMetadata(uuid);
    }
	
	
	@RequestMapping(value = "/topics", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody List<CatalogTopics> getTopics() {
		List<CatalogTopics> topics = catalogRepository.findAll();
		return topics; 
	}

    @RequestMapping(value = "/importcapabilities", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public void importCapabilities( @RequestParam(value="url",required=true) String url ) {
    	url = "http://www.geoportal.eb.mil.br/mapcache?service=wms&version=1.3.0&request=GetCapabilities";
    	catalogImporterService.importCapabilities(6, url);
    }
	
    
    @RequestMapping(value = "/importbdgex", method = RequestMethod.GET )
    public void importBDGEXtree() {
    	cartografiaService.importBDGEXtree();
    }
	
}

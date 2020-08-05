package br.mil.defesa.sisgeodef.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.misc.cartografia.IClasse;
import br.mil.defesa.sisgeodef.services.CartografiaIndexService;

@RestController
@RequestMapping("/cartografia")
public class CartografiaController {

	@Autowired
	private CartografiaIndexService cartografiaService;

	@RequestMapping(value = "/find", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody List<IClasse> find(  @RequestParam(value="nome",required=true) String nome, @RequestParam(value="limite",required=true) Integer limite ) {
		
		List<IClasse> result = new ArrayList<IClasse>(); 
		try {
			//cartografiaService.acquire();
			result.addAll( cartografiaService.find(nome, limite) );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		
		return result;
	}

	
	@RequestMapping(value = "/tree", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getTree( ) {
		return cartografiaService.getTree();
	}	
	
	@RequestMapping(value = "/index", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getIndex(  @RequestParam(value="fonte",required=true) String fonte ) {
		String result = "";
		try {
			if( fonte.equals("terrestre") ) {
				result = cartografiaService.getTerrestre();
			}
			if( fonte.equals("nautica") ) {
				result = cartografiaService.getNautica();
			}
			if( fonte.equals("aeronautica") ) {
				result = cartografiaService.getAeronautica();
			}
		} catch ( Exception e ) {
			e.printStackTrace();
		}		
		
		return result;
	}	
	
	
}

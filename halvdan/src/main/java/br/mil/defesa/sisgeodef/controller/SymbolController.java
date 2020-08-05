package br.mil.defesa.sisgeodef.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import br.mil.defesa.sisgeodef.misc.SvgSymbolConstructor;
import br.mil.defesa.sisgeodef.model.Simbolo;
import br.mil.defesa.sisgeodef.model.SimboloRepositorio;
import br.mil.defesa.sisgeodef.model.SimbolosParte;
import br.mil.defesa.sisgeodef.model.SimbolosParteRepositorio;

@RestController
@RequestMapping("/v1")
public class SymbolController {

	
	@Value("${spring.datasource.url}")
	private String connectionString;  	

	@Value("${spring.datasource.username}")
	private String user;  	

	@Value("${spring.datasource.password}")
	private String password;  	
	
	@Autowired
	private SimboloRepositorio simboloRepositorio;
	
	@Autowired
	private SimbolosParteRepositorio simbolosParteRepositorio;

	
	// http://sisgeodef.defesa.mil.br:36853/v1/getsymbol?p1=2323&p2=543543543
    @RequestMapping(value = "/getsymbol", method = RequestMethod.GET, produces="image/svg+xml; charset=UTF-8" )
	public @ResponseBody String getSymbol( 
			@RequestParam(value="symbol", required=true) Integer symbol,
			@RequestParam(value="color", required=false) String color ) throws IOException {
		
    	
    	//response.setContentType("image/svg+xml; charset=UTF-8");
        
        color = (color == null) ? "#000000" : color.replace('_', '#');       
        symbol = (symbol == null) ? 0 : symbol;
        
        Simbolo simbolo =  simboloRepositorio.findById(symbol.longValue()).get();
        
        if(simbolo.getSvgData() == null) {
        	
        	List<SimbolosParte> partes =  simbolosParteRepositorio.findByIdsimbolo(symbol);
        	System.out.println(partes.size());
        	
        	
        	SvgSymbolConstructor svc = new SvgSymbolConstructor(simbolo, color, true, partes);
        	
        	
        	String imagem =  svc.getSimbol().replaceAll(SvgSymbolConstructor.COLOR_PLACEHOLDER, color);
        	return imagem;
        	
        } else {
        	String imagem =  simbolo.getSvgData().replaceAll(SvgSymbolConstructor.COLOR_PLACEHOLDER, color);
        	return imagem;
        }
        
        
        
    	
    	
    	
    	
    	
    	
	}
    
    @RequestMapping(value = "/symbols", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<Simbolo> getSymbols() {
    	List<Simbolo> lista =  simboloRepositorio.findAll();
    	
    	return lista;
    	
    }

    
	@RequestMapping(value = "/base-image/{imageNome}", method = RequestMethod.GET, produces = {MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_GIF_VALUE} )
	public @ResponseBody ResponseEntity<byte[]> getImage( @PathVariable String imageNome, HttpServletRequest servletRequest )  {
		try {
			String sourceFolder = "/fonts";
			String requestedImage = sourceFolder + "/" + imageNome+".ttf";
			String noPhotoImage = sourceFolder + "/nophoto.png";

			File file = new File( requestedImage );
			if( !file.exists() ) {
				//log.warn("Usuario nao possui foto. Usando a foto padrao.");
				file = new File( noPhotoImage );
			}

			HttpHeaders headers = new HttpHeaders();
			InputStream in = new FileInputStream( file );

			headers.setCacheControl( CacheControl.noCache().getHeaderValue() );
			byte[] media = IOUtils.toByteArray(in);
			ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(media, headers, HttpStatus.OK);
			return responseEntity;			

		} catch ( Exception e ) {
			//log.error("Erro ao recuperar a foto: " + e.getMessage() );
			return null;
		}
	}	
	

	
}


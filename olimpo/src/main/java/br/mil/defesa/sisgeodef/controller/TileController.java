package br.mil.defesa.sisgeodef.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/tilesets")
public class TileController {

	//private Logger logger = LoggerFactory.getLogger( TileController.class );

	
	@RequestMapping(value = "/{name}/{x}/{y}/{z}", method = RequestMethod.GET )
	public ResponseEntity<Resource> getTerrainTile(
			@PathVariable("name") String name,
			@PathVariable("x") Integer x,
			@PathVariable("y") Integer y,
			@PathVariable("z") String z) throws Exception {
		
		if( !z.contains("terrain") ) {
			z = z + ".terrain";
		}
		
		HttpHeaders headers = new HttpHeaders(); 
		headers.add( HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=" + z );
		headers.add( HttpHeaders.CONTENT_ENCODING, "gzip");
		headers.add( HttpHeaders.CONTENT_TYPE, "application/octet-stream");
		
		String filePath = "/data/tilesets/terrain/" + name + "/" + x + "/" + y + "/" + z ;
		
		File file = new File( filePath );
		
		if( file.exists() ) {
		
		    Path path = Paths.get( file.getAbsolutePath() );
		    ByteArrayResource resource = new ByteArrayResource( Files.readAllBytes( path ) );
	
		    return ResponseEntity.ok()
		            .headers(headers)
		            .contentLength( file.length() )
		            .contentType( MediaType.APPLICATION_OCTET_STREAM )
		            .body( resource );		
		
		} else {
			return null;
		}
		
	}

	
	@RequestMapping(value = "/{name}/{fileName}", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE )
	public ResponseEntity<Resource> getTilesDescriptor(	@PathVariable("name") String name, @PathVariable("fileName") String fileName ) throws Exception {
		
		fileName = "layer.json";
		
		String filePath = "/data/tilesets/terrain/" + name + "/" + fileName;
		
		File file = new File( filePath );
		
		//logger.info( filePath );
		
	    Path path = Paths.get( file.getAbsolutePath() );
	    ByteArrayResource resource = new ByteArrayResource( Files.readAllBytes( path ) );

		HttpHeaders headers = new HttpHeaders(); headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + fileName );		
	    return ResponseEntity.ok()
	            .headers(headers)
	            .contentLength( file.length() )
	            .contentType( MediaType.APPLICATION_OCTET_STREAM )
	            .body( resource );		
		
		
	}
	
	

}

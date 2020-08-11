package br.mil.defesa.sisgeodef.controller;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MarineTrafficController {
	
    @RequestMapping(value = "/marinetraffic", method = RequestMethod.GET, produces=MediaType.IMAGE_PNG_VALUE )
	public ResponseEntity<byte[]> getMarineTraffic( 
			@RequestParam(value="x",required=true) Integer x, 
			@RequestParam(value="y",required=true) Integer y, 
			@RequestParam(value="z",required=true) Integer z) {
    	
		String uri = "https://tiles.marinetraffic.com/ais_helpers/shiptilesingle.aspx?output=png&sat=1&grouping=shiptype&tile_size=512&legends=1&zoom="+
				z+"&X="+x+"&Y=" + y;
		
		System.out.println( uri );
		
		byte[] image = downloadUrl( uri, x, y, x );
		
	    final HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.IMAGE_PNG);
	    headers.setContentLength(image.length);
	    
	    return new ResponseEntity<byte[]>( image, headers, HttpStatus.CREATED);
	    
    }
	
	
	private byte[] downloadUrl( String url, Integer x, Integer y, Integer z ) {
	    ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
	    try {
	    	URL toDownload = new URL(url);
	        byte[] chunk = new byte[4096];
	        int bytesRead;
	        InputStream stream = toDownload.openStream();
	        while ((bytesRead = stream.read(chunk)) > 0) {
	            outputStream.write(chunk, 0, bytesRead);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }
	    
	    byte[] image = outputStream.toByteArray();
	    try {
	    	String img = x+"-"+y+"-"+z+".jpg";
		    FileOutputStream fos = new FileOutputStream("/marinetraffic/" + img);
		    try {
		        fos.write( image );
		    } finally {
		        fos.close();
		    }
	    } catch ( Exception e ) {
	    	e.printStackTrace();
	    }
	    
	    
	    return image;
	}	

	
	
}


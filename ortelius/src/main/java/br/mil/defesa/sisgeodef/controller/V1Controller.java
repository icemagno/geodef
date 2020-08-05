package br.mil.defesa.sisgeodef.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;

@RestController
@RequestMapping("/v1")
public class V1Controller {
	private static Logger log = LoggerFactory.getLogger( V1Controller.class );

	@Autowired
	JobInfoSender sender;	
	
	@Value("${calisto.sharedfolder}")
	private String calistoFolder;   	

	@Value("${calisto.sharedfolder.url}")
	private String calistoURL;   	
	
	@Value("${ortelius.pleioneAddress}") // http://pleione:8080
	String pleioneAddress;
	
	@RequestMapping(value = "/pleione/publicar", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String publishLayer( @RequestParam(value="workspace", required = true) String workspace,
			@RequestParam(value="datastore", required = true) String datastore,
			@RequestParam(value="layername", required = true) String layerName ) {
		String result = "OK";
		try { 
                    /*
                    String cmd = "/home/pleione.sh "+datastore+" "+workspace+ " "+layerName;
                    Runtime.getRuntime().exec(cmd);
                    */
                    
			List<String> args = new ArrayList<String>();
                        
	        String ogr = "/home/pleione.sh";
	        args.add( ogr );
	        args.add( datastore );
	        args.add( workspace );
	        args.add( layerName );
	
	        @SuppressWarnings("unused")
			Process process = new ProcessBuilder( args ).directory( new File("/home/") ).start();
                        
	        
	        
		} catch ( Exception e ) {
			e.printStackTrace();
			result = e.getMessage();
		}

        //int returnCode = process.waitFor();		
		
		return result;
	}

	// http://sisgeodef.defesa.mil.br:36303/v1/pleione/savemap?l=-45&b=-24&t=-20&r=-40&width=30720&height=16880&layername=volcano:curvas-hillshade
	@RequestMapping(value = "/pleione/savemap", method = RequestMethod.GET, produces=MediaType.TEXT_PLAIN_VALUE )
	public @ResponseBody String saveImageToCalisto(	@RequestParam(value="l", required = true) String l, 
			@RequestParam(value="r", required = true) Integer r, 
			@RequestParam(value="t", required = true) Integer t, 
			@RequestParam(value="b", required = true) Integer b,
			@RequestParam(value="width", required = true) Integer width,
			@RequestParam(value="height", required = true) Integer height,
			@RequestParam(value="layername", required = true) String layerName
		) throws IOException {

		if( !calistoFolder.endsWith("/") ) calistoFolder = calistoFolder + "/";
		if( !calistoURL.endsWith("/") ) calistoURL = calistoURL + "/";
		String uuid = UUID.randomUUID().toString().replace("-", "").substring(10);
		
		String bbox = l + "," + b + "," + r + "," + t; // -42,-14,-40,-12
		String url = pleioneAddress + "/geoserver/wms?service=WMS&srs=EPSG:4326&width="+width+"&height="+height+"&version=1.1.1&request=GetMap&layers="+layerName+"&format=image/png&bbox=" + bbox;
		
		log.info( url );
		
	    try {
	        BufferedImage image = ImageIO.read(new URL( url ) );
	        ByteArrayOutputStream os = new ByteArrayOutputStream();
	        ImageIO.write(image, "jpg", os);
			String directory = calistoFolder + uuid + ".png";
	        FileOutputStream fos = new FileOutputStream(directory);
	        fos.write( os.toByteArray() );
	        fos.close();
	    } catch (Exception e ) {
	    	e.printStackTrace();
	    }
	
	    return calistoURL + uuid + ".png";
	    
	}
	
	// http://sisgeodef.defesa.mil.br:36303/v1/pleione/getmap?l=-45&b=-24&t=-20&r=-40&width=800&height=600&layername=volcano:curvas-hillshade
	// 4k = 3840 pixels wide by 2160 pixels tall
	@RequestMapping(value = "/pleione/getmap", method = RequestMethod.GET, produces=MediaType.IMAGE_PNG_VALUE )
	public void getImageAsByteArray(			@RequestParam(value="l", required = true) String l, 
			@RequestParam(value="r", required = true) Integer r, 
			@RequestParam(value="t", required = true) Integer t, 
			@RequestParam(value="b", required = true) Integer b,
			@RequestParam(value="width", required = true) Integer width,
			@RequestParam(value="height", required = true) Integer height,
			@RequestParam(value="layername", required = true) String layerName, // "volcano:curvas-hillshade";
			HttpServletResponse response) throws IOException {
		
		String bbox = l + "," + b + "," + r + "," + t; // -42,-14,-40,-12
	    try {
	        BufferedImage image = ImageIO.read(new URL( pleioneAddress + "/geoserver/wms?service=WMS&srs=EPSG:4326&width="+width+"&height="+height+"&version=1.1.1&request=GetMap&layers="+layerName+"&format=image/png&bbox=" + bbox ));
	        ByteArrayOutputStream os = new ByteArrayOutputStream();
	        ImageIO.write(image, "jpg", os);
	        InputStream is = new ByteArrayInputStream(os.toByteArray());	        
		    response.setContentType(MediaType.IMAGE_PNG_VALUE);
		    IOUtils.copy(is, response.getOutputStream() );
	    } catch (Exception e ) {
	    	
	    }
		
	}
	
	
	
}

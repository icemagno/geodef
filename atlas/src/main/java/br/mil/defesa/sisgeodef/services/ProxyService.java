package br.mil.defesa.sisgeodef.services;

import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.model.CatalogSource;

@Service
public class ProxyService {
	private Map<String,String> keys = new HashMap<String,String>();
	
	@Value("${proxy.useProxy}")
	private boolean useProxy;		
	
    @Autowired
    AuthService authService;		
	
	@Autowired
	private CatalogService catalogService;		
	
	public String getLegend(String uuid, Integer sourceId, String bn, String bs, String be, String bw) {
		String fileName = UUID.randomUUID().toString().replaceAll("-", "") + ".png"; 
		String path = "/srv/calisto/legends/";
		String urlPath = "http://sisgeodef.defesa.mil.br/calisto/legends/" + fileName;
		String target = path + fileName;
		File fil = new File( path );
		fil.mkdirs();
		
		CatalogSource source = catalogService.getSource(sourceId);
		if( source != null ) {

			
			if ( keys.containsKey( uuid ) ) {
				String oldFile = keys.get( uuid );
				new File( oldFile ).delete();
				System.out.println("Apaguei o arquivo " + oldFile );
				keys.replace( uuid , fileName);
				System.out.println("Atualizei a chave para o aquivo " + fileName );
			} else {
				System.out.println("Criei chave para o aquivo " + fileName );
				keys.put( uuid , fileName );
			}			
			
			
			String bbox = "";
			if( bn != null && !bn.equals("") ) {
				bbox = "&bbox=" + bw + "," + bs + "," + be + "," + bn;
			}
			
			// var getLegendUrl = data.sourceAddress + "?service=wms&REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=" + data.sourceLayer;
			String urlSource = source.getSourceAddressOriginal() + 
					"?service=WMS&REQUEST=GetLegendGraphic&VERSION=1.1.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=" + source.getSourceLayer() + 
					"&LEGEND_OPTIONS=layout:vertical;columns:1;hideEmptyRules:true;fontAntiAliasing:true;countMatched:true" + bbox;
			
			System.out.println( "GetLegend: " + urlSource );
			
			try {
				InputStream in = new URL( urlSource ).openStream() ;
				Files.copy( in, Paths.get( target ) );
			} catch ( Exception e ) {
				urlPath = "";
			}
		} else {
			urlPath = "";
		}
		
		return urlPath;
	}

	public String getFeature(String uuid, Integer sourceId, String bn, String bs, String be, String bw) {
		// http://localhost:36215/proxy/getfeature?bw=3&bs=3&bn=4&be=3&sourceId=456&uuid=fdf
		String url = "http://portal.iphan.gov.br/geoserver/CNA/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=CNA:cnigp&maxFeatures=5&outputFormat=application/json";
		String result = "";
		
		RestTemplate restTemplate;
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate( );
		}		
		
		restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(Charset.forName("UTF-8")));
		
		try {
			HttpHeaders headers = new HttpHeaders();
		    List<MediaType> mediaTypeList = new ArrayList<MediaType>();
		    //mediaTypeList.add( ( MediaType.APPLICATION_JSON ) );
		    Charset utf8 = Charset.forName("UTF-8");
		    mediaTypeList.add( new MediaType("application", "xml", utf8) );
			headers.setAccept( mediaTypeList );
			
			HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
			
	        ResponseEntity<String> resultRest = restTemplate.exchange( url, HttpMethod.GET, entity, String.class);
			result = resultRest.getBody().toString();

			System.out.println( result );
			
		} catch ( Exception e ) {
			
		}
		
		return result;
		
	}

}

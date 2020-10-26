package br.mil.defesa.sisgeodef.services;

import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
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
    private LoadBalancerClient loadBalancer;    
	
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

	public String getFeature(String userId, Integer sourceId, String bn, String bs, String be, String bw) {
		
		CatalogSource source = catalogService.getSource(sourceId);
		if( source != null ) {
			ServiceInstance reaperInstance = loadBalancer.choose("reaper");
			String reaperAddress = reaperInstance.getUri().toString(); 
			String uri = reaperAddress +  "/import";
	
			RestTemplate restTemplate = new RestTemplate();
	    	
			HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
	
		    MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
		    map.add("userId", userId );
		    map.add("layer", source.getSourceLayer() );
		    map.add("url", source.getSourceAddressOriginal() );
		    map.add("bn", bn );
		    map.add("bs", bs );
		    map.add("be", be );
		    map.add("bw", bw );
		    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(map, headers);
		    
	        String responseBody = "[]";
	        try {
	        	ResponseEntity<String> result = restTemplate.postForEntity( uri, request, String.class);        
	        	responseBody = result.getBody().toString();
	        
			} catch ( HttpClientErrorException e) {
			    responseBody = e.getResponseBodyAsString();
			    String statusText = e.getStatusText();
			    System.out.println( statusText );
			} catch ( Exception ex) {
				return ex.getMessage();
			}
	        
	        System.out.println(" > " + responseBody );
		}
		return "";
	}

}

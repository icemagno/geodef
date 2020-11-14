package br.mil.defesa.sisgeodef.services;

import java.io.File;
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
				keys.replace( uuid , fileName);
			} else {
				keys.put( uuid , fileName );
			}			
			
			
			String bbox = "";
			if( bn != null && !bn.equals("") ) {
				bbox = "&bbox=" + bw + "," + bs + "," + be + "," + bn;
			}
			
			
			RestTemplate restTemplate;
			if( useProxy ) {
				restTemplate = new RestTemplate( authService.getFactory() );
			} else {
				restTemplate = new RestTemplate( );
			}
					
			String sao = source.getSourceAddressOriginal();
			if( sao.contains("http://sisgeodef.defesa.mil.br") ) {
				sao = "http://pleione:8080/geoserver/wms";
			}
			
			String urlSource = sao + 
					"?service=WMS&REQUEST=GetLegendGraphic&VERSION=1.1.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=" + source.getSourceLayer() + 
					"&LEGEND_OPTIONS=layout:vertical;columns:1;hideEmptyRules:true;fontAntiAliasing:true;countMatched:true" + bbox;
			
			System.out.println( urlSource );
			
			try {
				byte[] imageBytes = restTemplate.getForObject( urlSource, byte[].class );
				Files.write(Paths.get( target ), imageBytes);			
			} catch ( Exception e ) {
				e.printStackTrace();
				urlPath = "";
			}
			
		} else {
			urlPath = "";
		}
		
		return urlPath;
	}

	public String getFeature(String userId, Integer sourceId, String bn, String bs, String be, String bw) {
		String responseBody = "[]";		
		CatalogSource source = catalogService.getSource(sourceId);
		if( source != null ) {
			ServiceInstance reaperInstance = loadBalancer.choose("reaper");
			String reaperAddress = reaperInstance.getUri().toString(); 
			String uri = reaperAddress +  "/import";
	
			RestTemplate restTemplate = new RestTemplate();
	    	
			HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
	
			String sao = source.getSourceAddressOriginal();
			if( sao.contains("http://sisgeodef.defesa.mil.br") ) {
				sao = "http://pleione:8080/geoserver/wms";
			}
			
		    MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
		    map.add("userId", userId );
		    map.add("layer", source.getSourceLayer() );
		    map.add("url", sao );
		    map.add("bn", bn );
		    map.add("bs", bs );
		    map.add("be", be );
		    map.add("bw", bw );
		    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<MultiValueMap<String, String>>(map, headers);
		    
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
		}
		return responseBody;
	}

	public String getFeatureInfo(Integer sourceId, String lat, String lon) {
		String responseBody = "[]";
		CatalogSource source = catalogService.getSource(sourceId);
		if( source != null ) {
			
			String url = source.getSourceAddressOriginal();
			if( url.contains("http://sisgeodef.defesa.mil.br") ) {
				url = "http://pleione:8080/geoserver/wms";
			}

			double latD = Double.valueOf( lat );
			double lonD = Double.valueOf( lon );
			double bw = lonD - 0.01;
			double be = lonD + 0.01;
			double bn = latD + 0.01;
			double bs = latD - 0.01;
			
			String bbox = "&bbox=" + bs + "," + bw + "," + bn + "," + be;
			//String bbox = lat + "," + lon + "," + lat + "," + lon;
			String sourceUrl = url + "?service=wfs"
					+ "&version=2.0.0"
					+ "&request=GetFeature"
					+ "&BBOX=" + bbox
					+ "&typeName=" + source.getSourceLayer()
					+ "&outputFormat=application/json"
					+ "&count=5";

			
			System.out.println( sourceUrl );
			
			RestTemplate restTemplate;
			if( useProxy ) {
				restTemplate = new RestTemplate( authService.getFactory() );
			} else {
				restTemplate = new RestTemplate( );
			}
			
			
			try {
				ResponseEntity<String> result = restTemplate.getForEntity( sourceUrl, String.class);
				responseBody = result.getBody().toString();
			} catch (HttpClientErrorException e) {
				responseBody = e.getResponseBodyAsString();
			} catch ( Exception ex) {
				return ex.getMessage();
			}
			
		}

		
		
		return responseBody;
	}

}

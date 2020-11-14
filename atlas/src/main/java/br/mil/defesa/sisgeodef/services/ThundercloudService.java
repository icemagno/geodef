package br.mil.defesa.sisgeodef.services;

import org.springframework.beans.factory.annotation.Autowired;
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

@Service
public class ThundercloudService {

    @Autowired
    private LoadBalancerClient loadBalancer;

    
    public String getMunicipios( String data ) {
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
		String uri = thundercloudAddress +  "/ibge/municipios";

		RestTemplate restTemplate = new RestTemplate();
    	
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
	    map.add("lineString", data);
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
		return responseBody ;
        
    }
    
	
    public String getAerodromos( String data ) {
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress +  "/aisweb/aerodromos";
		System.out.println( uri );

		RestTemplate restTemplate = new RestTemplate();
    	
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
	    map.add("lineString", data);
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
		return responseBody ;
        
    }

    
	public String getRadares() {
		
		String uri = "https://www.redemet.aer.mil.br/produtos/radares-meteorologicos/plota_radar.php";
		System.out.println( uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		
		System.out.println( responseBody );
		
		return responseBody ;
	}
    
    
    
	public String getCorMeteorologica( ) {
		
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress + "/metar/retrieve";
		System.out.println( uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody ;
	}

	
	public String getGoesImage( String regiao, String parametro, String data ) {
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress + "/inmet/goes/" + regiao + "/" + parametro + "/" + data;
		System.out.println( uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody ;
		
	}

	public String getEstacoes(String data) {
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress +  "/inmet/estacoes";
		System.out.println( uri );

		RestTemplate restTemplate = new RestTemplate();
    	
		HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

	    MultiValueMap<String, String> map= new LinkedMultiValueMap<String, String>();
	    map.add("lineString", data);
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
		return responseBody ;
        
	}


	public String getPrevisaoMunicipio(String geocode) {
		
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress + "/inmet/municipio/" + geocode;
		System.out.println( uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
		
	}


	public String getPrevisaoAerodromo(String icao) {
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
			
		String uri = thundercloudAddress + "/aisweb/aerodromo/" + icao;
		System.out.println( uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}


	public String getGoesImageHour(String regiao, String parametro, String data, String hora) {
		ServiceInstance thundercloudInstance = loadBalancer.choose("thundercloud");
		String thundercloudAddress = thundercloudInstance.getUri().toString(); 
		String uri = thundercloudAddress + "/inmet/goes/" + regiao + "/" + parametro + "/" + data + "/" + hora;
		System.out.println( uri );

		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody ;
	}    
	
}

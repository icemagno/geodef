package br.mil.defesa.sisgeodef.services;


import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsonorg.JsonOrgModule;

import br.mil.defesa.sisgeodef.misc.cartografia.Classe;
import br.mil.defesa.sisgeodef.misc.cartografia.IClasse;

@Service
public class CartografiaIndexService {
	private String terrestre;
	private String nautica;
	private String aeronautica;
	private List<IClasse> classes;
	private Logger logger = LoggerFactory.getLogger(CartografiaIndexService.class);
	private JSONObject tree = new JSONObject();
	
    @Autowired
    private LoadBalancerClient loadBalancer;	
    
	public CartografiaIndexService() {
		this.classes = new ArrayList<IClasse>();
	}
	
	private String getIndex( String fonte ) {
		
		ServiceInstance orteliusInstance = loadBalancer.choose("ortelius");
		String orteliusAddress = orteliusInstance.getUri().toString(); 		
		
		String responseBody = "";
		try {
			String uri = orteliusAddress + "/v1/pleione/catalog?fonte=" + fonte;
			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<String> result = restTemplate.getForEntity(uri, String.class);
			responseBody = result.getBody();
		} catch ( Exception e ) {
			e.printStackTrace();
			logger.error( e.getMessage() );
			responseBody = "{\"error\":\"" + e.getMessage() + "\"}";
		}
		return responseBody;
	}

	public void acquire() throws Exception {
		logger.info("Adquirindo Cartografia Terrestre...");
		terrestre = getIndex( "terrestre");
		JSONArray arr = new JSONObject( terrestre ).getJSONArray("terrestre");
		tree.put("terrestre", arr);
		for( int x = 0; x < arr.length(); x++ ) {
			JSONObject obj = arr.getJSONObject(x);
			JSONArray classes = obj.getJSONArray("classes");
			for( int y = 0; y < classes.length(); y++ ) {
				ObjectMapper mapper = new ObjectMapper().registerModule( new JsonOrgModule() );
				IClasse classe = mapper.convertValue(classes.get(y), Classe.class);
				this.classes.add( classe );
			}
		}
		logger.info("Concluido.");

		
		logger.info("Adquirindo Cartografia Nautica...");
		nautica = getIndex("nautica");
		
		JSONArray classes = new JSONObject( nautica ).getJSONObject("nautica").getJSONArray("classes");
		tree.put("nautica", classes);
		for( int x = 0; x < classes.length(); x++ ) {
			ObjectMapper mapper = new ObjectMapper().registerModule( new JsonOrgModule() );
			IClasse classe = mapper.convertValue(classes.get(x), Classe.class);
			this.classes.add( classe );
		}
		logger.info("Concluido.");

		
		logger.info("Adquirindo Cartografia Aeronautica...");
		aeronautica = getIndex("aeronautica");
		
		JSONArray classesN = new JSONObject( aeronautica ).getJSONObject("aeronautica").getJSONArray("classes");
		tree.put("aeronautica", classesN);
		for( int x = 0; x < classesN.length(); x++ ) {
			ObjectMapper mapper = new ObjectMapper().registerModule( new JsonOrgModule() );
			IClasse classe = mapper.convertValue(classesN.get(x), Classe.class);
			this.classes.add( classe );
		}
		logger.info("Concluido.");

		if ( this.classes.size() == 0 ) {
			logger.warn("Buffer de Cartografia vazio.");
		}
		
	}

	public List<IClasse> find( String nome, int limite ) throws Exception {
		List<IClasse> result = new ArrayList<IClasse>();
		try {
			for( IClasse classe : this.classes ) {
				if( classe.getNome().toLowerCase().contains( nome.toLowerCase() ) ) {
					if( (result.size() < limite) && ( !result.contains( classe ) ) ) result.add( classe );
				}
			}
		} catch ( Exception e ) {
			logger.error( e.getMessage() );
		}
		return result;
	}
	
	public String getTree() {
		return tree.toString();
	}
	
	public String getTerrestre() {
		return terrestre;
	}

	public String getNautica() {
		return nautica;
	}

	public String getAeronautica() {
		return aeronautica;
	}
	
}

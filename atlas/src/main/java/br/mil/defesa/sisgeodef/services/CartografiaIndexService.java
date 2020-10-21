package br.mil.defesa.sisgeodef.services;


import java.util.ArrayList;
import java.util.Iterator;
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
import br.mil.defesa.sisgeodef.model.CatalogSource;
import br.mil.defesa.sisgeodef.repository.CatalogSourcesRepository;

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

	@Autowired
	CatalogSourcesRepository catalogSourcesRepository;    
    
	public CartografiaIndexService() {
		this.classes = new ArrayList<IClasse>();
	}
	
	
	public void importBDGEXtree() {
		terrestre = getIndex( "terrestre");
		JSONArray arr = new JSONObject( terrestre ).getJSONArray("terrestre");
		JSONObject mainData = new JSONObject();
		
		for( int x = 0; x < arr.length(); x++ ) {
			JSONObject obj = arr.getJSONObject(x);
			String categoria = obj.getString("categoria");
			JSONArray classes = obj.getJSONArray("classes");
			for( int y = 0; y < classes.length(); y++ ) {
				JSONObject classe = classes.getJSONObject( y );
				String workspace = classe.getString("workspace");
				String nome = classe.getString("nome");
				JSONArray layers = classe.getJSONArray("layers");
				for( int z = 0; z < layers.length(); z++ ) {
					JSONObject layer = layers.getJSONObject(z);
					String layerName = layer.getString("layer");
					JSONArray escalas = layer.getJSONArray("escalas");
					for( int w = 0; w < escalas.length(); w++ ) {
						String escala = escalas.getString( w );
						String layerFullName = workspace + ":" + layerName;
						JSONObject escalaObj;
						JSONObject categoriaObj;
						try {
							escalaObj = mainData.getJSONObject( escala );
							try {
								categoriaObj = escalaObj.getJSONObject( categoria );
							} catch ( Exception ee ) {
								categoriaObj = new JSONObject();
							}
							categoriaObj.put( nome, layerFullName );
							escalaObj.put( categoria, categoriaObj );
						} catch ( Exception e ) {
							escalaObj = new JSONObject();
							categoriaObj = new JSONObject();
							categoriaObj.put( nome, layerFullName );
							escalaObj.put( categoria, categoriaObj );
							mainData.put( escala, escalaObj );
						}
					}
					
				}				
				
			}
		}
		
		Iterator<String> iter = mainData.keys();
	    while( iter.hasNext() ){
	        String escala = iter.next();
	        JSONObject categoria = mainData.getJSONObject( escala );
	        
			CatalogSource escalaModel = new CatalogSource();
			escalaModel.setParentId( 7 ); // Geoinformação Terrestre - DSG - Vetorial
			escalaModel.setDescription( "Escala " + escala );
			escalaModel.setSourceName( "1:" + escala );
			escalaModel.setSourceAddress( "***" );
			escalaModel.setSourceLayer( null );
			escalaModel.setBbox( null );
			
			catalogSourcesRepository.saveAndFlush( escalaModel );

			Iterator<String> iter2 = categoria.keys();
			while( iter2.hasNext() ){
		        String nome = iter2.next();
		        JSONObject classes = categoria.getJSONObject( nome );
		        
		        CatalogSource classeModel = new CatalogSource();
		        classeModel.setParentId( escalaModel.getId().intValue() ); 
		        classeModel.setDescription( nome );
		        classeModel.setSourceName( nome );
		        classeModel.setSourceAddress( "***" );
		        classeModel.setSourceLayer( null );
		        classeModel.setBbox( null );
				
				catalogSourcesRepository.saveAndFlush( classeModel );
		        
				Iterator<String> iter3 = classes.keys();
				while( iter3.hasNext() ){
			        String classeName = iter3.next();
			        String layerName = classes.getString( classeName );				

			        CatalogSource layerModel = new CatalogSource();
			        layerModel.setParentId( classeModel.getId().intValue() ); 
			        layerModel.setDescription( classeName );
			        layerModel.setSourceName( classeName );
			        layerModel.setSourceAddress( "http://sisgeodef.defesa.mil.br/geoserver/wms");
			        layerModel.setSourceLayer( layerName );
			        layerModel.setCqlFilter( "escala=" + escala );
			        layerModel.setBbox( null );
			        // http://sisgeodef.defesa.mil.br/geoserver/wms?cql_filter=escala=25000&service=WMS&version=1.1.0&request=GetMap&layers=odisseu:nome_local_p&styles=&bbox=-180.0,-78.611,180.0,89.299&width=768&height=358&srs=EPSG:4326&format=application/openlayers
			        catalogSourcesRepository.saveAndFlush( layerModel );
			        
				}
				
			}

			
	        
	    }
		
		System.out.println( mainData.toString() );
		
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

	public void acquire( int xx ) throws Exception {
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

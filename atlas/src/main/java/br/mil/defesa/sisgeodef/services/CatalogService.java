package br.mil.defesa.sisgeodef.services;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.XML;
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
import br.mil.defesa.sisgeodef.repository.CatalogSourcesRepository;

@Service
public class CatalogService {
	
	@Autowired
	CatalogSourcesRepository catalogSourcesRepository;

	@Value("${proxy.useProxy}")
	private boolean useProxy;		
	
    @Autowired
    AuthService authService;	
	
    
    public String exportToMapProxy( Integer parentId ) {
    	StringBuilder sbLayers = new StringBuilder();
    	StringBuilder sbCaches = new StringBuilder();
    	StringBuilder sbSources = new StringBuilder();
    	
    	Optional<CatalogSource> sourceObj = catalogSourcesRepository.findById( parentId.longValue() );
		if( sourceObj.isPresent() ) {
			CatalogSource source = sourceObj.get();
			
			sbLayers.append("layers:\n");
			for( CatalogSource child : source.getSources() ) {
				String sourceLayer = child.getSourceLayer();
				String sourceAddress = child.getSourceAddress();
				String titulo = "Migração Automática";//child.getDescription();
				
				sbSources.append("  " + sourceLayer + "_wms:\n" );
				sbSources.append("    type: wms\n");
				sbSources.append("    wms_opts:\n");
				sbSources.append("      legendgraphic: true\n");				
				sbSources.append("      featureinfo: true\n");				
				sbSources.append("    req:\n");
				sbSources.append("      url: "+ sourceAddress +"\n");
				sbSources.append("      layers: "+ sourceLayer + "\n");
				sbSources.append("      transparent: true\n");
				
				sbCaches.append("  " + sourceLayer + "_cache:\n" );		// <<<--- Precisa remover o workspace: antes do nome da camada
				sbCaches.append("    grids: [geodetic]\n");
				sbCaches.append("    sources: [" + sourceLayer + "_wms]\n");
				sbCaches.append("    link_single_color_image: true\n");
				sbCaches.append("    format: custom_format\n");
				sbCaches.append("    request_format: image/png\n");
				sbCaches.append("    transparent: true\n");
				
				sbLayers.append("  - name: " + sourceLayer + "\n" );
				sbLayers.append("    title: " + titulo +  "\n");
				sbLayers.append("    sources: [" + sourceLayer + "_cache]\n");
			}
		}
		
		sbLayers.append("\n");
		sbLayers.append("caches:\n");
		sbLayers.append( sbCaches.toString() );
		sbLayers.append("\n");
		sbLayers.append("sources:\n");
		sbLayers.append( sbSources.toString() );
    	return sbLayers.toString();
    }
    
	public void importCapabilities( int parentId, String capabilitiesUrl ) {
		
		System.out.println(" **************************  " + useProxy + "  ************************");
		System.out.println( capabilitiesUrl );
		
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
			
	        ResponseEntity<String> result = restTemplate.exchange(capabilitiesUrl, HttpMethod.GET, entity, String.class);
			String responseBody = result.getBody().toString();

			JSONObject capabilities = XML.toJSONObject( responseBody );
			
			System.out.println( capabilities.toString() );
			
			JSONObject capability;
			try {
				capability = capabilities.getJSONObject("WMS_Capabilities").getJSONObject("Capability");
			} catch ( JSONException e ) {
				capability = capabilities.getJSONObject("WMT_MS_Capabilities").getJSONObject("Capability");
			}
				
			String serviceAddress = capability.getJSONObject("Request")
					.getJSONObject("GetMap")
					.getJSONObject("DCPType")
					.getJSONObject("HTTP")
					.getJSONObject("Get")
					.getJSONObject("OnlineResource")
					.getString("xlink:href");
			
			if( serviceAddress.endsWith("?") ) serviceAddress = serviceAddress.replace("?", "");
			
			JSONObject layerData = capability.getJSONObject("Layer");
			JSONArray layers = layerData.getJSONArray("Layer");
			
			
			for( int x=0; x < layers.length(); x++ ) {
				JSONObject layer = layers.getJSONObject( x );

				JSONObject latLonBoundingBox;
				try {
					latLonBoundingBox = layer.getJSONObject("LatLonBoundingBox");
				} catch ( Exception exc ) {
					latLonBoundingBox = new JSONObject("{}");
				}
				
				CatalogSource source = new CatalogSource();
				source.setParentId(parentId);
				source.setDescription( layer.getString("Abstract") );
				source.setSourceName( layer.getString("Title") );
				source.setSourceAddress( serviceAddress );
				source.setSourceLayer( layer.getString("Name")  );
				source.setBbox( latLonBoundingBox.toString() );
				
				catalogSourcesRepository.saveAndFlush( source );
			}
			
			
			
		} catch ( Exception ex) {
			ex.printStackTrace();
		}
		
		
	}

	public List<CatalogSource> getSources(Integer parentId) {
    	Optional<CatalogSource> sourceObj = catalogSourcesRepository.findById( parentId.longValue() );
    	List<CatalogSource> result = new ArrayList<CatalogSource>();
		if( sourceObj.isPresent() ) {
			for( CatalogSource ss :  sourceObj.get().getSources() ) {
				ss.getSources().clear();
				result.add( ss );
			}
		}
		return result;
	}
	
	
}

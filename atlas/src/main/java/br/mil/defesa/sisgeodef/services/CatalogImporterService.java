package br.mil.defesa.sisgeodef.services;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

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
public class CatalogImporterService {
	
	@Autowired
	CatalogSourcesRepository catalogSourcesRepository;

	@Value("${proxy.useProxy}")
	private boolean useProxy;		
	
    @Autowired
    AuthService authService;	
	
	public void importCapabilities( int parentId, String capabilitiesUrl ) {
		
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
	
	
}

package br.mil.defesa.sisgeodef.worker;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import br.mil.defesa.sisgeodef.services.ImportService;

public class Worker {
	private Logger logger = LoggerFactory.getLogger(Worker.class);

	@Autowired
	private ImportService importService;	
	
	private String url;
	private int count = 2000;
	private int startIndex = 0;
	private boolean working = false;
	private long total = 0;
	private boolean stop = false;
	
	public Worker( String url ) {
		
		String source = url + "?service=wfs"
				+ "&version=2.0.0"
				+ "&request=GetFeature"
				+ "&typeName=gebco:gebco_poly_2014"
				+ "&outputFormat=application/json"
				+ "&count=" + count
				+ "&startIndex=";
		
		this.url = source;
	}
	
	public void stop() {
		this.stop = true;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void doImport() {
		
		if( this.working || this.stop ) return;
		this.working = true;

		String uri = url +  startIndex;
		String result = importService.getFeatures( uri );
		
		JSONObject collection = new JSONObject( result );
		JSONArray features = collection.getJSONArray("features");
		int length = features.length();
		total = total + length;
		
		if( length == 0 ) {
			stop = true;
			logger.info("Requisição retornou 0. Processei um total de " + total + "registros.");
		} else {
			logger.info("Processei mais " + length + " registros. Total: " + total );
		}
		
		importService.insert( features );
		
		this.startIndex = startIndex + count;
		this.working = false;
		
	}

}

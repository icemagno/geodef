package br.mil.defesa.sisgeodef.worker;

import java.util.UUID;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import br.mil.defesa.sisgeodef.services.ImportService;

public class Worker {
	private Logger logger = LoggerFactory.getLogger(Worker.class);

	private String url;
	private int count = 2000;
	private int startIndex = 0;
	private boolean working = false;
	private long total = 0;
	private boolean stop = false;
	private String userCpf;
	private String opId;
	private ImportService importService;

	public Worker( String url, String userCpf, String layerName, String bn, String bs, String be, String bw, ImportService importService ) {
		this.userCpf = userCpf;
		this.importService = importService;
		this.opId = UUID.randomUUID().toString().replace("-", "");
		
		String bbox = bs + "," + bw + "," + bn + "," + be;
		
		String source = url + "?service=wfs"
				+ "&version=2.0.0"
				+ "&request=GetFeature"
				+ "&BBOX=" + bbox
				+ "&typeName=" + layerName
				+ "&outputFormat=application/json"
				+ "&count=" + count
				+ "&startIndex=";
		
		this.url = source;
	}
	
	public boolean isWorking() {
		// Nao eh pra saber se ele ta atuando no momento (working)
		// eh pra saber se ele ja acabou ( stop = true ) 
		return ( this.stop == false );
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
		
		try {
			JSONObject collection = new JSONObject( result );
			JSONArray features = collection.getJSONArray("features");
			int length = features.length();
			this.total = this.total + length;
			
			if( length == 0 ) {
				this.stop = true;
				logger.info(opId + ": Requisição retornou 0. Processei um total de " + total + "registros.");
			} else {
				importService.insert( features, userCpf, opId );
				this.startIndex = startIndex + count;
				logger.info(opId + ": Processei mais " + length + " registros. Total: " + total );
			}
		} catch ( Exception e ) {
			logger.error( e.getMessage() );
			this.stop = true;
		}
		this.working = false;
		
	}

	public long getTotal() {
		return total;
	}
	
	public String getOpId() {
		return opId;
	}
}

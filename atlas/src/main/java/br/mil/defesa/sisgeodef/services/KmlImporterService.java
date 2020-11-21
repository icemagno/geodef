package br.mil.defesa.sisgeodef.services;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.misc.UploadRequest;

@Service
public class KmlImporterService {

	public String toJson( UploadRequest request, String filePath ) {
		JSONObject fc = new JSONObject();
		fc.put("filePath", filePath);
		return fc.toString();
	}	
	
}

package br.mil.defesa.sisgeodef.services;

import org.json.JSONObject;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.misc.UploadRequest;

@Service
public class KmlImporterService {

    private String urlPath = "http://sisgeodef.defesa.mil.br/calisto/uploads/";
	
	public String toJson( UploadRequest request, String fileName ) {
		JSONObject fc = new JSONObject();
		fc.put("fileName", urlPath + fileName);
		return fc.toString();
	}	
	
}

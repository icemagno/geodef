package br.mil.defesa.sisgeodef.services;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.misc.UploadRequest;

@Service
public class CsvImporterService {
	
	public String toJson( UploadRequest request, String filePath ) {
		JSONObject fc = new JSONObject();
		// LAT, LON, TEXTO
		// -13,195341449999999;-59,7813019500000;COMODORO-MT/Apreensão de Madeira
		
		/*
		{
		  "type": "Feature",
		  "geometry": {
		    "type": "Point",
		    "coordinates": [125.6, 10.1]
		  },
		  "properties": {
		    "name": "Dinagat Islands"
		  }
		}
		*/		
		
		/*
		{
		  "type": "FeatureCollection",
		  "features": [
		    {
		      "type": "Feature",
		      "properties": {
		        "population": 200
		      },
		      "geometry": {
		        "type": "Point",
		        "coordinates": [-112.0372, 46.608058]
		      }
		    }
		  ]
		}		
		*/
		
		try {
			JSONArray features = new JSONArray();
			
			fc.put("type", "FeatureCollection");
			
			try (BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath), "UTF-8"))) {
			    String line;
			    while ((line = br.readLine()) != null) {
			    	String[] data = line.split(";");
			    	String lat = data[0].replace(",", ".").replaceAll("\\p{C}", "").trim();
			    	String lon = data[1].replace(",", ".").replaceAll("\\p{C}", "").trim();
			    	String texto = data[2];
			       
			    	JSONObject props = new JSONObject();
			        props.put("texto", texto);
			        
			    	JSONObject geom = new JSONObject();
			    	geom.put("type", "Point");
			        
			    	JSONArray coordinates = new JSONArray();
			    	float latF = Float.parseFloat( lat );
			    	float lonF = Float.parseFloat( lon );
			    	coordinates.put( lonF );
			    	coordinates.put( latF );
			    	
			    	geom.put("coordinates", coordinates);
			        
			        JSONObject feature = new JSONObject();
			        feature.put("type", "Feature");
			        feature.put("geometry", geom );
			        feature.put("properties", props);
			        
			    	features.put( feature );
			    }
			}		

			fc.put("features", features);
			
		} catch ( Exception ex ) {
			ex.printStackTrace();
		}
		
		return fc.toString();
	}
	
}

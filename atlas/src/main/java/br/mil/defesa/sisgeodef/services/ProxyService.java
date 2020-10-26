package br.mil.defesa.sisgeodef.services;

import java.io.File;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.model.CatalogSource;

@Service
public class ProxyService {

	
	@Autowired
	private CatalogService catalogService;		
	
	public String getLegend(String uuid, Integer sourceId, String bn, String bs, String be, String bw) {
		String fileName = uuid.replaceAll("-", "") + ".png";
		String path = "/srv/calisto/legends/";
		String urlPath = "http://sisgeodef.defesa.mil.br/calisto/legends/" + fileName;
		String target = path + fileName;
		File fil = new File( path );
		fil.mkdirs();
		
		CatalogSource source = catalogService.getSource(sourceId);
		if( source != null ) {
		
			String bbox = "";
			if( bn != null && !bn.equals("") ) {
				bbox = "&bbox=" + bw + "," + bs + "," + be + "," + bn;
			}
			
			// var getLegendUrl = data.sourceAddress + "?service=wms&REQUEST=GetLegendGraphic&VERSION=1.0.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=" + data.sourceLayer;
			String urlSource = source.getSourceAddressOriginal() + 
					"?service=WMS&REQUEST=GetLegendGraphic&VERSION=1.1.0&FORMAT=image/png&WIDTH=20&HEIGHT=20&LAYER=" + source.getSourceLayer() + 
					"&LEGEND_OPTIONS=layout:vertical;columns:2;hideEmptyRules:true;fontAntiAliasing:true;countMatched:true" + bbox;
			
			System.out.println( "GetLegend: " + urlSource );
			
			try {
				InputStream in = new URL( urlSource ).openStream() ;
				Files.copy( in, Paths.get( target ) );
			} catch ( Exception e ) {
				urlPath = "";
			}
		} else {
			urlPath = "";
		}
		
		return urlPath;
	}

}

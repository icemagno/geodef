package br.mil.defesa.sisgeodef.services;

import java.io.File;

import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.Geometry;
import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.stereotype.Service;

import com.wdtinc.mapbox_vector_tile.adapt.jts.MvtReader;
import com.wdtinc.mapbox_vector_tile.adapt.jts.TagKeyValueMapConverter;
import com.wdtinc.mapbox_vector_tile.adapt.jts.model.JtsLayer;
import com.wdtinc.mapbox_vector_tile.adapt.jts.model.JtsMvt;

@Service
public class VectorTileService {
	
	public void readVT() throws Exception {
		GeometryFactory geomFactory = new GeometryFactory();
		
		JtsMvt jtsMvt = MvtReader.loadMvt( new File("/pbf/31.vector.pbf"), geomFactory, new TagKeyValueMapConverter(), MvtReader.RING_CLASSIFIER_V1);
		
		for( JtsLayer layer : jtsMvt.getLayers() ) {
			System.out.println( "Camada " + layer.getName() + " : ");

			for( Geometry geometry : layer.getGeometries() ) {
				System.out.println( " >> User Data : " + geometry.getUserData().toString() ); 
				System.out.println( " >> SRID      : " + geometry.getSRID() ); 
				System.out.println( " >> Geom Type : " + geometry.getGeometryType() + " : " );
				
				for( Coordinate coord : geometry.getCoordinates() ) {
					System.out.println( "   >>> " + coord.toString() );
				}
			}
			
		}
		
	}

}

package br.mil.defesa.sisgeodef.misc;

import java.util.ArrayList;
import java.util.List;

import br.mil.defesa.sisgeodef.model.GeoAirport;

public class ResultList {
	private List<GeoAirport> airports;
	
	public ResultList() {
		this.airports = new ArrayList<GeoAirport>();	
	}

	public synchronized void addAirport( GeoAirport airport ) {
		this.airports.add( airport );
	}
	
	public List<GeoAirport> getAirports() {
		return airports;
	}
	
	public void addAll( ResultList sourceList ) {
		airports.addAll( sourceList.getAirports() );
	}
	
}

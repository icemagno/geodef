package br.mil.defesa.sisgeodef.misc;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

public class Cartas {
	private List<Carta> cartas;
	
	public Cartas( JSONObject cartasObj ) {
		this.cartas = new ArrayList<Carta>();
		
		JSONObject aisweb = cartasObj.getJSONObject("aisweb");
		JSONArray lista = aisweb.getJSONObject("cartas").getJSONArray("item");
		
		for ( int x=0; x < lista.length(); x++ ) {
			JSONObject cartaObj = lista.getJSONObject( x ); 
			this.cartas.add( new Carta( cartaObj ) );
		}
			 
	}
		 
	
	public void addCarta( Carta carta ) {
		this.cartas.add( carta );
	}

	public List<Carta> getCartas() {
		return cartas;
	}

	public void setCartas(List<Carta> cartas) {
		this.cartas = cartas;
	}

	public JSONArray getCartas( String icao ) {
		JSONArray array = new JSONArray();
		
		for( Carta carta : this.cartas ) {
			if( carta.getIcao().trim().equals( icao ) || carta.getIcao().trim().contains( icao ) ) {
				array.put( carta.getData() );
			}
		}
		
		return array;
	}
	
}

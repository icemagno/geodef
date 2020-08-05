package br.mil.defesa.sisgeodef.misc;

import org.json.JSONObject;

public class Carta {
	private String icao;
	private JSONObject data;
	
	public Carta( JSONObject cartaObj ) {
		this.icao = cartaObj.getString("IcaoCode");
		this.data = cartaObj;
	}
	
	public String getIcao() {
		return icao;
	}
	
	public void setIcao(String icao) {
		this.icao = icao;
	}
	
	public JSONObject getData() {
		return data;
	}
	
	public void setData(JSONObject data) {
		this.data = data;
	}
	
	

}

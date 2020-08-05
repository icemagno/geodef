package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

public class BlockedArea implements Serializable {
	private static final long serialVersionUID = 1L;
	private String latitude;
	private String longitude;
	private String raio;
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getRaio() {
		return raio;
	}
	public void setRaio(String raio) {
		this.raio = raio;
	}
}

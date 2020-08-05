package br.mil.defesa.sisgeodef.misc.cartografia;

import java.util.List;

public class Layer {
	private String layer;
	private List<String> escalas;
	
	public String getLayer() {
		return layer;
	}
	
	public void setLayer(String layer) {
		this.layer = layer;
	}
	
	public List<String> getEscalas() {
		return escalas;
	}
	
	public void setEscalas(List<String> escalas) {
		this.escalas = escalas;
	}
	
	
}

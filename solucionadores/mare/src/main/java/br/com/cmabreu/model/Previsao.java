package br.com.cmabreu.model;

public class Previsao {
	private String data;
	private String hora;
	private String valor;
	
	public Previsao(String data, String hora, String valor) {
		this.data = data;
		this.hora = hora;
		this.valor = valor;
	}
	
	
	public String getData() {
		return data;
	}
	
	public void setData(String data) {
		this.data = data;
	}
	
	public String getHora() {
		return hora;
	}
	
	public void setHora(String hora) {
		this.hora = hora;
	}
	
	public String getValor() {
		return valor;
	}
	
	public void setValor(String valor) {
		this.valor = valor;
	}

	
}

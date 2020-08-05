package br.com.cmabreu.model;


import java.text.SimpleDateFormat;
import java.util.Date;


public class Altura {
	private Integer codTabua;
	private Date dataHora;
	private Float altura;
	private String faseLua;
	private String data;
	private String hora;
	
	public Integer getCodTabua() {
		return codTabua;
	}
	
	public void setCodTabua(Integer codTabua) {
		this.codTabua = codTabua;
	}
	
	public Date getDataHora() {
		return dataHora;
	}
	
	public void setDataHora(Date dataHora) {
		this.dataHora = dataHora;
		SimpleDateFormat sdfD = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdfH = new SimpleDateFormat("HH:mm:ss");
		this.data = sdfD.format( dataHora );
		this.hora = sdfH.format( dataHora );
	}
	
	public Float getAltura() {
		return altura;
	}
	
	public void setAltura(Float altura) {
		this.altura = altura;
	}
	
	public String getFaseLua() {
		return faseLua;
	}

	public void setFaseLua(String faseLua) {
		this.faseLua = faseLua;
	}
	
	public String getData() {
		return data;
	}
	
	public String getHora() {
		return hora;
	}
	
}

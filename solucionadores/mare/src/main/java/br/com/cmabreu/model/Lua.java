package br.com.cmabreu.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Lua {
	Date dataHora;
	String faseLua;
	String data;
	String hora;
	
	public Date getDataHora() {
		return dataHora;
	}
	
	public void setDataHora(Date dataHora) {
		this.dataHora = dataHora;
		this.dataHora = dataHora;
		
		SimpleDateFormat sdfD = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat sdfH = new SimpleDateFormat("HH:mm:ss");
		this.data = sdfD.format( dataHora );
		this.hora = sdfH.format( dataHora );		
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

	public void setData(String data) {
		this.data = data;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}
	
	

}

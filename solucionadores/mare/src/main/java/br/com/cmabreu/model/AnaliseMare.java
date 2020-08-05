package br.com.cmabreu.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class AnaliseMare {
	private Date dataHoraInicio;
	private Date dataHoraFim;
	private double z0;
	private int numComponentes;
	private final SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy"); 
	
	
	public String getDHInicioFormatada() {
		return formato.format( dataHoraInicio );
	}
	
	public String getDHFimFormatada() {
		return formato.format( dataHoraFim );
	}

	
	public Date getDataHoraInicio() {
		return dataHoraInicio;
	}
	
	public void setDataHoraInicio(Date dataHoraInicio) {
		this.dataHoraInicio = dataHoraInicio;
	}
	
	public Date getDataHoraFim() {
		return dataHoraFim;
	}
	
	public void setDataHoraFim(Date dataHoraFim) {
		this.dataHoraFim = dataHoraFim;
	}
	
	public double getZ0() {
		return z0;
	}
	
	public void setZ0(double z0) {
		this.z0 = z0;
	}
	
	public int getNumComponentes() {
		return numComponentes;
	}
	
	public void setNumComponentes(int numComponentes) {
		this.numComponentes = numComponentes;
	}

}

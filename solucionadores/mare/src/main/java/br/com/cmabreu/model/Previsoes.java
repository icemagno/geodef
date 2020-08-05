package br.com.cmabreu.model;

import java.util.ArrayList;
import java.util.List;

public class Previsoes {
	private List<Previsao> horaria;
	private List<Previsao> maxmin;

	public Previsoes() {
		this.maxmin = new ArrayList<Previsao>();
		this.horaria = new ArrayList<Previsao>();
	}
	
	public void addMaxMin( Previsao prev ) {
		maxmin.add( prev );
	}
	
	public void addHoraria( Previsao prev ) {
		horaria.add( prev );
	}

	public List<Previsao> getHoraria() {
		return horaria;
	}


	public List<Previsao> getMaxmin() {
		return maxmin;
	}

	
}

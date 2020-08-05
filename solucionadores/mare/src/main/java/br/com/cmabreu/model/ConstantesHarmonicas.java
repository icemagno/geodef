package br.com.cmabreu.model;

import java.util.List;

public class ConstantesHarmonicas {
	private Estacao estacaomaregrafica;
	private AnaliseMare analise;
	private List<Componente> componentes;
	
	public ConstantesHarmonicas() {
		super();
	}
	
	public ConstantesHarmonicas( Estacao estacao, AnaliseMare analise, List<Componente> componentes ) {
		this.estacaomaregrafica = estacao;
		this.analise = analise;
		this.componentes = componentes;
	}

	public Estacao getEstacaomaregrafica() {
		return estacaomaregrafica;
	}

	public AnaliseMare getAnalise() {
		return analise;
	}

	public List<Componente> getComponentes() {
		return componentes;
	}

}

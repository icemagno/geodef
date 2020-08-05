package br.mil.defesa.sisgeodef.misc.cartografia;

import java.util.List;

public class Classe implements IClasse {
	private String workspace;
	private String nome;
	private List<Layer> layers;

	public String getWorkspace() {
		return workspace;
	}
	
	public void setWorkspace(String workspace) {
		this.workspace = workspace;
	}
	
	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public List<Layer> getLayers() {
		return layers;
	}
	
	public void setLayers(List<Layer> layers) {
		this.layers = layers;
	}

	
	@Override
	public boolean equals( Object obj) {
		return ((IClasse)obj).getNome().equals( this.getNome()  );
	}
}

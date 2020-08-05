package br.com.cmabreu.misc;

import java.io.Serializable;

public class ClientAdditionalInformation implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String nome;
	private String logotipo;
	private String descricao;
	private String homePath;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getLogotipo() {
		return logotipo;
	}

	public void setLogotipo(String logotipo) {
		this.logotipo = logotipo;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getHomePath() {
		return homePath;
	}

	public void setHomePath(String homePath) {
		this.homePath = homePath;
	}
	
	
	
}

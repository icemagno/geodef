package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

public class ColorData implements Serializable {
	private static final long serialVersionUID = 1L;
	private String corMet;
	private Integer teto;
	private String nuvem;

	public ColorData(String corMet, Integer teto, String nuvem ) {
		super();
		this.corMet = corMet;
		this.teto = teto;
		this.nuvem = nuvem;
	}

	public String getCorMet() {
		return corMet;
	}

	public Integer getTeto() {
		return teto;
	}

	public String getNuvem() {
		return nuvem;
	}
	
}

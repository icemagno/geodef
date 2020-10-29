package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

public class ColorData implements Serializable {
	private static final long serialVersionUID = 1L;
	private String corMet;
	private Integer teto;

	public ColorData(String corMet, Integer teto) {
		super();
		this.corMet = corMet;
		this.teto = teto;
	}

	public String getCorMet() {
		return corMet;
	}

	public Integer getTeto() {
		return teto;
	}


}

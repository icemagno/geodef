package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

public class PasswordQuality implements Serializable {
	private static final long serialVersionUID = 1L;
	private Boolean minimumEntropyMet;
	private int score;
	
	
	public PasswordQuality(Boolean minimumEntropyMet, int score) {
		this.minimumEntropyMet = minimumEntropyMet;
		this.score = score;
	}


	public Boolean getMinimumEntropyMet() {
		return minimumEntropyMet;
	}


	public int getScore() {
		return score;
	}
	
	
	

}

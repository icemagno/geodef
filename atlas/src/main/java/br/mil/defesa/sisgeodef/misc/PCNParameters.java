package br.mil.defesa.sisgeodef.misc;

public class PCNParameters {
	private Integer pcn;
	private String pavimento;
	private String resistencia;
	private String pressao;
	private String avaliacao;
	private Integer comprimento;
	private Integer largura;
	private String icao;

	public PCNParameters(Integer pcn, String pavimento, String resistencia, String pressao, String avaliacao,
			Integer comprimento, Integer largura, String icao) {
		super();
		this.pcn = pcn;
		this.pavimento = pavimento;
		this.resistencia = resistencia;
		this.pressao = pressao;
		this.avaliacao = avaliacao;
		this.comprimento = comprimento;
		this.largura = largura;
		this.icao = icao;
	}

	public Integer getPcn() {
		return pcn;
	}

	public void setPcn(Integer pcn) {
		this.pcn = pcn;
	}

	public String getPavimento() {
		return pavimento;
	}

	public void setPavimento(String pavimento) {
		this.pavimento = pavimento;
	}

	public String getResistencia() {
		return resistencia;
	}

	public void setResistencia(String resistencia) {
		this.resistencia = resistencia;
	}

	public String getPressao() {
		return pressao;
	}

	public void setPressao(String pressao) {
		this.pressao = pressao;
	}

	public String getAvaliacao() {
		return avaliacao;
	}

	public void setAvaliacao(String avaliacao) {
		this.avaliacao = avaliacao;
	}

	public Integer getComprimento() {
		return comprimento;
	}

	public void setComprimento(Integer comprimento) {
		this.comprimento = comprimento;
	}

	public Integer getLargura() {
		return largura;
	}

	public void setLargura(Integer largura) {
		this.largura = largura;
	}

	public String getIcao() {
		return icao;
	}

	public void setIcao(String icao) {
		this.icao = icao;
	}

	
	
}

package br.com.cmabreu.misc;

/*
 * ACHARE
 */

public class AreaDeFundeio {
	private String nome;
	private String informação;
	private String tipoAreaDeFundeio;
	private String categoriaAreaDeFundeio;
	private String restricao;
	private String status;

	public AreaDeFundeio(	String OBJNAM, 
							String NOBJNM, 
							String INFORM, 
							String NINFOM,
							String CATACH,
							String CATAREA,
							String RESTRN,
							String STATUS ) {
		
		
		if( OBJNAM != null ) this.nome = OBJNAM;
		if( NOBJNM != null ) this.nome = NOBJNM;
		
		this.informação = INFORM;
		this.tipoAreaDeFundeio = CATACH;
		this.categoriaAreaDeFundeio = CATAREA;
		this.restricao = RESTRN;
		this.status = STATUS;
		
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getInformação() {
		return informação;
	}

	public void setInformação(String informação) {
		this.informação = informação;
	}

	public String getTipoAreaDeFundeio() {
		return tipoAreaDeFundeio;
	}

	public void setTipoAreaDeFundeio(String tipoAreaDeFundeio) {
		this.tipoAreaDeFundeio = tipoAreaDeFundeio;
	}

	public String getCategoriaAreaDeFundeio() {
		return categoriaAreaDeFundeio;
	}

	public void setCategoriaAreaDeFundeio(String categoriaAreaDeFundeio) {
		this.categoriaAreaDeFundeio = categoriaAreaDeFundeio;
	}

	public String getRestricao() {
		return restricao;
	}

	public void setRestricao(String restricao) {
		this.restricao = restricao;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
}

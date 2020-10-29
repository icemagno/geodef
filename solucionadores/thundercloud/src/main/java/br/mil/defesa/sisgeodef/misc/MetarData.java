package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

import io.github.mivek.model.Metar;

/*
SBGL	1600	610
SBRJ	3700	690
SBAF	2400	960
SBSC	1600	510
SBES	1600	440
SBCB	1600	477
SBME	1600	450
SBCP	1600	500
*/

public class MetarData implements Serializable {
	private static final long serialVersionUID = 1L;
	private Metar metar;
	private ColorData cm;
	private Integer alpha;
	private Integer beta;
	
	public MetarData(Metar metar) {
		super();
		this.metar = metar;
		String icao = metar.getAirport().getIcao();
		if( icao.equals("SBGL") ) {
			alpha = 1600; beta = 610;
		}
		if( icao.equals("SBRJ") ) {
			alpha = 3700; beta = 690;
		}
		if( icao.equals("SBAF") ) {
			alpha = 2400; beta = 960;
		}
		if( icao.equals("SBSC") ) {
			alpha = 1600; beta = 510;
		}
		if( icao.equals("SBES") ) {
			alpha = 1600; beta = 440;
		}
		if( icao.equals("SBCB") ) {
			alpha = 1600; beta = 477;
		}
		if( icao.equals("SBME") ) {
			alpha = 1600; beta = 450;
		}
		if( icao.equals("SBCP") ) {
			alpha = 1600; beta = 500;
		}
	}

	public Metar getMetar() {
		return metar;
	}
	
	public void setMetar(Metar metar) {
		this.metar = metar;
	}
	
	public ColorData getCm() {
		return cm;
	}
	
	public void setCm(ColorData cm) {
		this.cm = cm;
	}

	public Integer getAlpha() {
		return alpha;
	}

	public void setAlpha(Integer alpha) {
		this.alpha = alpha;
	}

	public Integer getBeta() {
		return beta;
	}

	public void setBeta(Integer beta) {
		this.beta = beta;
	}
	
	
}

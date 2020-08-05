package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

public class Plataforma implements Serializable {
	private static final long serialVersionUID = 1L;

    private String latdd;
    private String longdd;
    private String id_origem_dados_pontos;
    private String nome_navio;
    private Double lat;
    private Double lon;
    private Integer rumo;
    private Integer id_origem_dados;
    private String the_geom;
    private String irim;
    private String bandeira;
    private String destino;
    private String eta;
    private Double veloc;
    private String dh;
    private String mmsi;
    private String nr_baliza;
    private String tipo_navio;
    
	public String getLatdd() {
		return latdd;
	}
	public void setLatdd(String latdd) {
		this.latdd = latdd;
	}
	public String getLongdd() {
		return longdd;
	}
	public void setLongdd(String longdd) {
		this.longdd = longdd;
	}
	public String getId_origem_dados_pontos() {
		return id_origem_dados_pontos;
	}
	public void setId_origem_dados_pontos(String id_origem_dados_pontos) {
		this.id_origem_dados_pontos = id_origem_dados_pontos;
	}
	public String getNome_navio() {
		return nome_navio;
	}
	public void setNome_navio(String nome_navio) {
		this.nome_navio = nome_navio;
	}
	public Double getLat() {
		return lat;
	}
	public void setLat(Double lat) {
		this.lat = lat;
	}
	public Double getLon() {
		return lon;
	}
	public void setLon(Double lon) {
		this.lon = lon;
	}
	public Integer getRumo() {
		return rumo;
	}
	public void setRumo(Integer rumo) {
		this.rumo = rumo;
	}
	public Integer getId_origem_dados() {
		return id_origem_dados;
	}
	public void setId_origem_dados(Integer id_origem_dados) {
		this.id_origem_dados = id_origem_dados;
	}
	public String getThe_geom() {
		return the_geom;
	}
	public void setThe_geom(String the_geom) {
		this.the_geom = the_geom;
	}
	public String getIrim() {
		return irim;
	}
	public void setIrim(String irim) {
		this.irim = irim;
	}
	public String getBandeira() {
		return bandeira;
	}
	public void setBandeira(String bandeira) {
		this.bandeira = bandeira;
	}
	public String getDestino() {
		return destino;
	}
	public void setDestino(String destino) {
		this.destino = destino;
	}
	public String getEta() {
		return eta;
	}
	public void setEta(String eta) {
		this.eta = eta;
	}
	public Double getVeloc() {
		return veloc;
	}
	public void setVeloc(Double veloc) {
		this.veloc = veloc;
	}
	public String getDh() {
		return dh;
	}
	public void setDh(String dh) {
		this.dh = dh;
	}
	public String getMmsi() {
		return mmsi;
	}
	public void setMmsi(String mmsi) {
		this.mmsi = mmsi;
	}
	public String getNr_baliza() {
		return nr_baliza;
	}
	public void setNr_baliza(String nr_baliza) {
		this.nr_baliza = nr_baliza;
	}
	public String getTipo_navio() {
		return tipo_navio;
	}
	public void setTipo_navio(String tipo_navio) {
		this.tipo_navio = tipo_navio;
	}
	
	
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.apolo.interoperabilidade.model;

/**
 *
 * @author joaquim
 */
public class Geodata {
    private Long id;
    private String fonte;
    private String tipo;
    private String metadados;
    private String[] match;
    private String resumo;
    private String simbolo;
    private String geom;
    

    public Geodata() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMetadados() {
        return metadados;
    }

    public void setMetadados(String metadados) {
        this.metadados = metadados;
    }

    public String[] getMatch() {
        return match;
    }

    public void setMatch(String[] match) {
        this.match = match;
    }

    public String getFonte() {
        return fonte;
    }

    public void setFonte(String fonte) {
        this.fonte = fonte;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getGeom() {
        return geom;
    }

    public void setGeom(String geom) {
        this.geom = geom;
    }

    public String getResumo() {
        return resumo;
    }

    public void setResumo(String resumo) {
        this.resumo = resumo;
    }

    public String getSimbolo() {
        return simbolo;
    }

    public void setSimbolo(String simbolo) {
        this.simbolo = simbolo;
    }
    

   
    
    
    
}

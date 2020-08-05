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
public class LuceneInput {
    private Long id;
    private String fonte;
    private String tipo;
    private String query;
    private String conexaoId;
    private String metadados;
    private String labels;
    private String metadadosResumo;
    private String labelsResumo;
    private String jndi;
    private Long qtdMetadados;
    
    
    
    public LuceneInput() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public String getConexaoId() {
        return conexaoId;
    }

    public void setConexaoId(Long conexaoId) {
        this.conexaoId = conexaoId.toString();
    }

    public String getMetadados() {
        return metadados;
    }

    public void setMetadados(String metadados) {
        this.metadados = metadados;
    }

    public String getLabels() {
        return labels;
    }

    public void setLabels(String labels) {
        this.labels = labels;
    }

    public String getMetadadosResumo() {
        return metadadosResumo;
    }

    public void setMetadadosResumo(String metadadosResumo) {
        this.metadadosResumo = metadadosResumo;
    }

    public String getLabelsResumo() {
        return labelsResumo;
    }

    public void setLabelsResumo(String labelsResumo) {
        this.labelsResumo = labelsResumo;
    }

    public String getJndi() {
        return jndi;
    }

    public void setJndi(String jndi) {
        this.jndi = jndi;
    }

    public Long getQtdMetadados() {
        return qtdMetadados;
    }

    public void setQtdMetadados(Long qtdMetadados) {
        this.qtdMetadados = qtdMetadados;
    }
    
    
    
    
}

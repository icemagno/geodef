/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.apolo.interoperabilidade.resource;

/**
 *
 * @author joaquim
 */
public class StatusIndexacao {
    private String fonte;
    private String status;

    public StatusIndexacao(String fonte, String status) {
        this.fonte = fonte;
        this.status = status;
    }

    public StatusIndexacao() {
    }

    public String getFonte() {
        return fonte;
    }

    public void setFonte(String fonte) {
        this.fonte = fonte;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}

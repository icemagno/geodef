/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.sisgeodef.misc;

/**
 *
 * @author joaquim
 */
public class StatusTarefa {
    private Integer status;
    
    public static final Integer OK = 0; 
    public static final Integer ERROR = 1; 
    public static final Integer WARNNING = 2; 

    public StatusTarefa() {
        this.status=this.OK;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    
    
    
    
}

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
public class AreaMigracao {
    private String l;
    private String r; 
    private String t; 
    private String b;

    public AreaMigracao(String l, String r, String t, String b) {
        this.l = l;
        this.r = r;
        this.t = t;
        this.b = b;
    }

    public String getL() {
        return l;
    }

    public void setL(String l) {
        this.l = l;
    }

    public String getR() {
        return r;
    }

    public void setR(String r) {
        this.r = r;
    }

    public String getT() {
        return t;
    }

    public void setT(String t) {
        this.t = t;
    }

    public String getB() {
        return b;
    }

    public void setB(String b) {
        this.b = b;
    }
    
    
    
            
            
}

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
public class ResolveEspecialChar {
    
    public String especialChar(String q){
       q =q.replaceAll("ç","c");
       q =q.replaceAll("á","a");
       q =q.replaceAll("â","a");
       q =q.replaceAll("ã","a");
       q =q.replaceAll("ô","o");
       q =q.replaceAll("õ","o");
       q =q.replaceAll("í","i");
       /*q =q.replaceAll("ç","c");
       q =q.replaceAll("ç","c");
       q =q.replaceAll("ç","c");
       */
       
       
       return q;
    }
}

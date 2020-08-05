/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.apolo.interoperabilidade.resource;

import br.mil.defesa.apolo.interoperabilidade.model.PesosTermos;
import java.util.List;

/**
 *
 * @author joaquim
 */
public class LucenePesosTermos {
    
    public String parseQuery(List<PesosTermos> lista, String q) {

       
       for(PesosTermos l:lista){
           if(q.contains(l.getTermo())){
               System.out.println("weighting term "+l.getTermo());
               q = q.replace(l.getTermo(), l.getTermo()+"(2)");
           }
       }
                  
       return q;
    }
}

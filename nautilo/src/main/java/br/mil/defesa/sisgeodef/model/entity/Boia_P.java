/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.sisgeodef.model.entity;


import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

/**
 *
 * @author joaquim
 */

@Entity
@PrimaryKeyJoinColumn(name = "boia_id")
@Table(name = "boia_p", schema = "nautico")
public class Boia_P extends Boia{    
    

    /*
    @OneToOne(fetch = FetchType.LAZY)
    @MapsId
    private Forma_Da_Boia formaDaBoia;
    */
    @Column(name = "geometria", nullable = false)
    private String geometria;
    
   

    public Boia_P() {
        super();
    }


    public String getGeometria() {
        return geometria;
    }

    public void setGeometria(String geometria) {
        this.geometria = geometria;
    }
    
    
    
    

    
    
    
    
}

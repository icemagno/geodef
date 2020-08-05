/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.sisgeodef.model.entity;

import br.mil.defesa.sisgeodef.model.domain.Categ_Sinal;
import br.mil.defesa.sisgeodef.model.domain.Cor;
import br.mil.defesa.sisgeodef.model.domain.Forma_Da_Boia;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.MappedSuperclass;
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
@PrimaryKeyJoinColumn(name = "sinalizacao_nautica_id")
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "boia", schema = "nautico")
public class Boia extends Sinalizacao_Nautica{    
    
   
    
    @OneToOne(fetch = FetchType.LAZY, optional = true)
    @MapsId
    private Forma_Da_Boia formaDaBoia;
    
   

    public Boia() {
        super();
    }



    public Boia(Forma_Da_Boia formaDaBoia) {
        super();
        this.formaDaBoia = formaDaBoia;
    }

    public Forma_Da_Boia getFormaDaBoia() {
        return formaDaBoia;
    }

    public void setFormaDaBoia(Forma_Da_Boia formaDaBoia) {
        this.formaDaBoia = formaDaBoia;
    }


    
    
    
    
}

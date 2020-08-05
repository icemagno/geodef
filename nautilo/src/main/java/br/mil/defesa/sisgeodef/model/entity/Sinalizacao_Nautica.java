/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.sisgeodef.model.entity;

import br.mil.defesa.sisgeodef.model.domain.Categ_Sinal;
import br.mil.defesa.sisgeodef.model.domain.Cor;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.MappedSuperclass;
import javax.persistence.MapsId;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 *
 * @author joaquim
 */

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "sinalizacao_nautica", schema = "nautico")
public class Sinalizacao_Nautica {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false)
    private Long id;
    
    @Column(name = "geometria_aproximada", nullable = true)
    private boolean geometriaAproximada;
    
    @OneToOne(fetch = FetchType.LAZY, optional = true)
    @MapsId
    @JoinColumn(name = "categoria_de_sinal_id", nullable = true)
    private Categ_Sinal categoriaDeSinal;
    
    /*
    @ManyToMany(cascade=CascadeType.ALL)
    @JoinTable(
            name="sinalizacao_nautica_rel_cor",
            joinColumns={@JoinColumn(name="sinalizacao_nautica_id", referencedColumnName="id" )},
            inverseJoinColumns={@JoinColumn(name="cor_id", referencedColumnName="id")})
    private List<Cor> cor ;
    */

    public Sinalizacao_Nautica() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public boolean getGeometriaAproximada() {
        return geometriaAproximada;
    }

    public void setGeometriaAproximada(boolean geometriaAproximada) {
        this.geometriaAproximada = geometriaAproximada;
    }
/*
    public Categ_Sinal getCategoriaDeSinal() {
        return categoriaDeSinal;
    }

    public void setCategoriaDeSinal(Categ_Sinal categoriaDeSinal) {
        this.categoriaDeSinal = categoriaDeSinal;
    }

    public List<Cor> getCor() {
        return cor;
    }

    public void setCor(List<Cor> cor) {
        this.cor = cor;
    }
    
    */
    
}

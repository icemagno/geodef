package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "shapefile")
public class ShapeFile implements Serializable {
	private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "file_id", nullable = false, updatable = false)
    private Long id;

    @Column(name = "filename", length = 200, nullable = false)
    private String fileName;

    @Column(name = "nome", length = 200, nullable = false)
    private String nome;

    @Column(name = "data_migracao", nullable = false)
    private Date dataMigracao;

    public ShapeFile() {
    }

    public ShapeFile(String fileName, String nome, Date dataMigracao) {
        this.fileName = fileName;
        this.nome = nome;
        this.dataMigracao = dataMigracao;
    }

    
    
        
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public Date getDataMigracao() {
        return dataMigracao;
    }

    public void setDataMigracao(Date dataMigracao) {
        this.dataMigracao = dataMigracao;
    }

	
        
	
	
}

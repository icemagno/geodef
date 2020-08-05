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
	private Long fileId;
	
	@Column(name = "gmd_file_identifier", length = 200, nullable = false)
	private String gmdFileIdentifier;		
	
	@Column(name = "filename", length = 200, nullable = false)
	private String fileName;
        
        @Column(name = "serie", length = 200, nullable = false)
	private String serie;
        
        @Column(name = "contato", length = 200, nullable = false)
	private String contato;
        
        @Column(name = "escala", length = 200, nullable = false)
	private String escala;
        
        @Column(name = "tipo", length = 200, nullable = false)
	private String tipo;
        
        @Column(name = "data_migracao", nullable = false)
	private Date dataMigracao;

	public Long getFileId() {
		return fileId;
	}

	public void setFileId(Long fileId) {
		this.fileId = fileId;
	}

	public String getGmdFileIdentifier() {
		return gmdFileIdentifier;
	}

	public void setGmdFileIdentifier(String gmdFileIdentifier) {
		this.gmdFileIdentifier = gmdFileIdentifier;
	}

    public ShapeFile() {
    }

    
        
    public ShapeFile(String gmdFileIdentifier, String fileName, String serie, String contato, String escala, String tipo, Date dataMigracao) {
        this.gmdFileIdentifier = gmdFileIdentifier;
        this.fileName = fileName;
        this.serie = serie;
        this.contato = contato;
        this.escala = escala;
        this.tipo = tipo;
        this.dataMigracao = dataMigracao;
    }
        
        

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

        public String getSerie() {
            return serie;
        }

        public void setSerie(String serie) {
            this.serie = serie;
        }

        public String getContato() {
            return contato;
        }

        public void setContato(String contato) {
            this.contato = contato;
        }

        public String getEscala() {
            return escala;
        }

        public void setEscala(String escala) {
            this.escala = escala;
        }

        public String getTipo() {
            return tipo;
        }

        public void setTipo(String tipo) {
            this.tipo = tipo;
        }

        public Date getDataMigracao() {
            return dataMigracao;
        }

        public void setDataMigracao(Date dataMigracao) {
            this.dataMigracao = dataMigracao;
        }
        
        
	
	
}

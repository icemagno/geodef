package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "catalog_source")
public class CatalogSouce implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "souce_id", nullable = false, updatable = false)
	private Long id;
	
	@Column(name = "topic_id")
	private Integer topicId;	

	@Column(name = "description", columnDefinition="TEXT")
	private String description;

	@Column(name = "source_name", length = 100, nullable = false, unique = true)
	private String sourceName;
	
	@Column(name = "source_address", length = 250, nullable = false, unique = true)
	private String sourceAddress;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSourceName() {
		return sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

	public String getSourceAddress() {
		return sourceAddress;
	}

	public void setSourceAddress(String sourceAddress) {
		this.sourceAddress = sourceAddress;
	}
	
	
}

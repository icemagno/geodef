package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
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

	@Column(name = "parent_id")
	private Integer parentId;	
	
	@Column(name = "description", columnDefinition="TEXT")
	private String description;

	@Column(name = "source_name", length = 100, nullable = false)
	private String sourceName;
	
	@Column(name = "source_address", length = 250)
	private String sourceAddress;

    @OneToMany(cascade= CascadeType.ALL, orphanRemoval=true, fetch = FetchType.EAGER)
    @JoinColumn(name="parent_id")
    private List<CatalogSouce> sources;	
	
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

	public Integer getTopicId() {
		return topicId;
	}

	public void setTopicId(Integer topicId) {
		this.topicId = topicId;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public List<CatalogSouce> getSources() {
		return sources;
	}

	public void setSources(List<CatalogSouce> sources) {
		this.sources = sources;
	}
	
	
}

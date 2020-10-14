package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;
import java.util.ArrayList;
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
@Table(name = "catalog_topics")
public class CatalogTopics implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "topic_id", nullable = false, updatable = false)
	private Long id;
	
	@Column(name = "topic_name", length = 100, nullable = false, unique = true)
	private String topicName;
	
	@Column(name = "description", columnDefinition="TEXT")
	private String description;
	
    @OneToMany(cascade= CascadeType.ALL, orphanRemoval=true, fetch = FetchType.EAGER)
    @JoinColumn(name="topic_id")
    private List<CatalogSource> sources;	

    
    public CatalogTopics() {
		this.sources = new ArrayList<CatalogSource>();
	}
    
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTopicName() {
		return topicName;
	}

	public void setTopicName(String topicName) {
		this.topicName = topicName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<CatalogSource> getSources() {
		return sources;
	}

	public void setSources(List<CatalogSource> sources) {
		this.sources = sources;
	}	
	
}

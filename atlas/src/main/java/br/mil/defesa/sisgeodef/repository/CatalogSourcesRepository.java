package br.mil.defesa.sisgeodef.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.CatalogSource;

@Repository
@Transactional
public interface CatalogSourcesRepository extends JpaRepository<CatalogSource, Long> {
	List<CatalogSource> findAllByParentId( Integer parentId );
	List<CatalogSource> findAllByTopicId( Integer topicId );
	
	@Query(nativeQuery = true, value="SELECT * FROM catalog_source m WHERE m.description LIKE %:q% or m.source_name LIKE %:q% or m.source_layer LIKE %:q% LIMIT :qtd")
	List<CatalogSource> searchCatalog( @Param("q") String q, @Param("qtd") Integer qtd );
}

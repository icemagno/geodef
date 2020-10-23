package br.mil.defesa.sisgeodef.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.CatalogSource;

@Repository
@Transactional
public interface CatalogSourcesRepository extends JpaRepository<CatalogSource, Long> {
	List<CatalogSource> findAllByParentId( Long parentId );
}

package br.mil.defesa.sisgeodef.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import br.mil.defesa.sisgeodef.model.ShapeFile;

public interface ShapeFileRepository extends JpaRepository<ShapeFile, Long> {
	Optional<ShapeFile> findByFileName( String fileName );
}

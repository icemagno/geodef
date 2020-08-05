package br.mil.defesa.sisgeodef.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import br.mil.defesa.sisgeodef.model.GeoAirport;

public interface AerodromoRepository extends JpaRepository<GeoAirport, Long> {
	
}

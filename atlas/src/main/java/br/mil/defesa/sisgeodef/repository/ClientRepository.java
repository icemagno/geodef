package br.mil.defesa.sisgeodef.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.OAuthClientDetails;

@Repository
@Transactional
public interface ClientRepository extends JpaRepository<OAuthClientDetails, String> {
	
	Optional<OAuthClientDetails> findByClientId(String clientId);
	
	List<OAuthClientDetails> findAllByOrderByClientIdAsc();	
	
	
	@Query("SELECT c FROM OAuthClientDetails c where clientId like %:name%")
	public List<OAuthClientDetails> search(@Param("name") String name);	
	

}

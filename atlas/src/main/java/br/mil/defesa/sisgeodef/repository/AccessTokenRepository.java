package br.mil.defesa.sisgeodef.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.OAuthAccessToken;

@Repository
@Transactional
public interface AccessTokenRepository extends JpaRepository<OAuthAccessToken, Long> {

}

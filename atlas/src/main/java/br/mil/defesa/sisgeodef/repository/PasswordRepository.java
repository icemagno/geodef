package br.mil.defesa.sisgeodef.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.PasswordHistory;

@Repository
@Transactional
public interface PasswordRepository extends JpaRepository<PasswordHistory, Long> {
	List<PasswordHistory> findAllByUserId( Long userId );
}

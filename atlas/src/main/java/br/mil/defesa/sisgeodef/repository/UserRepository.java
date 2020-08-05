package br.mil.defesa.sisgeodef.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.User;

@Repository
@Transactional
public interface UserRepository extends JpaRepository<User, Long> {
	Optional<User> findByName(String name);
	List<User> findAllByCpf(String cpf);

	@Query("SELECT u FROM User u where cpf=:cpf and name=:username")
	List<User> findAllByCpfAndEmail(String cpf, String username);
}

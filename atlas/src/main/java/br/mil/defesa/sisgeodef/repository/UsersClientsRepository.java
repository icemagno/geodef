package br.mil.defesa.sisgeodef.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.UsersClients;
import br.mil.defesa.sisgeodef.model.UsersClientsId;

@Repository
@Transactional
public interface UsersClientsRepository extends JpaRepository<UsersClients, UsersClientsId> {

}

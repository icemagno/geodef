package br.com.cmabreu.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.com.cmabreu.model.UsersClients;
import br.com.cmabreu.model.UsersClientsId;

@Repository
@Transactional
public interface UsersClientsRepository extends JpaRepository<UsersClients, UsersClientsId> {

}

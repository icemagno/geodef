/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.sisgeodef.repository;

import br.mil.defesa.sisgeodef.model.entity.Boia;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author joaquim
 */

public interface GenericRepository extends JpaRepository<Boia, Long> {

  //save(entity);      

  Optional<Boia> findById(Long primaryKey); 

  List<Boia> findAll();               

  long count();                        

  void delete(Boia entity);               

  boolean existsById(Boia primaryKey);   

  // … more functionality omitted.
}
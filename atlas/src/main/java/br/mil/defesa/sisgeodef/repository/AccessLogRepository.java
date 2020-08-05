package br.mil.defesa.sisgeodef.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.mil.defesa.sisgeodef.model.AccessLog;

@Repository
@Transactional
public interface AccessLogRepository extends JpaRepository<AccessLog, Long> {
	
    @Query(value = "SELECT * FROM access_log t order by date desc limit :maxRows", nativeQuery = true)	
	List<AccessLog> findTopNOrderByDateDesc( @Param("maxRows") Integer maxRows );

    @Query(value = "SELECT * FROM access_log t where t.remoteuserid = :remoteUserId order by date desc limit :maxRows", nativeQuery = true)	
	List<AccessLog> findTopNByRemoteUserIdOrderByDateDesc( @Param("maxRows") Integer maxRows, @Param("remoteUserId") Long remoteUserId );    
    
}

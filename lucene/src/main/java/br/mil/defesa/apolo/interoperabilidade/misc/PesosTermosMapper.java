package br.mil.defesa.apolo.interoperabilidade.misc;

import br.mil.defesa.apolo.interoperabilidade.model.PesosTermos;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public final class PesosTermosMapper implements RowMapper<PesosTermos> {
    
    @Override
    public PesosTermos mapRow(ResultSet rs, int rowNum) throws SQLException {
        PesosTermos obj = new PesosTermos(rs.getString("termo"));        
        return obj;
    }

}

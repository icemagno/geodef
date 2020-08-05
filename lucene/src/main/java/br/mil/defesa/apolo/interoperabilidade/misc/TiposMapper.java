package br.mil.defesa.apolo.interoperabilidade.misc;

import br.mil.defesa.apolo.interoperabilidade.model.Tipo;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public final class TiposMapper implements RowMapper<Tipo> {
    
    @Override
    public Tipo mapRow(ResultSet rs, int rowNum) throws SQLException {
        Tipo obj = new Tipo(rs.getLong("id"), rs.getString("tipo"));        
        return obj;
    }

    

    
    
   

}

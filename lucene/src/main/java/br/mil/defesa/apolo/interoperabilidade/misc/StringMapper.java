package br.mil.defesa.apolo.interoperabilidade.misc;

import br.mil.defesa.apolo.interoperabilidade.model.Fonte;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public final class StringMapper implements RowMapper<String> {
    
    @Override
    public String mapRow(ResultSet rs, int rowNum) throws SQLException {
        String obj = rs.getString("string");        
        return obj;
    }

    

    
    
   

}

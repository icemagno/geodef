package br.mil.defesa.apolo.interoperabilidade.misc;

import br.mil.defesa.apolo.interoperabilidade.model.Fonte;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public final class FontesMapper implements RowMapper<Fonte> {
    
    @Override
    public Fonte mapRow(ResultSet rs, int rowNum) throws SQLException {
        Fonte obj = new Fonte(rs.getString("fonte"));        
        return obj;
    }

    

    
    
   

}

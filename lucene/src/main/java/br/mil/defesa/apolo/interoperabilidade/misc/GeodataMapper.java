package br.mil.defesa.apolo.interoperabilidade.misc;

import br.mil.defesa.apolo.interoperabilidade.model.Geodata;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public final class GeodataMapper implements RowMapper<Geodata> {

    @Override
    public Geodata mapRow(ResultSet rs, int rowNum) throws SQLException {
        Geodata c = new Geodata();
        
        c.setId(rs.getLong("id"));
        c.setMetadados(rs.getString("metadados"));
        c.setFonte(rs.getString("fonte"));
        c.setGeom(rs.getString("geom_json"));
        c.setTipo(rs.getString("tipo"));
        c.setResumo(rs.getString("resumo"));
        c.setSimbolo(rs.getString("link_simbolo"));
   
        return c;
    }

   

}

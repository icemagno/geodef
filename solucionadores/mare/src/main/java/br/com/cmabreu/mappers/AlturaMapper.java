package br.com.cmabreu.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.cmabreu.model.Altura;

public final class AlturaMapper implements RowMapper<Altura> {

	@Override
	public Altura mapRow(ResultSet rs, int rowNum) throws SQLException {
		Altura altura = new Altura();
		altura.setFaseLua( rs.getString("fase_lua") );
		
		Timestamp timestamp = rs.getTimestamp("data_hora");
		
		if (timestamp != null) {
			Date date = new java.util.Date(timestamp.getTime() );		
			altura.setDataHora( date );
		}
		
		altura.setAltura( rs.getFloat("altura") );
		altura.setCodTabua( rs.getInt("cod_tabua") );
		return altura;
	}

}

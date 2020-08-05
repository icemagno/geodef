package br.com.cmabreu.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.cmabreu.model.AnaliseMare;

public final class AnaliseMareMapper implements RowMapper<AnaliseMare> {

	@Override
	public AnaliseMare mapRow(ResultSet rs, int rowNum) throws SQLException {
		AnaliseMare analiseMare = new AnaliseMare();
		
		analiseMare.setZ0( rs.getFloat("z0") );
		analiseMare.setNumComponentes( rs.getInt("num_componentes") );
		
		Timestamp timestamp1 = rs.getTimestamp("data_hora_inicio");
		Timestamp timestamp2 = rs.getTimestamp("data_hora_fim");
		
		if (timestamp1 != null) {
			Date date = new java.util.Date(timestamp1.getTime() );		
			analiseMare.setDataHoraInicio( date );
		}

		if (timestamp2 != null) {
			Date date = new java.util.Date(timestamp2.getTime() );		
			analiseMare.setDataHoraFim( date );
		}

		return analiseMare;
	}

}

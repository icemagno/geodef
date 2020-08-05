package br.com.cmabreu.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import br.com.cmabreu.model.TabuaMares;

public final class TabuaMaresMapper implements RowMapper<TabuaMares>{

	@Override
	public TabuaMares mapRow(ResultSet rs, int rowNum) throws SQLException {
		TabuaMares tm = new TabuaMares();
		tm.setAno( rs.getString("ano") );
		tm.setCodTabua( rs.getString("cod_tabua") );
		tm.setCodEstacaoMaregrafica( rs.getInt("cod_estacao_maregrafica") );
		tm.setNumComponentes( rs.getInt("num_componentes") );
		tm.setNivelMedio( rs.getFloat("nivel_medio") );
		return tm;
	}
	
}

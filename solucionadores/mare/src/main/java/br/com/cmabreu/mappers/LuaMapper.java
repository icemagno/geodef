package br.com.cmabreu.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.cmabreu.model.Lua;

public final class LuaMapper implements RowMapper<Lua> {

	@Override
	public Lua mapRow(ResultSet rs, int rowNum) throws SQLException {
		Lua lua = new Lua();

		Timestamp timestamp = rs.getTimestamp("data_hora");
		
		if (timestamp != null) {
			Date date = new java.util.Date(timestamp.getTime() );		
			lua.setDataHora( date );
		}		
		
		lua.setFaseLua( rs.getString("fase_lua") );
		
		return lua;
	}

}

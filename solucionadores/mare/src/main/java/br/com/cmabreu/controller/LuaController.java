package br.com.cmabreu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import br.com.cmabreu.mappers.LuaMapper;
import br.com.cmabreu.model.Lua;

@RestController
public class LuaController {

	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	@RequestMapping(value = "/luas/{ano}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<Lua> getLuas( @PathVariable("ano") Integer ano ) {
		Object[] params = new Object[] { ano };
		String sql = "select * from sc_mare.tb_fases_lua_tu where datepart( year, data_hora) = ?";
		
		List<Lua> luas = jdbcTemplate.query(sql, params, new LuaMapper() );
		return luas;
	}	
	
	
	
}

package br.com.cmabreu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import br.com.cmabreu.mappers.TabuaMaresMapper;
import br.com.cmabreu.model.TabuaMares;

@RestController
public class TabuaController {

	@Autowired
    JdbcTemplate jdbcTemplate;		

	
	@RequestMapping(value = "/tabuas", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<TabuaMares> getTabuas(  ) {
		Object[] params = new Object[] { };
		String sql = "select * from sc_mare.vw_sisgeodef_tabua_mare";
		List<TabuaMares> tabuas = jdbcTemplate.query(sql, params, new TabuaMaresMapper() );
		return tabuas;
	}	

	@RequestMapping(value = "/tabua/{estacao}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<TabuaMares> getTabua( @PathVariable("estacao") Integer codEstacao ) {
		Object[] params = new Object[] { codEstacao };
		String sql = "select * from sc_mare.vw_sisgeodef_tabua_mare where cod_estacao_maregrafica = ?";
		List<TabuaMares> tabuas = jdbcTemplate.query(sql, params, new TabuaMaresMapper() );
		return tabuas;
	}	
	
	
}

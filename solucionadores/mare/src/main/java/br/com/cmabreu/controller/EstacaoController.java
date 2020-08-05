package br.com.cmabreu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import br.com.cmabreu.mappers.EstacaoApiMapper;
import br.com.cmabreu.mappers.EstacaoMapper;
import br.com.cmabreu.model.Estacao;
import br.com.cmabreu.model.EstacaoAPI;

@RestController
public class EstacaoController {

	@Autowired
    JdbcTemplate jdbcTemplate;		

	
	@RequestMapping(value = "/estacoes/{tabua}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<EstacaoAPI> getEstacoes( @PathVariable("tabua") String ehTabua ) {
		Object[] params = new Object[] { ehTabua };
		String sql = "select * from sc_mare.vw_sisgeodef_estacao_maregrafica where tabua = ?";
		List<EstacaoAPI> estacoes = jdbcTemplate.query(sql, params, new EstacaoApiMapper() );
		return estacoes;
	}
	
	
	
	@RequestMapping(value = "/estacoes", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<Estacao> getEstacoes( ) {
		Object[] params = new Object[] { };
		String sql = "select cod_estacao_maregrafica, num_estacao_maregrafica," + 
				"nome_estacao_maregrafica, latitude, longitude, fuso, tabua," + 
				"num_ana, fluviometrica, local_origem, cod_pais, instituicao," + 
				"identificacao_nivel_datum, data_referencia_datum," + 
				"elevacao_nivel_medio_mar_local, elevacao_nivel_medio_mar_ibge," + 
				"num_ana, fluviometrica, identificacao_rn_local, identificacao_rn_ibge " + 
				"from sc_mare.tb_estacao_maregrafica ";
		List<Estacao> estacoes = jdbcTemplate.query(sql, params, new EstacaoMapper() );
		return estacoes;
	}	

	
	@RequestMapping(value = "/estacao/{id}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<Estacao> getEstacao( @PathVariable("id") String estacaoId ) {
		Object[] params = new Object[] { estacaoId };
		String sql = "select cod_estacao_maregrafica, num_estacao_maregrafica," + 
				"nome_estacao_maregrafica, latitude, longitude, fuso, tabua," + 
				"num_ana, fluviometrica, local_origem, cod_pais, instituicao," + 
				"identificacao_nivel_datum, data_referencia_datum," + 
				"elevacao_nivel_medio_mar_local, elevacao_nivel_medio_mar_ibge," + 
				"num_ana, fluviometrica, identificacao_rn_local, identificacao_rn_ibge " + 
				"from sc_mare.tb_estacao_maregrafica " + 
				"where cod_estacao_maregrafica = ?";
		List<Estacao> estacoes = jdbcTemplate.query(sql, params, new EstacaoMapper() );
		return estacoes;
	}
	
	
	
}

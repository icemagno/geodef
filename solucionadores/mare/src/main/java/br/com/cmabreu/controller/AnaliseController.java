package br.com.cmabreu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.com.cmabreu.mappers.AlturaMapper;
import br.com.cmabreu.misc.TipoAnaliseEnum;
import br.com.cmabreu.model.Altura;
import br.com.cmabreu.services.AnaliseDLLService;

@RestController
public class AnaliseController {

	@Value("${mare.targetdir}")
	private String targetDir;
	
	@Value("${mare.sourcedir}")
	private String sourceDir;

	@Autowired
	private AnaliseDLLService analiseDLLService;
	
	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	
	@RequestMapping(value = "/analise", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String doAnaliseHarmonica(   ) {
		String arqAlt = sourceDir + "/ALT.txt";
		String arqAh = sourceDir + "/AH.txt";
		String arqConst = sourceDir + "/CH.txt";
		TipoAnaliseEnum tipoAnalise = TipoAnaliseEnum.ANALISE_HARMONICA;
		analiseDLLService.analiseHarmonica( tipoAnalise, arqAlt, arqAh, arqConst );
		return "ok";
	}	
	
	
	@RequestMapping(value = "/alturas/{tabua}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<Altura> getAlturas( @PathVariable("tabua") Integer codTabua ) {
		Object[] params = new Object[] { codTabua };
		String sql = "select * from sc_mare.vw_sisgeodef_tabua_mare_altura order by data_hora asc where cod_tabua = ? order by data_hora asc";
		List<Altura> alturas = jdbcTemplate.query(sql, params, new AlturaMapper() );
		return alturas;
	}	
	

	@RequestMapping(value = "/alturas", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public List<Altura> getAlturas( ) {
		Object[] params = new Object[] { };
		String sql = "select * from sc_mare.vw_sisgeodef_tabua_mare_altura order by data_hora asc";
		List<Altura> alturas = jdbcTemplate.query(sql, params, new AlturaMapper() );
		return alturas;
	}	
	
	
}

package br.mil.defesa.sisgeodef.controller;

import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.common.io.CharStreams;

@RestController
@RequestMapping("/v1")
public class PistasController {
	private Logger logger = LoggerFactory.getLogger(PistasController.class);
	
	@Value("${lucene.database.url}")
	private String connectionString;  	

	@Value("${lucene.database.user}")
	private String user;  	

	@Value("${lucene.database.password}")
	private String password;  	

    @Value("classpath:mock/pistas.json")
    Resource pistas;	
	
	
	/*
	-- 1 - CLASSE PCN
	-- 2 - FLEXIBLE  | RIGID
	-- 3 - A | B | C | D
	-- 4 - W | X | Y | Z
	-- 5 - TECH      | ACFT
	-- 6 - LENGTH
	-- 7 - WIDTH

	-- select icaro_pcn( 40, 'FLEXIBLE', '*', '*', '*', 2000, 50 ) as resultset
	
	*/
	
    @RequestMapping(value = "/runways", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getRunWays( 
			@RequestParam(value="pcn",required=true) Integer pcn, 
			@RequestParam(value="pavimento",required=true) String pavimento, 
			@RequestParam(value="resistencia",required=true) String resistencia, 
			@RequestParam(value="pressao",required=true) String pressao, 
			@RequestParam(value="avaliacao",required=true) String avaliacao, 
			@RequestParam(value="comprimento",required=true) Integer comprimento, 
			@RequestParam(value="largura",required=true) Integer largura,
			@RequestParam(value="icao", required=false) String icao ) {
    	
		String result = "{}";
		
		if ( icao == null ) icao = "*";
		
		String sql = "select icaro_pcn( "+pcn+", '"+pavimento+"', '"+resistencia+"', '"+pressao+"', '"+avaliacao+"', "+comprimento+", "+largura+", '"+icao+"' ) as resultset";
		
		logger.info( sql );
		
		try (
			Connection sqlConnection  =  DriverManager.getConnection(connectionString, user, password);
			PreparedStatement ps = sqlConnection.prepareStatement( sql ); 
	        ResultSet rs = ps.executeQuery() ) {
		    while (rs.next() ) {
		        result = rs.getString("resultset");
			}
        } catch (SQLException e) {
        	e.printStackTrace();
	    }
		return result;
	}	


	@RequestMapping(value = "/mock", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getPistasMock(  ) {
		String result = "";
		try {
			result = CharStreams.toString( new InputStreamReader( pistas.getInputStream() ) );
		} catch ( Exception ex ) {
			ex.printStackTrace();
			result = ex.getMessage();
		}
		return result;
	}	
	
	
}


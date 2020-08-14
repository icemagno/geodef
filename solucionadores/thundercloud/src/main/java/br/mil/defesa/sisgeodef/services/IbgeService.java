package br.mil.defesa.sisgeodef.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class IbgeService {
	
	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	@Value("${spring.datasource.url}")
	private String connectionString;  	

	@Value("${spring.datasource.username}")
	private String user;  	

	@Value("${spring.datasource.password}")
	private String password;  		
	
	public String getMunicipios(String polygon) {
		String result = "{}";
		String sql = "select * from getmunicipios('" + polygon + "') as resultset";
		
		try (
			Connection sqlConnection  =  DriverManager.getConnection(connectionString, user, password);
			PreparedStatement ps = sqlConnection.prepareStatement( sql ); 
	        ResultSet rs = ps.executeQuery() ) {
		    while (rs.next() ) {
		        result = rs.getString("resultset");
		        JSONObject job = new JSONObject( result );
		        result = job.toString();
			}
        } catch (SQLException e) {
        	e.printStackTrace();
	    }
		
		return result;
		
	}
	

}

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
public class AisWebService {
	
	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	@Value("${spring.datasource.url}")
	private String connectionString;  	

	@Value("${spring.datasource.username}")
	private String user;  	

	@Value("${spring.datasource.password}")
	private String password;  		
	
	
	// LINESTRING(-43.5763491352785 -22.405300535515252,-43.575770503011086 -22.885701042358264,-42.89193825941143 -22.924609032557,-42.51131533563798 -22.480900032582642,-42.80822499135502 -22.229932275691375,-43.5763491352785 -22.405300535515252)
	public String getAerodromos(String polygon) {
		String result = "{}";
		String sql = "select * from getaerodromos('" + polygon + "') as resultset";
		
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

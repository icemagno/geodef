package br.mil.defesa.sisgeodef.services;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class PointCloudService {

	@Value("${efestus.database.url}")
	private String connectionString;  	

	@Value("${efestus.database.user}")
	private String user;  	

	@Value("${efestus.database.password}")
	private String password;  	
	
	public String getCloud( String count, String l, String r, String t, String b ) {
		String result = "{}";
		String sql = "select * from public.getpcloud( "+count+", "+l+", "+b+", "+r+", "+t+") as resultset";
		
		System.out.println( sql );
		
		try (
			Connection sqlConnection  =  DriverManager.getConnection(connectionString, user, password);
			PreparedStatement ps = sqlConnection.prepareStatement( sql ); 
	        ResultSet rs = ps.executeQuery() ) {
		    while (rs.next() ) {
		        result = rs.getString("resultset");
		        JSONObject job = new JSONObject( result );
		        // Testa Features para nunca ir como NULL para o frontend. 
		        // Devera sempre ir como array ( ou array vazio )
		        try {
		        	@SuppressWarnings("unused")
					JSONArray jarr = job.getJSONArray("features");
		        } catch ( JSONException je ) { 
		        	job.put("features", new JSONArray("[]") );
		        }
		        result = job.toString();
			}
        } catch (SQLException e) {
        	e.printStackTrace();
	    }
		
		return result;
	}	
	
}

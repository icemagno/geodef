package br.mil.defesa.sisgeodef.services;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Arrays;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

@Service
public class ImportadorService {

	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	@Value("${spring.datasource.url}")
	private String connectionString;  	

	@Value("${spring.datasource.username}")
	private String user;  	

	@Value("${spring.datasource.password}")
	private String password;  		

	
	private String getData( String url ) {
		
		String responseBody = "[]";
		RestTemplate restTemplate = new RestTemplate();
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( url, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		    String statusText = e.getStatusText();
		    System.out.println( statusText );
		} catch ( Exception ex) {
			ex.printStackTrace();
		}		
		return responseBody ;
	}

	private JSONObject getXMLAsJson( String url ) {
		JSONObject result = new JSONObject();
		try {
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			headers.setAccept(Arrays.asList(MediaType.APPLICATION_XML));
			HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			result = XML.toJSONObject( response.getBody() ); 
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return result;
	}		
	
	
	public String importEstacoes() {
		String data = getData("https://mapas.inmet.gov.br/estacoes.json");
		try {
			JSONArray collection = new JSONObject( data ).getJSONArray("features");
			String sqlString;
			
			Connection sqlConnection  =  DriverManager.getConnection(connectionString, user, password);
			Statement stmt = sqlConnection.createStatement();
			
			int flag = stmt.executeUpdate("delete from estacoes_inmet");
			
			for( int x = 0; x < collection.length(); x++ ) {
				JSONObject feature = collection.getJSONObject(x);
				JSONArray coordinates = feature.getJSONObject("geometry").getJSONArray("coordinates");
				JSONObject properties = feature.getJSONObject("properties");
				
				double lng = coordinates.getDouble(0);
				double lat = coordinates.getDouble(1);
				
				String cdEstacao = properties.getString("CD_ESTACAO");
				String cdWmo = properties.getString("CD_WMO");
				String dtMedicao = properties.getString("DT_MEDICAO");
				String hrMedicao = properties.getString("HR_MEDICAO");
				String uf = properties.getString("UF");
				String vlAltitude = properties.getString("VL_ALTITUDE");
				String venVel = properties.getString("VEN_VEL");
				String venDir = properties.getString("VEN_DIR");
				String venRaj = properties.getString("VEN_RAJ");
				
				sqlString = "insert into estacoes_inmet (CD_ESTACAO,CD_WMO,DT_MEDICAO,HR_MEDICAO,UF,VL_ALTITUDE,VEN_VEL,VEN_DIR,VEN_RAJ,geom) values (" + 
				"'" + cdEstacao +  "'," +
				"'" + cdWmo +  "'," +
				"'" + dtMedicao +  "'," +
				"'" + hrMedicao +  "'," +
				"'" + uf +  "'," +
				"'" + vlAltitude +  "'," +
				"'" + venVel +  "'," +
				"'" + venDir +  "'," +
				"'" + venRaj +  "'," +
				" ST_SetSRID(ST_MakePoint("+lng+","+lat+"),4326))";	
				
				System.out.println( sqlString );
				try {
					flag = stmt.executeUpdate( sqlString );
				} catch ( Exception e ) {
					// Violacao de chave pois algumas estacoes vem repetidas
				}
				
			}
			
			
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return data;
	}

	
	public String importAerodromos() {
		String url = "http://aisweb.decea.gov.br/api/?apiKey=2046730488&apiPass=adc9f816-5cf6-11e7-a4c1-00505680c1b4&area=rotaer&rowstart=0&rowend=99999";
		JSONObject data = getXMLAsJson(url);
		
		try {
			if( data.getJSONObject("aisweb") != null  ) {
				try {
					Connection sqlConnection  =  DriverManager.getConnection(connectionString, user, password);
					Statement stmt = sqlConnection.createStatement();
					int total = data.getJSONObject("aisweb").getJSONObject("rotaer").getInt("total");
					JSONArray aerodromos = data.getJSONObject("aisweb").getJSONObject("rotaer").getJSONArray("item");
					String sqlString;
					
					int flag = stmt.executeUpdate("delete from aerodromos");
					System.out.println("Delete: " + flag );
					
					for( int x = 0; x < total; x++ ) {
						JSONObject aerodromo = aerodromos.getJSONObject( x );
						String dt = aerodromo.getString("dt");
						String uf = aerodromo.getString("uf");
						double lng = aerodromo.getDouble("lng");
						double lat = aerodromo.getDouble("lat");
						String city = aerodromo.getString("city").replace("'", "`");
						String ciad = aerodromo.getString("ciad");
						String aeroCode = aerodromo.getString("AeroCode");
						String name = aerodromo.getString("name").replace("'", "`");
						String id = aerodromo.getString("id");
						String type = aerodromo.getString("type"); // aeródromo, heliponto ou helideck
						int ciad_id = aerodromo.getInt("ciad_id");
						
						sqlString = "insert into aerodromos (dt,uf,lng,lat,city,ciad,aeroCode,nameAe,idAe,typeAe,ciad_id,geom) values (" + 
						"'" + dt +  "'," +
						"'" + uf +  "'," +
						+ lng + "," +
						+ lat + "," +
						"'" + city +  "'," +
						"'" + ciad +  "'," +
						"'" + aeroCode +  "'," +
						"'" + name +  "'," +
						"'" + id +  "'," +
						"'" + type +  "'," +
						+ ciad_id + ", ST_SetSRID(ST_MakePoint("+lng+","+lat+"),4326))";
						
						System.out.println( sqlString );
						
						flag = stmt.executeUpdate( sqlString );
					}
					
		        } catch ( SQLException e ) {
		        	e.printStackTrace();
			    }
				
				
				
				
			}
		} catch ( Exception e ) {
			return e.getMessage();
		}
		
		
		
		return "ok";
	}
	
}

package br.com.cmabreu.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import br.com.cmabreu.model.Componente;

public final class ComponenteMapper implements RowMapper<Componente> {

	@Override
	public Componente mapRow(ResultSet rs, int rowNum) throws SQLException {
		Componente componente = new Componente();
		
		componente.setCodAnaliseMares( rs.getInt("cod_analise_mares") );
		componente.setG( rs.getFloat("g") );
		componente.setH( rs.getFloat("h") );
		componente.setCodComponente( rs.getInt("cod_componente") );
		componente.setTipo( rs.getInt("tipo") );
		componente.setNome( rs.getString("nome") );
		componente.setVelocidade( rs.getDouble("velocidade") );
		componente.setNoveCiclos( rs.getInt("nove_ciclos") );
		componente.setTrezeCiclos( rs.getInt("treze_ciclos") );
		
		Timestamp timestamp1 = rs.getTimestamp("created_at");
		Timestamp timestamp2 = rs.getTimestamp("updated_at");
		if (timestamp1 != null) {
			Date date = new java.util.Date(timestamp1.getTime() );		
			componente.setCreatedAt( date );
		}
		if (timestamp2 != null) {
			Date date = new java.util.Date(timestamp2.getTime() );		
			componente.setUpdatedAt( date );
		}

		componente.setIndice1( rs.getInt("indice_1") );
		componente.setIndice2( rs.getInt("indice_2") );
		componente.setIndice3( rs.getInt("indice_3") );
		componente.setIndice4( rs.getInt("indice_4") );
		componente.setIndice5( rs.getInt("indice_5") );
		componente.setIndice6( rs.getInt("indice_6") );
		componente.setIndice7( rs.getInt("indice_7") );
		componente.setIndice8( rs.getInt("indice_8") );
		componente.setIndice9( rs.getInt("indice_9") );
		componente.setIndice10( rs.getInt("indice_10") );
		componente.setIndice11( rs.getInt("indice_11") );
		componente.setIndice12( rs.getInt("indice_12") );
		componente.setIndice13( rs.getInt("indice_13") );
		componente.setIndice14( rs.getInt("indice_14") );
		
		return componente;
	}

}

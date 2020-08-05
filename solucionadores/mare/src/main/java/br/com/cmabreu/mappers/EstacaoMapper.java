package br.com.cmabreu.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import br.com.cmabreu.model.Estacao;

public final class EstacaoMapper implements RowMapper<Estacao>{

	@Override
	public Estacao mapRow(ResultSet rs, int rowNum) throws SQLException {
		Estacao md = new Estacao();
		md.setNomeEstacaoMaregrafica( rs.getString("nome_estacao_maregrafica") );
		md.setCodEstacaoMaregrafica( rs.getString("cod_estacao_maregrafica") );
		md.setNumEstacaoMaregrafica( rs.getString("num_estacao_maregrafica") );
		
		md.setLatitude( formataLatlonMare( rs.getString("latitude"), "LT")  );
		md.setLongitude( formataLatlonMare( rs.getString("longitude"), "LG") );
		
		md.setFuso( rs.getString("fuso") );
		md.setTabua( rs.getString("tabua") );
		md.setLocalOrigem( rs.getString("local_origem") );
		md.setInstituicao( rs.getString("instituicao") );
		md.setNumAna( rs.getString("num_ana") );
		md.setFluviometrica( rs.getString("fluviometrica") );
		return md;
	}

	
	
	private String formataLatlonMare( String latLon, String tipo ) {
		Double llDouble = Double.valueOf( latLon );
		String signal = "";
	    String grAux = "";
	    String mnAux = "";
	    String segAux = "";
	    
		if( llDouble < 0 ) {
			if( tipo.equals("LT") ) {
				signal = "S";
			} else signal = "W";
		} else {
			if( tipo.equals("LT") ) {
				signal = "N";
			} else signal = "E";
		}
		
		String latLonAux = latLon.replace("-", "");
		int tam = latLonAux.length() -1;
		char[] latLonArr = latLonAux.toCharArray();

		for( int x = tam; x>=0; x-- ) {
			if( segAux.length() < 2 ) { 
				segAux = latLonArr[x] + segAux;
			} else
				if( mnAux.length() < 2 ) {
					mnAux = latLonArr[x] + mnAux;
				} else grAux = latLonArr[x] + grAux;
		}

		if ( grAux.equals("") ) grAux = "0";
		if ( mnAux.equals("") ) mnAux = "0";		
		
		if ( (tipo.equals("LT") ) && ( ( Integer.valueOf( grAux ) > 90 ) || ( Integer.valueOf( mnAux) > 59 ) || ( Integer.valueOf( segAux ) > 59 ) ) ) return "";
		if ( (tipo.equals("LG") ) && ( ( Integer.valueOf( grAux ) > 180 ) || ( Integer.valueOf( mnAux) > 59 ) || ( Integer.valueOf( segAux ) > 59 ) ) ) return "";

		
		String gr = "";
		String mn = "";
		String sg = "";
		
		if ( tipo.equals("LT") ) {
			gr =  ( "00" + grAux ).substring( grAux.length() );
		} else {
			gr =  ( "000" + grAux ).substring( grAux.length() );
		}
		mn =  ( "00" + mnAux ).substring( mnAux.length() );
		sg =  ( "00" + segAux ).substring( segAux.length() );
		
		String result = gr + mn + sg + signal;
		
		return result;
	}
	
	
}

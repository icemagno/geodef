package br.mil.defesa.apolo.interoperabilidade.misc;

import br.mil.defesa.apolo.interoperabilidade.model.LuceneInput;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public final class LuceneInputMapper implements RowMapper<LuceneInput> {
    
    @Override
    public LuceneInput mapRow(ResultSet rs, int rowNum) throws SQLException {
        LuceneInput obj = new LuceneInput();        
        
        obj.setId(rs.getLong("id"));
        obj.setFonte(rs.getString("fonte"));
        //obj.setConexaoId(rs.getLong("conexao_id"));
        obj.setLabels(rs.getString("labels"));
        obj.setLabelsResumo(rs.getString("labels_resumo"));
        obj.setMetadados(rs.getString("metadados"));
        obj.setMetadadosResumo(rs.getString("metadados_resumo"));
        obj.setQuery(rs.getString("query"));
        obj.setTipo(rs.getString("tipo"));
        obj.setJndi(rs.getString("jndi_name"));
        obj.setQtdMetadados(rs.getLong("qtd_metadados_ordenados"));
        
        
        
        return obj;
    }

    

    
    
   

}

package br.mil.defesa.apolo.interoperabilidade.controller;

import br.mil.defesa.apolo.interoperabilidade.misc.FontesMapper;
import br.mil.defesa.apolo.interoperabilidade.misc.PesosTermosMapper;
import br.mil.defesa.apolo.interoperabilidade.misc.StringMapper;
import br.mil.defesa.apolo.interoperabilidade.misc.TiposMapper;
import br.mil.defesa.apolo.interoperabilidade.model.Fonte;
import br.mil.defesa.apolo.interoperabilidade.model.PesosTermos;
import br.mil.defesa.apolo.interoperabilidade.model.Tipo;
import br.mil.defesa.apolo.interoperabilidade.resource.LucenePesosTermos;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("v1")
public class ResourceController {

    @Autowired
    JdbcTemplate jdbcTemplate;

    private static Logger log = LoggerFactory.getLogger(ResourceController.class);
    
    
    @RequestMapping(value = "/fontes", method = RequestMethod.GET)
    public List<Fonte> getFontes() {
        
        String sql = "select distinct fonte as fonte from indexacao.indexa_queries;";
        Object[] params = new Object[]{};        
        
        List<Fonte> c = jdbcTemplate.query(sql, params, new FontesMapper());
        
        return c;
                  
    }
    
    @RequestMapping(value = "/tipos", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public List<Tipo> getTiposByFonte(
            @RequestParam(value="fonte", required=false) String fonte) {
        
        String sql = "select * from indexacao.indexa_queries ";
        Object[] params = null;
        
        if(fonte != null){
            params =  new Object[]{fonte};
            sql += "where fonte = ?"; 
        }
        
        List<Tipo> c = jdbcTemplate.query(sql, params, new TiposMapper());
        
        return c;        
    }
    
    //@RequestMapping(value = "/tipos", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public List<Tipo> getTipo( Long tipo) {
        
        String sql = "select * from indexacao.indexa_queries ";
        Object[] params = null;
        
        if(tipo != null){
            params =  new Object[]{tipo};
            sql += "where id = ?"; 
        }
        
        List<Tipo> c = jdbcTemplate.query(sql, params, new TiposMapper());
        
        return c;        
    }
    
    
    public String weightTerms(String query, JdbcTemplate jdbcT) {
        
        String sql = "select * from indexacao.weighted_terms;"; 

        try {
            List<PesosTermos> pesos = jdbcT.query(sql, new Object[]{}, new PesosTermosMapper());
            LucenePesosTermos l = new LucenePesosTermos();
            
            return l.parseQuery(pesos, query);
            
        } catch (Exception e) {
            System.out.println("Erro ao obter os pesos");
            e.printStackTrace();
            
            return query;
        }
        
        
        
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    

    
     @RequestMapping(value = "/escala-classe-edgv", method = RequestMethod.GET)
    public List<String> getEscalaClasseEdgv(
                        @RequestParam(value="l", required = true) String l, 
			@RequestParam(value="r", required = true) String r, 
			@RequestParam(value="t", required = true) String t, 
			@RequestParam(value="b", required = true) String b,
                        @RequestParam(value="classe", required = true) String classe
                        
    ) {
        
        String sql = "select \n" +
        "distinct \n" +
        "escala as string \n" +
        "from (\n" +
        "	select distinct fonte, shapefile_id\n" +
        "	from indexacao.geodata g\n" +
        "	where lower(tipo) = '"+classe.toLowerCase()+"'\n" +
        "	and ST_Intersects(geom, \n" +
        "		ST_MakeEnvelope (\n" +
        "		"+r+", "+t+", \n" +
        "		"+l+", "+b+", \n" +
        "		4326)\n" +
        "		) = true\n" +
        "	)t\n" +
        "join indexacao.produtos p on (t.shapefile_id = p.shapefile_id and t.fonte = p.fonte)\n" +
        "";
        
        Object[] params = new Object[]{};        
        
        List<String> c = this.jdbcTemplate.query(sql, params, new StringMapper());
        
        return c;
                  
    }

    
    
    
}

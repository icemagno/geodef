package br.mil.defesa.apolo.interoperabilidade.controller;

import br.mil.defesa.apolo.interoperabilidade.misc.ImportObserver;
import br.mil.defesa.apolo.interoperabilidade.rabbit.JobInfoSender;
import br.mil.defesa.apolo.interoperabilidade.resource.Lucene;
import br.mil.defesa.apolo.interoperabilidade.resource.LuceneResource;

import java.io.IOException;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.json.simple.JSONObject;
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
public class LucineController {

    @Autowired
    JdbcTemplate jdbcTemplate;
    
    @Autowired
    JobInfoSender sender;	

    private ImportObserver observer;

    private static Logger log = LoggerFactory.getLogger(LucineController.class);
    
    @RequestMapping(value = "/index", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public boolean indexAll(
                            @RequestParam(value="tipo", required=false) Long tipo,
                            @RequestParam(value="fonte", required=false) String fonte,
                            @RequestParam(value="job", required=false) String jobId
                            ) {
        this.observer = new ImportObserver( jobId, sender );
        observer.notify("Iniciando o processo de Indexação dos dados da fonte: "+fonte);
        
        LuceneResource lr = new LuceneResource(tipo, fonte, jobId, this.jdbcTemplate, this.observer);
        
        Thread thread = new Thread( lr );
	thread.start();	

        return true;
        
    }
    /*    
    @RequestMapping(value = "/index/database", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public boolean indexaDatabase(
                            @RequestParam(value="tipo", required=false) Long tipo,
                            @RequestParam(value="job", required=false) String jobId
                            ) throws Exception {
        
        System.out.println("Inicializando a Indexação do banco de dados");
        return false;// executeJob(tipo);
    }
    
    @RequestMapping(value = "/index/lucene", method = RequestMethod.GET, produces = {"application/json;charset=UTF-8"})
    public boolean IndexLucene(
                            @RequestParam(value="tipo", required=false) Long tipo,
                            @RequestParam(value="job", required=false) Long jobId
                            ) {
        
        System.out.println(tipo);
        
        ResourceController rc = new ResourceController();
        rc.setJdbcTemplate(jdbcTemplate);
        
        Lucene lucene = new Lucene();        
        String sql = "select "
                + "t0.id, t0.fonte, t0.tipo, t0.metadados, t0.resumo, t0.link_simbolo, t0.geom_json "
                + "from indexacao.geodata t0 "; 
        sql += " join indexacao.indexa_queries t1 on (t0.fonte = t1.fonte and t0.tipo = t1.tipo) ";
        sql += " where t1.id = ?";
        Object[] params;
        Boolean deleteAll = true;
        
        System.out.println("Inicializando a Indexação");
        
        
        params = new Object[]{};

        int idx = 0;
        int numTipo = 0;
        int numErro = 0;

        List<Tipo> tipos = rc.getTipo(tipo);

        for (Tipo t : tipos){

            params = new Object[]{t.getId()};

            if(idx > 0 || tipos.size() == 1){
                deleteAll= false;
            } 

            try {

                Long d = new Date().getTime();

                lucene = new Lucene();
                numTipo+=1;
                System.out.println(numTipo);

                Boolean res = lucene.indexDatabase(jdbcTemplate.query(sql, params, new GeodataMapper()), true, deleteAll, observer);
                System.out.println(res);
                if(res){                        
                    System.out.println(t.getTipo()+ ": OK. (" + (new Date().getTime() - d)/1000 + " segundos)");

                } else{

                    throw new Exception("");
                }

            } catch (Exception e) {
                numErro+=1;
                System.out.println(t.getTipo()+ ": ERRO. (Fonte Ignorada do Índice)");
                e.printStackTrace();
            }                

            idx++;
        }


        System.out.println("Foram indexadas "+ numTipo+" fontes de dados e houveram "+numErro+" falhas.");

        if(numErro == 0){
            return true;
        } else{
            return false;
        }
            
            
       
        
       
    }
*/

   
    
    
   @RequestMapping(value = "/search", method = RequestMethod.GET, produces = {"application/json;"})
    public JSONObject search(  @RequestParam("query") String q,
                                    @RequestParam(value="peso", required=false) String peso,
                                    @RequestParam(value="limit", required=false) Integer limit ) throws IOException, InvalidTokenOffsetsException, ParseException{
        
        Lucene lucene = new Lucene(); 
        Boolean weight = true;        
        if(peso != null && peso.equals("false")){
            weight = false;
        }
        
        if(limit == null){
            limit = 5;
        }
        
        
        return lucene.search(q, limit, weight, jdbcTemplate);
        
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public static Logger getLog() {
        return log;
    }

    public static void setLog(Logger log) {
        LucineController.log = log;
    }
    
    

   
    
    
    
   
    
    
}

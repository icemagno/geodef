/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.apolo.interoperabilidade.resource;

import br.mil.defesa.apolo.interoperabilidade.controller.ResourceController;
import br.mil.defesa.apolo.interoperabilidade.misc.GeodataMapper;
import br.mil.defesa.apolo.interoperabilidade.misc.ImportObserver;
import br.mil.defesa.apolo.interoperabilidade.misc.LuceneInputMapper;
import br.mil.defesa.apolo.interoperabilidade.model.LuceneInput;
import br.mil.defesa.apolo.interoperabilidade.model.Tipo;
import java.util.Date;
import java.util.List;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author joaquim
 */
public class LuceneResource implements Runnable{
    private Long tipo;
    private String fonte;
    private String jobId;
    private JdbcTemplate jdbcTemplate;
    private ImportObserver observer;

    public LuceneResource(Long tipo, String fonte, String jobId, JdbcTemplate jdbcTemplate, ImportObserver observer) {
        this.tipo = tipo;
        this.fonte = fonte;
        this.jobId = jobId;
        this.jdbcTemplate = jdbcTemplate;
        this.observer = observer;
    }
    
    
    
    private Boolean execute(){
                  
        
        if(fonte != null && tipo == null){
           
            ResourceController rc = new ResourceController();
            rc.setJdbcTemplate(this.jdbcTemplate);

            List<Tipo> tipos = rc.getTiposByFonte(fonte);
            
            if(tipos == null || tipos.isEmpty()){
                this.observer.notify("Não foram encontrados dados a ser indexados.");
            } else{
                this.observer.notify("Foram encontrados "+tipos.size()+" tipos de dados a ser indexados.");
                
                for (Tipo tp : tipos){
                  try {
                      long d = new Date().getTime();
                      Boolean res = indexaDatabase(tp, jobId);
                      if(res){
                          res=indexLucene(tp, jobId);
                          if(res){
                              String tempo = (((new Date().getTime() - d)/1000) + "s");
                              this.observer.notify("Sucesso ao indexar os dados! (fonte: "+ fonte+", tipo: "+tp.getTipo()+", Tempo de Execução: "+tempo+" ).");
                              
                          } 
                      } 


                  } catch (Exception e) {
                      e.printStackTrace();
                      this.observer.notify("Lucene: Erro ao indexar, fonte: "+ fonte+ ". tipo: "+tp.getTipo());
                  }

                }  
            }
            this.observer.notify("Indexação dos dados finalizada com sucesso!");
            return true;

        }else{
            /*Boolean res = indexaDatabase(tipo, jobId);
            if(res){
                res = indexLucene(tipo, jobId);
            }*/

            return false;
        }

    }

    private Boolean indexaDatabase(Tipo tipo, String jobId) {        
        return executeJob(tipo);  
    }

    private Boolean indexLucene(Tipo tipo, String jobId) {
        ResourceController rc = new ResourceController();
        rc.setJdbcTemplate(jdbcTemplate);
        
        Lucene lucene = new Lucene();        
        String sql = "select "
                + "t0.id, t0.fonte, t0.tipo, t0.metadados, t0.resumo, t0.link_simbolo, t0.geom_json "
                + "from indexacao.geodata t0 "; 
        sql += " join indexacao.indexa_queries t1 on (t0.fonte = t1.fonte and t0.tipo = t1.tipo) ";
        sql += " where t1.id = ?";
        Object[] params;
       
        
        System.out.println("Inicializando a Indexação");
        
        
        params = new Object[]{};
        Boolean deleteAll = false;
        int idx = 0;
        params = new Object[]{tipo.getId()};             

        try {

            Boolean res = lucene.indexDatabase(jdbcTemplate.query(sql, params, new GeodataMapper()), true, deleteAll, this.observer);

            if(res){                        
                
                return true;
            } else{
                return false;
            }

        } catch (Exception e) {                      
            this.observer.notify("Erro ao indexar os dados de "+tipo.getTipo()+" para o Geocodificador", e.getMessage());
            e.printStackTrace();
            return false;
        }                

        
    }

    @Override
    public void run() {
        execute();
    }
    
    
    private Boolean executeJob(Tipo tipo) {
        PentahoDataIntegration pdi = new PentahoDataIntegration();
        
        try {
            String sql =    "select \n" +
                        "t.id, \n" +
                        "query, \n" +
                        "fonte, \n" +
                        "tipo, \n" +
                        "COALESCE(meta.metadados, ',') as metadados, \n" +
                        "COALESCE(meta.labels, ',') as labels, \n" +
                        "COALESCE(meta.metadados_resumo, ',') as metadados_resumo, \n" +
                        "COALESCE(meta.labels_resumo, ',') as labels_resumo, \n" +
                        "jndi_name,\n" +
                        "COALESCE(qtd_metadados_ordenados, 0) as qtd_metadados_ordenados \n" +
                        "from indexacao.indexa_queries t\n" +
                        "left join indexacao.view_metadados meta on (t.id = meta.id_query)\n" +
                        "left join indexacao.conexoes_config con on (con.id = t.id_conexao) \n"+
                        "where t.id = ?";
        
            Object[] params =  new Object[]{tipo.getId()};
            LuceneInput li = jdbcTemplate.query(sql, params, new LuceneInputMapper()).get(0);
            
            return pdi.runJob(tipo.getId(), li, this.observer);
        } catch (Exception e) {
            this.observer.notify("Erro ao indexar o banco de dados com os documentos de "+tipo.getTipo(), e.getMessage());
            return false;
        }
         
        
       
        
    }

    public Long getTipo() {
        return tipo;
    }

    public void setTipo(Long tipo) {
        this.tipo = tipo;
    }

    public String getFonte() {
        return fonte;
    }

    public void setFonte(String fonte) {
        this.fonte = fonte;
    }

    public String getJobId() {
        return jobId;
    }

    public void setJobId(String jobId) {
        this.jobId = jobId;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public ImportObserver getObserver() {
        return observer;
    }

    public void setObserver(ImportObserver observer) {
        this.observer = observer;
    }
    
    
    
        
}

 
    


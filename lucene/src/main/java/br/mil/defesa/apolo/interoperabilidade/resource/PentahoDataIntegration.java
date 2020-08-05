/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.apolo.interoperabilidade.resource;

import br.mil.defesa.apolo.interoperabilidade.misc.ImportObserver;
import br.mil.defesa.apolo.interoperabilidade.model.LuceneInput;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.pentaho.di.core.Const;
import org.pentaho.di.core.KettleEnvironment;
import org.pentaho.di.core.Result;
import org.pentaho.di.core.exception.KettleException;
import org.pentaho.di.core.logging.KettleLogStore;
import org.pentaho.di.core.util.EnvUtil;
import org.pentaho.di.job.Job;
import org.pentaho.di.job.JobMeta;

/**
 *
 * @author joaquim
 */
public class PentahoDataIntegration {
    //private final static String BASE_DIR = "/siglmd/interope/scripts/";
    private final static String PENTAHO_DIR = "/srv/lucene/files/";
    private final static String JOBNAME = "/start_indexacao.kjb";
    private final static String SHARED_CONNECTIONS = "/shared.xml";
    
    
    public Boolean runJob(Long tipo, LuceneInput li, ImportObserver observer){
        /**/
        try {
            KettleEnvironment.init();
            EnvUtil.environmentInit();
            
            System.out.println(Paths.get(PENTAHO_DIR).toString());
            System.out.println(PENTAHO_DIR.toString()+JOBNAME);
            System.out.println(Paths.get(PENTAHO_DIR).toString());
           
            System.setProperty(Const.KETTLE_SHARED_OBJECTS, PENTAHO_DIR+SHARED_CONNECTIONS);
            //System.setProperty(Const.JNDI_DIRECTORY, Paths.get(PENTAHO_DIR).toString()+"simple-jndi");
            System.setProperty(Const.JNDI_DIRECTORY, "/srv/lucene/simple-jndi/");
          
            
            
            JobMeta jobMeta = new JobMeta(PENTAHO_DIR+JOBNAME, null); 
            
            
            
            String[] connections = jobMeta.getDatabaseNames();            
                    
            for(int i = 0; i<connections.length; i++){                
                jobMeta.removeDatabase(i);
            }
            
            jobMeta.setSharedObjectsFile("/srv/lucene/files/shared.xml");
            //jobMeta.
            jobMeta.readSharedObjects();
            
            Job job = new Job(null, jobMeta);
            //Fill parameters

            Map<String, String> parameters = new HashMap<String, String>();
            parameters.put("0", li.getFonte());     
            parameters.put("1", li.getTipo());     
            parameters.put("2", li.getQuery());     
            parameters.put("3", li.getMetadados());     
            parameters.put("4", li.getLabels());     
            parameters.put("5", li.getMetadadosResumo());     
            parameters.put("6", li.getLabelsResumo());     
            parameters.put("7", li.getJndi());     
            parameters.put("8", li.getQtdMetadados().toString());     

            for (Map.Entry<String, String> entry : parameters.entrySet()) {
                job.getJobMeta().setParameterValue(entry.getKey(), entry.getValue());
            }
           
            
            job.start();
            job.waitUntilFinished();
            
            
            Result result = job.getResult(); 
            
            System.out.println("Erros do pentaho: "+result.getNrErrors());
            
            int startLineNr =0;
            int lastLineNr = KettleLogStore.getLastBufferLineNr();
            String logText = getLogText( job, startLineNr, lastLineNr );
            
            
            
            //this.saveLogText(servicoId, result.getLogText());
            //this.saveLogText(tipo, logText);

            if(result.getNrErrors()>0){
                observer.notify("Erro ao indexar o banco de dados com os documentos de "+li.getTipo(), logText);
                return false;
            } else{
                return true;
            }
            
            

            
        } catch (KettleException ex) {
            observer.notify("Erro ao indexar o banco de dados com os documentos de "+li.getTipo(), ex.getMessage());           
            return false;
        }
         
    }
   
    
    private void saveLogText(Long servicoId, String log){
        /*
        try {
            
        
            GenericDAO daoLastExecution = new GenericDAO(InteropeUltimaCargaServico.class);
            InteropeUltimaCargaServico lastExecution = (InteropeUltimaCargaServico) daoLastExecution.findById(servicoId);


            GenericDAO daoCargaServico;
            daoCargaServico = new GenericDAO(InteropeCargaServico.class);
            InteropeCargaServico cargaServico = (InteropeCargaServico) daoCargaServico.findById(lastExecution.getCargaId());

            cargaServico.setLogText(log);

            System.out.println("#########################################");
            System.out.println(servicoId);
            System.out.println(cargaServico.getId());
            System.out.println("#########################################");



            daoCargaServico.update(cargaServico.getId(), cargaServico);
            
            
            
        } catch (Exception e) {
            System.err.println("Erro ao salvar log");
        }
        */
        
    }
    
    private String getLogText( Job job, int startLineNr, int lastLineNr ) throws KettleException {
        try {
          return KettleLogStore.getAppender().getBuffer(
            job.getLogChannel().getLogChannelId(), false, startLineNr, lastLineNr ).toString();
        } catch ( Exception error ) {
          //throw new KettleException( "Log string is too long" );
          Result result = job.getResult();
            System.out.println(result.getNrErrors());
          return result.getLogText();
        }
    }
    
}

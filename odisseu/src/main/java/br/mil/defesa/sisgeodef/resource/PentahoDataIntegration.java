/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.sisgeodef.resource;

import br.mil.defesa.sisgeodef.misc.ResultFile;
import br.mil.defesa.sisgeodef.misc.StatusTarefa;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;
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
    
    private final static String PENTAHO_DIR = "/download-files/";
    private final static String JOBNAME = "/start_migracao_bdgex.kjb";
    private final static String JOBCLEARNAME = "/start_clear_temp_bdgex.kjb";
    private final static String SHARED_CONNECTIONS = "/shared.xml";
    
    
    public Object[] runJob(ResultFile produto){
        /**/
        Object[] obj = new Object[2];
        
        try {
            KettleEnvironment.init();
            EnvUtil.environmentInit();
           
            System.setProperty(Const.KETTLE_SHARED_OBJECTS, PENTAHO_DIR+SHARED_CONNECTIONS);
     
            JobMeta jobMeta = new JobMeta(PENTAHO_DIR+JOBNAME, null); 
            
            String[] connections = jobMeta.getDatabaseNames();            
                    
            for(int i = 0; i<connections.length; i++){                
                jobMeta.removeDatabase(i);
            }
            
            jobMeta.setSharedObjectsFile("/download-files/shared.xml");            
            jobMeta.readSharedObjects();
            
            
            Job job = new Job(null, jobMeta);
            //Fill parameters

            Map<String, String> parameters = new HashMap<String, String>();
            parameters.put("file", produto.getFileId());      
            //parameters.put("obj", new JSONObject(produto).toString()); 

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
            
            int status = StatusTarefa.OK;
            
            if(result.getNrErrors()>0){
                status = StatusTarefa.ERROR;
            } 
            
            obj[0]=status;
            obj[1]=logText;
            
            return obj;
            
        } catch (KettleException ex) {
            Logger.getLogger(PentahoDataIntegration.class.getName()).log(Level.SEVERE, null, ex);
            ex.printStackTrace();
            
            obj[0]=StatusTarefa.ERROR;
            obj[1]=ex.getMessage();
            
            return obj;
            
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
            //System.out.println(result.getNrErrors());
          return result.getLogText();
        }
    }
    
    public void clearTempDatabase(){
        
         try {
            KettleEnvironment.init();
            EnvUtil.environmentInit();
           
            System.setProperty(Const.KETTLE_SHARED_OBJECTS, PENTAHO_DIR+SHARED_CONNECTIONS);
     
            JobMeta jobMeta = new JobMeta(PENTAHO_DIR+JOBCLEARNAME, null); 
            
            String[] connections = jobMeta.getDatabaseNames();            
                    
            for(int i = 0; i<connections.length; i++){                
                jobMeta.removeDatabase(i);
            }
            
            jobMeta.setSharedObjectsFile("/download-files/shared.xml");            
            jobMeta.readSharedObjects();
            
            
            Job job = new Job(null, jobMeta);
            //Fill parameters

            Map<String, String> parameters = new HashMap<String, String>();

            for (Map.Entry<String, String> entry : parameters.entrySet()) {
                job.getJobMeta().setParameterValue(entry.getKey(), entry.getValue());
            }
           
            
            job.start();
            job.waitUntilFinished();
            
            
            Result result = job.getResult(); 
            
            //
            
            int startLineNr =0;
            int lastLineNr = KettleLogStore.getLastBufferLineNr();
            String logText = getLogText( job, startLineNr, lastLineNr );
            
            
            
            //this.saveLogText(servicoId, result.getLogText());
         

            if(result.getNrErrors()>0){
                System.out.println("Erros ao limpa dados temporários: "+result.getNrErrors());
            } 
            
            

            
        } catch (KettleException ex) {
            Logger.getLogger(PentahoDataIntegration.class.getName()).log(Level.SEVERE, null, ex);
            ex.printStackTrace();
            
            
        }
    }
    
}

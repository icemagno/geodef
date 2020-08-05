package br.mil.defesa.sisgeodef.downloader;

import br.mil.defesa.sisgeodef.controller.V1Controller;
import br.mil.defesa.sisgeodef.misc.AreaMigracao;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.apache.commons.io.FilenameUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.misc.ResultFile;
import br.mil.defesa.sisgeodef.misc.ResultFileList;
import br.mil.defesa.sisgeodef.misc.StatusTarefa;
import br.mil.defesa.sisgeodef.model.ShapeFile;
import br.mil.defesa.sisgeodef.repository.ShapeFileRepository;
import br.mil.defesa.sisgeodef.resource.PentahoDataIntegration;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.stream.Collectors;
import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import org.apache.commons.io.FileUtils;

public class FileDownloader implements Runnable {
    private IDownloaderObserver observer;
    private String targetDirectory;
    private HttpComponentsClientHttpRequestFactory factory;
    private ResultFile file;
    private AreaMigracao am;
    private String cookie;
    private String jobSerial;
    private String targetShpDirectory;
    private List<File> filesToProcess;
    private ShapeFileRepository shapeFileRepository;
    private V1Controller vc;
    private Long downloadSize;

    public FileDownloader( IDownloaderObserver observer, HttpComponentsClientHttpRequestFactory factory, String targetDirectory, ResultFile file, AreaMigracao am, String cookie, String jobSerial, ShapeFileRepository shapeFileRepository, V1Controller vc ) {
            this.observer = observer;
            this.factory = factory;
            this.targetDirectory = targetDirectory;
            this.targetShpDirectory = targetDirectory + "/shp/";
            this.file = file;
            this.am = am;
            this.cookie = cookie;
            this.jobSerial = jobSerial;
            this.filesToProcess = new ArrayList<File>();
            this.shapeFileRepository = shapeFileRepository;
            this.vc = vc;
    }

    private Object[] downloadProduto( ResultFile produto) {
        Object[] obj = new Object[2];
        int success = 0;
        int errors = 0;

        

        try {
                // Verifico no banco se o arquivo ZIP ja foi baixado. Tabela "ShapeFile"
                String gmdFileIdentifier = produto.getFileId();
                Optional<ShapeFile> shpFile = shapeFileRepository.findByGmdFileIdentifier(gmdFileIdentifier);
                ShapeFile newShpFile = null;
                
                // Se nao tenho o ZIP aqui...
                if ( shpFile.isPresent() ) {
                    newShpFile = shpFile.get();
                } else{
                    newShpFile = new ShapeFile();
                }

                // DOWNLOAD ******************************************************************************
                String fileToDownload = "https://bdgex.eb.mil.br/mediador/index.php?modulo=download&acao=baixar&identificador=" + gmdFileIdentifier ;
                //observer.notify( "Downloading " + produto.getCitation() + " para " + targetDirectory );
                //observer.notify( " > " +  produto.getFileId() );
                RestTemplate restTemplateB ;

                if ( factory != null ) restTemplateB = new RestTemplate( factory ); else restTemplateB = new RestTemplate( ); 

                    restTemplateB.getMessageConverters().add( new ByteArrayHttpMessageConverter() );


                    HttpHeaders headersB = new HttpHeaders();
                    headersB.setAccept( Arrays.asList( MediaType.APPLICATION_OCTET_STREAM ) );                    
                    headersB.add( "Cookie", cookie );
                    

                    HttpEntity<String> entity = new HttpEntity<>( headersB );
                    ResponseEntity<byte[]> responseB = restTemplateB.exchange( fileToDownload, HttpMethod.GET, entity, byte[].class, "1" );
                    HttpHeaders headersC = responseB.getHeaders();
                   	

                    try {
                        String content = headersC.get("Content-Disposition").get(0);
                        String[] contents = content.split(";");
                        String fileName = contents[1].trim().replace("filename=", "");
                        //observer.notify( " > " + fileName );
                        if ( responseB.getStatusCode() == HttpStatus.OK) {
                            Files.write( Paths.get( targetDirectory, fileName ), responseB.getBody() );

                            // Extrai o ZIP expondo os SHP
                            extract( targetDirectory, fileName, gmdFileIdentifier );

                            // Grava o nome d oarquivo ZIP juuntamente com seu ID
                            //ShapeFile newShpFile = new ShapeFile();
                            //newShpFile.setFileName( fileName );
                            newShpFile.setFileName( produto.getCitation() );
                            newShpFile.setGmdFileIdentifier( gmdFileIdentifier );
                            newShpFile.setContato(produto.getContact());
                            newShpFile.setDataMigracao(new Date());
                            newShpFile.setEscala(produto.getEscala());
                            newShpFile.setSerie(produto.getSeries());
                            newShpFile.setTipo(produto.getCollectiveTitle());

                            shapeFileRepository.save( newShpFile );

                            success++;
                        } else {
                            errors++;
                            //observer.notify("Erro ao obter o produto ."+produto.getCitation());
                            //observer.notify("Erro: Stastus Code = " + responseB.getStatusCode() );
                        }
                    } catch ( Exception ex ) {
                        errors++;
                        obj[1] = ex.getMessage();
                            //observer.notify( "Erro: " + ex.getMessage() );
                            //observer.notify("Erro ao obter o produto ."+produto.getCitation());
                    } finally{
                      
                    }

                    //observer.notify( "Sucesso ao obter o produto " + produto.getCitation() );			


        } catch( Exception e ) {
            //observer.notify("Erro ao obter o produto ."+produto.getCitation());
            obj[1] = e.getMessage();
                e.printStackTrace();
                errors++;
        }

        

        //observer.notify( "Download encerrado. " + success + " arquivos baixados. " + errors + " erros ao baixar.");
        int status = StatusTarefa.OK;
        
        if(errors == 1){            
            status = StatusTarefa.ERROR;
        }
        obj[0]=status;
        
        
        return obj;
    }
    
    public static void deleteFolder(File folder) {
        try {
        
            File[] files = folder.listFiles();
            if(files!=null) { //some JVMs return null for empty dirs
                for(File f: files) {
                    if(f.isDirectory()) {
                        FileUtils.deleteDirectory(f);
                        //deleteFolder(f);
                    } else {
                        f.delete();
                    }
                }
            }
            //folder.delete();
        } catch (Exception e) {
        }
    }

    // Recursivamente analisa uma pasta e cataloga todos os SHP encontrados
    public List<File> listFilesForFolder( File folder ) {
            List<File> files = new ArrayList<File>();

        for ( final File fileEntry : folder.listFiles() ) {
            if ( fileEntry.isDirectory() ) {
                files.addAll( listFilesForFolder(fileEntry) );
            } else {
                    if ( FilenameUtils.getExtension( fileEntry.getName() ).equals("shp") ) { 
                            files.add( fileEntry );
                    }
            }
        }

        return files;
    }	


    private Object[] importShp(ResultFile produto) {
        Object[] obj = new Object[2];
        int total = 0;
        int errors = 0;

        // Para cada SHP encontrado, importa para o banco
        for ( File file : filesToProcess ) {
                //observer.notify( file.getName() );
                total++;
                
                try {			
                    List<String> args = new ArrayList<String>();
                    String ogr = targetDirectory + "/ogr.sh";
                    args.add( ogr );
                    args.add( file.getAbsolutePath() );

                    Process process = new ProcessBuilder( args ).directory( new File(targetDirectory) ).start();

                    int returnCode = process.waitFor();

                    if(returnCode > 0){
                        String output = getOutput(process);
                        
                        observer.notify("Erro ao importar o shape ("+total+" / "+filesToProcess.size()+") '"+ file.getName() +"' do produto '"+ produto.getCitation()+"'", output);
                        
                        errors++;
                    }

                    //observer.notify(" > Retornou: " + returnCode );

                } catch ( Exception e ) {
                    errors++;
                    obj[1] = e.getMessage();
                    
                    e.printStackTrace();
                    observer.notify("Erro ao importar o shape ("+total+" / "+filesToProcess.size()+") '"+ file.getName() +"' do produto '"+ produto.getCitation()+"'", e.getMessage() );
                }


        }
        
        int status = StatusTarefa.OK;
        

        if(total == errors && errors > 0){  
           observer.notify("A migração do(s) "+total+" shapes do produto "+produto.getCitation()+" falharam e serão ignorados nesta migração");
           status =  StatusTarefa.ERROR;
           
        } else if(total > errors && errors > 0){
           observer.notify("Apenas  " + (total - errors) + " de "+ total+ " shapes do produto " +  produto.getCitation()+ " foram importados com sucesso.");
           observer.notify("Os shapes que falharam serão ignorados nesta migração");
           status =  StatusTarefa.WARNNING;
        }
        obj[0]=status;
        
        return obj;
    }
    
    private static String getOutput(Process p) {
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        
        return br.lines().collect(Collectors.joining());
    }

    private String extract( String targetDirectory, String fileName, String targetSubFolder ) throws IOException, ZipException {
            //observer.notify(" > Extraindo " + fileName + " para " + targetShpDirectory );
            String targetFolder = targetShpDirectory + targetSubFolder + "/";

            String fullFilePath = targetDirectory + "/" + fileName;
            filesToProcess = new ArrayList<File>();
        try {


             ZipFile zipFile = new ZipFile( fullFilePath );
             zipFile.extractAll( targetFolder );
             
             this.downloadSize +=zipFile.getFile().length();

             List<File> files = listFilesForFolder( new File( targetFolder ) );

                 //observer.notify( " > " + files.size() + " arquivos SHP extraidos." );
                 filesToProcess.addAll( files );
        } catch (ZipException e) {
            observer.notify( "Erro: " + e.getMessage() );
            throw e;
           
        } finally {
            File zip = new File(fullFilePath);
            zip.delete();
           
        }

        return fullFilePath;

    }

    @Override
    public void run() {
        migraBDGEX();
    }

    private void migraBDGEX() {
        SearcherOnBDGEX bdg = new SearcherOnBDGEX(this.vc); 
        Integer ini = 0;
        this.downloadSize = ini.longValue();
        long startAll = System.currentTimeMillis();
        System.out.println("Iniciando processo de obtenção");
        
        // Recebe uma área de interesse. No futuro pode receber uma entidade de operação que possui sua area de atuação.
        
        ResultFileList listaProdutos = null;
        
        try{
            observer.notify("Iniciando consulta de produtos no BDGEX");
            listaProdutos = bdg.getListFiles(am, this.jobSerial, this.vc);
            float sec = (System.currentTimeMillis() - startAll) / 1000F;
            
            if(listaProdutos == null){
                observer.notify("Não foram retornados produtos"+ ". ("+sec+" segundos)");
                listaProdutos = new ResultFileList();
            } else{
                observer.notify("Foram encontrados "+listaProdutos.getSize()+" produtos"+ ". ("+sec+" segundos)");
                observer.notify("Iniciando processo de obtenção dos produtos.");
            }
        } catch (Exception e) {
            float sec = (System.currentTimeMillis() - startAll) / 1000F;
            listaProdutos = new ResultFileList();
            observer.notify("Não foram retornados produtos"+ ". ("+sec+" segundos)", e.getMessage());
        }
        
        int i = 0;        
        for(ResultFile produto: listaProdutos.getList()){
            int status = StatusTarefa.OK;
            long start = System.currentTimeMillis();
            
            clearTempData();
           
            //if(produto.getFileId().equals("2f797f24-a768-ccc3-dc55-503c43dd17fd")){
            
            // Rotina de Obtenção dos produtos
            try {
                Object[] obj = downloadProduto(produto);
                status = (int) obj[0] ;
                String detail = (String) obj[1] ;
                
                float sec = (System.currentTimeMillis() - start) / 1000F;
                
                if(status == StatusTarefa.ERROR){
                    observer.notify("Erro ao obter o produto "+produto.getCitation()+ ". ("+sec+" segundos)", detail);
                }
            } catch (Exception e) {
                float sec = (System.currentTimeMillis() - start) / 1000F;
                observer.notify("Erro ao obter o produto "+produto.getCitation()+ ". ("+sec+" segundos)", e.getMessage());
            }
            
       
            
            
            try {
                
                if(status == StatusTarefa.OK){
                    Object[] obj = importShp(produto);
                    status = (int) obj[0] ;
                    String detail = (String) obj[1] ;
                } 
                
            } catch (Exception e) {
                status = StatusTarefa.ERROR;
                float sec = (System.currentTimeMillis() - start) / 1000F;
                observer.notify("Erro ao importar os arquivos do produto "+produto.getCitation()+" para o schema banco de dados"+ ". ("+sec+" segundos)", e.getMessage());
            }

            try {
                if(status == StatusTarefa.OK){
                    Object[] obj = importWithPDI(produto);
                    status = (int) obj[0] ;
                    String detail = (String) obj[1] ;
                    
                    //status = importWithPDI(produto);
                    float sec = (System.currentTimeMillis() - start) / 1000F;
                    if(status == StatusTarefa.OK){
                        
                        observer.notify("Sucesso ao migrar os dados do produto "+produto.getCitation() + ". ("+sec+" segundos)");
                        observer.notify("Tamanho Total dos Arquivos Baixados: "+this.downloadSize.intValue() );
                    } else{
                        observer.notify("Erro ao migrar os dados do produto "+produto.getCitation()+ ". ("+sec+" segundos)", detail);
                    }
                }                
            } catch (Exception e) {
                float sec = (System.currentTimeMillis() - start) / 1000F;
                
                observer.notify("Erro ao migrar os dados do produto "+produto.getCitation()+ ". ("+sec+" segundos)", e.getMessage());
            }
            //}
            i++;
            
            deleteFolder(new File(targetDirectory+"shp/"));
           
        }
        
        float sec = (System.currentTimeMillis() - startAll) / 1000F;
        observer.notify("Migração dos dados do BDGEX realizada com sucesso! ("+sec+" segundos)");
        observer.notify("Iniciando o processo de Indexação dos dados no SisGeoDef...");
        bdg.index(this.jobSerial);
    }

    private Object[] importWithPDI(ResultFile produto) {
        PentahoDataIntegration pdi = new PentahoDataIntegration();
        return pdi.runJob(produto);
        
    }
    private void clearTempData() {
        try {
            PentahoDataIntegration pdi = new PentahoDataIntegration();
            pdi.clearTempDatabase();
        } catch (Exception e) {
        }
       
        
    }

	
}

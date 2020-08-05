package br.mil.defesa.sisgeodef.misc;

import br.mil.defesa.sisgeodef.model.ShapeFile;
import br.mil.defesa.sisgeodef.repository.ShapeFileRepository;
import br.mil.defesa.sisgeodef.resource.PentahoDataIntegration;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.lang.ProcessBuilder.Redirect;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.apache.commons.io.FilenameUtils;

public class FileImporter implements Runnable {
    private ImportObserver observer;
    private String chartFolder;
    private String jobSerial;
    private ShapeFileRepository shapeFileRepository;

    public FileImporter( String jobSerial, ImportObserver observer, String chartFolder, ShapeFileRepository shapeFileRepository ) {
        this.jobSerial = jobSerial;
        this.observer = observer;
        this.chartFolder = chartFolder;
        this.shapeFileRepository = shapeFileRepository;
    }

    private Object[] importChart(File produto ) {   
        Object[] obj = new Object[2];
        int total = 0;
        int errors = 0;

        //observer.notify("Importando arquivos...");

        // Para cada SHP encontrado, importa para o banco

        //observer.notify( produto.getName() );

        try {
            Optional<ShapeFile> shpFile = shapeFileRepository.findByFileName(produto.getName());
            ShapeFile newShpFile = null;
            System.out.println("Produto: "+ produto.getName());
            
            if ( shpFile.isPresent() ) {
                newShpFile = shpFile.get();
                newShpFile.setDataMigracao(new Date());
                shapeFileRepository.save(newShpFile);
            }
            
            
            List<String> args = new ArrayList<String>();
            String ogr = this.chartFolder + "ogr.sh";
            
            System.out.println(ogr);
            System.out.println(produto.getAbsolutePath());
        
            args.add( ogr );
            args.add( produto.getAbsolutePath() );
                    
            Process process = new ProcessBuilder( args ).directory( new File(this.chartFolder) ).redirectError(Redirect.INHERIT).redirectOutput(Redirect.INHERIT).start();

                int returnCode = process.waitFor();
                if(returnCode > 0){    
                    obj[1] = getOutput(process);
                    //observer.notify("Erro ao importar a carta "+ produto.getName() +".", output );
                    errors++;
                } 


        } catch ( Exception e ) {
            e.printStackTrace();
            obj[1] =e.getMessage();
            //observer.notify("Erro ao importar a carta "+ produto.getName() +".", e.getMessage());
            errors++;
        }
        
        obj[0]=StatusTarefa.OK;

        if(errors > 0){  
            //observer.notify("A importação da carta "+produto.getName()+" falhou e será ignorada nesta migração.");
            obj[0]=StatusTarefa.ERROR;        
        } 
        
        return obj;

    }
    private static String getOutput(Process p) {
        BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
        
        return br.lines().collect(Collectors.joining());
    }


    @Override
    public void run() {
        //importCharts(  );
        migraBDGEX();
    }



    private void migraBDGEX() {
        // Insere "na mão" os arquivos shapes na tabela shapefile
        // Apenas para o protótipo
        insertShapesTempPrototipo();

        // Recebe uma área de interesse. No futuro pode receber uma entidade de operação que possui sua area de atuação.
        long startAll = System.currentTimeMillis();
        System.out.println("Iniciando processo de obtenção");
        List<File> listaProdutos = null;


        try{
            observer.notify("Iniciando consulta de cartas no CHM");
            listaProdutos = listFilesForFolder( new File( this.chartFolder ) );
            float sec = (System.currentTimeMillis() - startAll) / 1000F;

            if(listaProdutos == null){
                observer.notify("Não foram retornadas cartas"+ ". ("+sec+" segundos)");
                listaProdutos = new ArrayList<File>();
            } else{
                observer.notify("Foram encontradas "+listaProdutos.size()+" cartas"+ ". ("+sec+" segundos)");
                observer.notify("Iniciando processo de obtenção das cartas.");
            }

        } catch (Exception e) {
            float sec = (System.currentTimeMillis() - startAll) / 1000F;
            listaProdutos = new ArrayList<File>();
            observer.notify("Não foram retornados cartas"+ ". ("+sec+" segundos)", e.getMessage());
        }

        int i = 0;        
        for(File produto: listaProdutos){
            int status = StatusTarefa.OK;
            long start = System.currentTimeMillis();

            

            //if(i == this.idx){
            
            clearTempData();

            //Rotina de Obtenção dos produtosnewShpFile
            try {
                Object[] obj  = importChart(produto);                
                status = (int) obj[0] ;
                String detail = (String) obj[1] ;
                
                float sec = (System.currentTimeMillis() - start) / 1000F;

                if(status == StatusTarefa.ERROR){
                    observer.notify("Erro ao importar a carta "+produto.getName()+ ". ("+sec+" segundos)", detail);
                }
            } catch (Exception e) {
                float sec = (System.currentTimeMillis() - start) / 1000F;
                observer.notify("Erro ao importar a carta "+produto.getName()+ ". ("+sec+" segundos)", e.getMessage());
            }






            try {
                if(status == StatusTarefa.OK){
                    
                    Object[] obj  = importWithPDI(produto);                
                    status = (int) obj[0] ;
                    String detail = (String) obj[1] ;
                    
                    
                    float sec = (System.currentTimeMillis() - start) / 1000F;
                    if(status == StatusTarefa.OK){

                        observer.notify("Sucesso ao migrar os dados da carta "+produto.getName()+ ". ("+sec+" segundos)");
                    } else{
                        observer.notify("Erro ao migrar os dados da carta "+produto.getName()+ ". ("+sec+" segundos)", detail);
                    }
                }                
            } catch (Exception e) {
                float sec = (System.currentTimeMillis() - start) / 1000F;

                observer.notify("Erro ao migrar os dados do produto "+produto.getName()+ ". ("+sec+" segundos)", e.getMessage());
            }
            //}
            i++;

            //deleteFolder(new File(targetDirectory+"shp/"));

        }
        
        float sec = (System.currentTimeMillis() - startAll) / 1000F;
        observer.notify("Migração dos dados do BDGEX realizada com sucesso! ("+sec+" segundos)");
        observer.notify("Iniciando o processo de Indexação dos dados no SisGeoDef...");
        indexLucene(this.jobSerial);
    }
    
    // Recursivamente analisa uma pasta e cataloga todos os SHP encontrados
    private List<File> listFilesForFolder( File folder ) {
            List<File> files = new ArrayList<File>();

        for ( final File fileEntry : folder.listFiles() ) {
            if ( fileEntry.isDirectory() ) {
                files.addAll( listFilesForFolder(fileEntry) );
            } else {
                    if ( FilenameUtils.getExtension( fileEntry.getName() ).equals("gml") || FilenameUtils.getExtension( fileEntry.getName() ).equals("000") ) { 
                            files.add( fileEntry );
                    }
            }
        }

        return files;
    }



   

    private void clearTempData() {
        try {
            PentahoDataIntegration pdi = new PentahoDataIntegration();
            pdi.clearTempDatabase();
        } catch (Exception e) {
        }
                
    }

    private Object[] importWithPDI(File produto) {
        PentahoDataIntegration pdi = new PentahoDataIntegration();
        return pdi.runJob(produto);
    }

    private void indexLucene(String jobSerial) {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void insertShapesTempPrototipo() {
        try {
            Optional<ShapeFile> shpFile = null;
        
            List<ShapeFile> shapeList = new ArrayList<ShapeFile>();

            shapeList.add(new ShapeFile("BR323100.gml", "DO RIO DE JANEIRO À SANTOS", new Date()));
            shapeList.add(new ShapeFile("BR323000.gml", "DO CABO DE SÃO TOMÉ AO RIO DE JANEIRO", new Date()));
            shapeList.add(new ShapeFile("BR322900.gml", "DE VITÓRIA AO CABO DE SÃO TOMÉ", new Date()));

            for( ShapeFile sf: shapeList){
                shpFile = shapeFileRepository.findByFileName(sf.getFileName());       

                if (! shpFile.isPresent()) {
                    shapeFileRepository.save(sf);
                } 
            }
        } catch (Exception e) {
            
        }
        
        
    }

}

package br.mil.defesa.sisgeodef.misc;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.ByteArrayHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import net.lingala.zip4j.core.ZipFile;
import net.lingala.zip4j.exception.ZipException;

public class FileImporter implements Runnable {
	private ImportObserver observer;
	private String chartFolder;
	private String fileToProcess;
	private RestTemplate restTemplate;

	public FileImporter( String chartFolder, ImportObserver observer, String fileToProcess, RestTemplate restTemplate ) {
		this.fileToProcess = fileToProcess;
		this.observer = observer;
		this.chartFolder = chartFolder;
		this.restTemplate = restTemplate;
	}
	
	
	private boolean download( ) {
        restTemplate.getMessageConverters().add( new ByteArrayHttpMessageConverter() );

        HttpHeaders headers = new HttpHeaders();
        headers.setAccept( Arrays.asList( MediaType.APPLICATION_OCTET_STREAM ) );                    

        HttpEntity<String> entity = new HttpEntity<>( headers );
        ResponseEntity<byte[]> response = restTemplate.exchange( fileToProcess, HttpMethod.GET, entity, byte[].class, "1" );

        try {
            String fileName = "aixm.zip";
            if ( response.getStatusCode() == HttpStatus.OK) {
                Files.write( Paths.get( chartFolder, fileName ), response.getBody() );
                return true;
            }
        } catch ( Exception e ) {
        	e.printStackTrace();
        }
        
        return false;
		
	}
	
	private void importAIXM(  ) {
		//if ( !download() ) return;
		try {			
			String fileName = "aixm.zip";
			//String aixmFile = extract( chartFolder + "/" + fileName );
                        
                        String aixmFile = "AIXM_FULL.xml";
			
			if( aixmFile == null ) throw new Exception("Arquivo AIXM nao encontrado na pasta " + chartFolder + "aixm/" );
			
			aixmFile = chartFolder + "/" + aixmFile;
			
			observer.notify("Importando arquivo " + aixmFile );
			
        	List<String> args = new ArrayList<String>();
        	String ogr = chartFolder + "/ogr.sh";
        	args.add( ogr );
        	args.add( aixmFile );

        	Process process = new ProcessBuilder( args ).directory( new File(chartFolder) ).start();
			process.waitFor();
			
			observer.notify("Importacao do arquivo AIXM "+ aixmFile + " concluida.");
			
		} catch ( Exception e ) {
			observer.notify("Erro: " + e.getMessage() );
		}
	
	}
	
    private String extract( String fileName ) throws IOException {
        observer.notify(" > Extraindo " + fileName + " para " + chartFolder );
        String targetFolder = chartFolder + "/aixm/";


        try {
        	ZipFile zipFile = new ZipFile( fileName );
        	zipFile.extractAll( targetFolder );
        	List<File> files = listFilesForFolder( new File( targetFolder ) );
        	observer.notify( " > " + files.size() + " arquivos extraidos." );
        	
        	File file = files.get(0);
        	
        	return file.getName();
        	
	    } catch (ZipException e) {
	        observer.notify( "Erro: " + e.getMessage() );
	    } finally {
	        File zip = new File(fileName);
	        zip.delete();
	       
	    }
	    return null;
	
	}	
    
	// Recursivamente analisa uma pasta e cataloga todos os XML (AIXM) encontrados
	private List<File> listFilesForFolder( File folder ) {
		List<File> files = new ArrayList<File>();
		
	    for ( final File fileEntry : folder.listFiles() ) {
	        if ( fileEntry.isDirectory() ) {
	            files.addAll( listFilesForFolder(fileEntry) );
	        } else {
	        	if ( FilenameUtils.getExtension( fileEntry.getName() ).equals("xml") ) { 
	        		files.add( fileEntry );
	        	}
	        }
	    }
	    
	    return files;
	}    
	
	@Override
	public void run() {
		importAIXM();
	}

}

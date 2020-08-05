package br.mil.defesa.sisgeodef.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.graphhopper.reader.dem.SRTMProvider;

import br.mil.defesa.sisgeodef.misc.FileImporter;
import br.mil.defesa.sisgeodef.misc.ImportObserver;
import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;

@RestController
@RequestMapping("/v1")
public class JobController {
	private String jobSerial;
	
	@Value("${volcano.demFiles}")
	private String demFiles;
	
	@Autowired
	JobInfoSender sender;	
	
	private static Logger log = LoggerFactory.getLogger( JobController.class );

	@RequestMapping(value = "/import", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public void test( ) {
		
		SRTMProvider srtm = new SRTMProvider();
		System.out.println( srtm.getEle(-22.539475,-42.031280) ); 
		
		/*
		try {
			
			downloadList(  );
	
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		*/
	
	}
	
	private void downloadList(  ) throws Exception {
		List<File> filesToProcess = listFilesForFolder( new File( this.demFiles ) );
		
		FileImporter fd = new FileImporter( this.demFiles, new ImportObserver( jobSerial, sender ), filesToProcess );
	    Thread thread = new Thread( fd );
	    thread.start();
	}		
	
	// Recursivamente analisa uma pasta e cataloga todos os SHP encontrados
	private List<File> listFilesForFolder( File folder ) {
		List<File> files = new ArrayList<File>();
		
	    for ( final File fileEntry : folder.listFiles() ) {
	        if ( fileEntry.isDirectory() ) {
	            files.addAll( listFilesForFolder(fileEntry) );
	        } else {
	        	if ( FilenameUtils.getExtension( fileEntry.getName() ).equals("hgt") ) { 
	        		files.add( fileEntry );
	        	}
	        }
	    }
	    
	    return files;
	}		

	
}

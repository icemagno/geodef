package br.mil.defesa.sisgeodef.misc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;

public class ImportObserver {
	private String jobSerial;
	private JobInfoSender sender;
	private Logger log = LoggerFactory.getLogger( ImportObserver.class );
	
	public ImportObserver(String jobSerial, JobInfoSender sender) {
		this.sender = sender;
		this.jobSerial = jobSerial;
	}

	public void notify( String message ) {
		log.info( message );
		sender.send( new JobInfo( this.jobSerial, message ) );
	}
        
        public void notify( String message, String detail ) {
		log.info( message );
		sender.send( new JobInfo( this.jobSerial, message, detail ) );
	}

	
}

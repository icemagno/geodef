package br.mil.defesa.sisgeodef.downloader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import br.mil.defesa.sisgeodef.misc.JobInfo;
import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;

public class DownloadObserver implements IDownloaderObserver {
	private static Logger log = LoggerFactory.getLogger( DownloadObserver.class );
	private String jobSerial;
	private JobInfoSender sender;
	
	
	public DownloadObserver( String jobSerial, JobInfoSender sender ) {
		this.sender = sender;
		this.jobSerial = jobSerial;		
	}
	
	@Override
	public void notify(String message) {
		log.info( message );
		sender.send( new JobInfo( this.jobSerial, message ) );
	}

        @Override
        public void notify(String message, String detail) {
            log.info( message );
            sender.send( new JobInfo( this.jobSerial, message, detail ) );
        }

	
}

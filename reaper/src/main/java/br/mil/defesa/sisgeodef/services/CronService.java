package br.mil.defesa.sisgeodef.services;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.worker.Worker;

@Service
@EnableScheduling
public class CronService {
	private Logger logger = LoggerFactory.getLogger(CronService.class);
	private List<Worker> workers = new ArrayList<Worker>();
	
	@Scheduled(cron = "0/7 * * * * *") 
	public void doImport() {
		logger.info("Processando " + workers.size() + " workers.");
		for( Worker worker : workers ) {
			worker.doImport();
		}
	}	
	
	private boolean exists( String url ) {
		for( Worker worker : workers ) {
			if( worker.getUrl().equals( url ) ) return true;
		}
		return false;
	}
	
	public String addWork( String url, String userCpf, String layerName, String bn, String bs, String be, String bw ) {
		if( !exists( url ) ) {
			this.workers.add( new Worker( url, userCpf, layerName, bn, bs, be, bw ) );
			return "Ok";
		} else {
			return "Esta origem já existe";
		}
	}
}

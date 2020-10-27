package br.mil.defesa.sisgeodef.services;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.worker.Worker;

@Service
@EnableScheduling
public class CronService {
	private Logger logger = LoggerFactory.getLogger(CronService.class);
	private List<Worker> workers = new ArrayList<Worker>();
	
	@Autowired
	private ImportService importService;	
	
	@Scheduled(cron = "0/7 * * * * *") 
	public void doImport() {
		boolean someoneIsWorking = false;
		for( Worker worker : workers ) {
			if( worker.isWorking() ) someoneIsWorking = true;
			worker.doImport();
		}
		// Se nao tiver ninguem ativo limpa o controle
		if( !someoneIsWorking ) this.workers.clear();
	}	
	
	private boolean exists( String url ) {
		for( Worker worker : workers ) {
			if( worker.getUrl().equals( url ) ) return true;
		}
		return false;
	}
	
	public String addWork( String url, String userCpf, String layerName, String bn, String bs, String be, String bw ) {
		logger.info("Nova tarefa para " + userCpf + " em " + url + " na camada " + layerName );
		if( !exists( url ) ) {
			this.workers.add( new Worker( url, userCpf, layerName, bn, bs, be, bw, importService ) );
			return "Ok";
		} else {
			return "Esta origem já existe";
		}
	}
}

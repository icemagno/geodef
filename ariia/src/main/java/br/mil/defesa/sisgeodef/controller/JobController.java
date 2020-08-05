package br.mil.defesa.sisgeodef.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.model.Job;

@RestController
@RequestMapping("/v1")
public class JobController {
	
	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	private static Logger log = LoggerFactory.getLogger( JobController.class );
	

	@RequestMapping(value = "/finish", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public void finishJob( @RequestParam(value="jobId", required = true) String jobId ) {
		log.info("Encerrar Tarefa " + jobId );
	}

	@RequestMapping(value = "/fail", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
	public void failJob( 
			@RequestParam(value="jobId", required = true) String jobId,
			@RequestParam(value="reason", required = true) String reason ) {
		
		log.info("Encerrar Com falha Tarefa " + jobId );
	}
	
	
	@RequestMapping(value = "/get", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public Job getJob( @RequestParam(value="jobId", required = true) String jobId ) {
		log.info("Recuperar Tarefa " + jobId );

		// Devera ser recuperado do banco
		Job job = new Job();
		job.setUserId("MOCK");
		job.setData("MOCK");
		job.setStatus("RUNNING");
		return job;
	}
	
	@RequestMapping(value = "/setinfo", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public void setInfo( 
			@RequestParam(value="jobId", required = true) String jobId,
			@RequestParam(value="info", required = true) String info) {
		
		log.info("Log de andamento para Tarefa " + jobId );
	}

	
	@RequestMapping(value = "/new", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public Job newJob( @RequestParam(value="userId", required = true) String userId ) {
		log.info("Nova tarefa para " + userId );
		Job job = new Job();
		job.setUserId(userId);
		job.setData("");
		return job;
	}	
	

	
	
}

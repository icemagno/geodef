package br.mil.defesa.sisgeodef.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import br.mil.defesa.sisgeodef.misc.AccessLogList;
import br.mil.defesa.sisgeodef.model.AccessLog;
import br.mil.defesa.sisgeodef.repository.AccessLogRepository;

@Controller
public class LogController {
	
    @Autowired
    AccessLogRepository accessLogRepository;		
	
    
	@RequestMapping(value = "/logs/{maxRows}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody AccessLogList getLogList( @PathVariable("maxRows") int maxRows ) {
		List<AccessLog> logs = accessLogRepository.findTopNOrderByDateDesc( maxRows );
		AccessLogList list = new AccessLogList( logs ); 
		return list;
	}	

	
	@RequestMapping(value = "/logs/{id}/{maxRows}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody AccessLogList getLogListByUserId( @PathVariable("maxRows") int maxRows, @PathVariable("id") long id ) {
		List<AccessLog> logs = accessLogRepository.findTopNByRemoteUserIdOrderByDateDesc( maxRows, id );
		AccessLogList list = new AccessLogList( logs ); 
		return list;
	}		
	
	
}

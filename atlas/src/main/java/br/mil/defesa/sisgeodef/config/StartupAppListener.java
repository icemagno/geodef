package br.mil.defesa.sisgeodef.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

import br.mil.defesa.sisgeodef.services.CartografiaIndexService;

@Component
public class StartupAppListener implements ApplicationListener<ContextRefreshedEvent> {

	@Autowired
	private CartografiaIndexService cartografiaService;	
	
	
	
	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		/*
		try {
			cartografiaService.acquire();
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		*/
	}


}

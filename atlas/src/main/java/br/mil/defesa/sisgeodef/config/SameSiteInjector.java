package br.mil.defesa.sisgeodef.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class SameSiteInjector {
	private static final Logger log = LoggerFactory.getLogger( SameSiteInjector.class ); 

	@Autowired
	private ApplicationContext context;

	
	@EventListener
	public void onApplicationEvent(ContextRefreshedEvent event) {
		 log.debug("Teste de pegar propriedade: ARCHIMEDES_CONFIG_URI = " + context.getEnvironment().getProperty("ARCHIMEDES_CONFIG_URI") );
	}	
	
	
}

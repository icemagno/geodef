package br.mil.defesa.sisgeodef.config;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
public class StartupAppListener implements ApplicationListener<ContextRefreshedEvent> {

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		System.out.println("***********************************************************");
		System.out.println("*** Você precisa apargar os arquivos de legenda antigos ***");
		System.out.println("*** Você precisa apargar os arquivos de uploads antigos ***");
		System.out.println("***********************************************************");
	}


}

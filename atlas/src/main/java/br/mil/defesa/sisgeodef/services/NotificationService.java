package br.mil.defesa.sisgeodef.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.misc.Notifications;

@Service
public class NotificationService {

	@Autowired
	private SimpMessagingTemplate messagingTemplate;
	  
	public void notify( Notifications notifications ) {
		
		System.out.println("sdfsdfdfdfsdf");
		
		
		try {
			messagingTemplate.convertAndSend("/queue/notify", notifications );
		} catch ( Exception e ) {
			System.out.println(" >> Erro: " + e.getMessage() );
		}
		
	}	  
	
}

package br.mil.defesa.sisgeodef.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketController {

    @MessageMapping("/drone/create")
    //@SendTo("/drone/create")
    public String newDrone(@Payload String payload ) {
    	System.out.println("Novo Drone!");
        return payload;
    }	

    /*
    @MessageMapping("/drone/update")
    public String updateDrone(@Payload String payload ) {
        return payload;
    }	
	*/

    
}

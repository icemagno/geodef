package br.mil.defesa.sisgeodef.rabbit;

import org.json.JSONObject;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SolucionadorSender {
 
    @Autowired
    private RabbitTemplate rabbitTemplate;
 
    @Autowired
    private Queue queue;
 
    public void send(String s) {
    	JSONObject dummy = new JSONObject();
    	dummy.put("message", s);
    	rabbitTemplate.convertAndSend(this.queue.getName(), dummy.toString() );
    }
    
    
}

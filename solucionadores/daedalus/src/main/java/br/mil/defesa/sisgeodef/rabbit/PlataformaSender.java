package br.mil.defesa.sisgeodef.rabbit;

import org.json.JSONObject;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.mil.defesa.sisgeodef.misc.Plataforma;

@Component
public class PlataformaSender {
 
    @Autowired
    private RabbitTemplate rabbitTemplate;
 
    @Autowired
    private Queue queue;
 
    public void send(Plataforma plataforma) {
    	rabbitTemplate.convertAndSend(this.queue.getName(), new JSONObject( plataforma ).toString() );
    }
    
    
}

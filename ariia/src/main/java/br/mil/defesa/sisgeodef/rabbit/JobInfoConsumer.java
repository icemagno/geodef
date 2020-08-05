package br.mil.defesa.sisgeodef.rabbit;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Component;

@Component
public class JobInfoConsumer {
 
    @RabbitListener( queues = {"JobInfo"} )
    public void receive(@Payload String jobInfo) {
       System.out.println("Recebido: " + jobInfo );
    }
    
}
package br.mil.defesa.apolo.interoperabilidade;

import org.springframework.amqp.core.Queue;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@RefreshScope
public class RabbitConfig {

    @Bean
    public Queue queue() {
        return new Queue("JobInfo", true);
    }    
	
}

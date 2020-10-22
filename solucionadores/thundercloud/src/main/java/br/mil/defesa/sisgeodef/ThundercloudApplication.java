package br.mil.defesa.sisgeodef;

import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@EnableEurekaClient
@EnableCaching
@ComponentScan("br.mil.defesa.sisgeodef")
@EnableRabbit
public class ThundercloudApplication {

	public static void main(String[] args) {
		SpringApplication.run(ThundercloudApplication.class, args);
	}
	
}

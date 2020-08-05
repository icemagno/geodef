package br.com.cmabreu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class DelphosApplication {

	public static void main(String[] args) {
		SpringApplication.run(DelphosApplication.class, args);
	}
}

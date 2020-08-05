package br.com.cmabreu.archimedes;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;

@EnableConfigServer
@SpringBootApplication
public class ArchimedesApplication {

	public static void main(String[] args) {
		SpringApplication.run(ArchimedesApplication.class, args);
	}
}

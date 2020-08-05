package br.mil.defesa.sisgeodef;

import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.scheduling.annotation.Scheduled;

@SpringBootApplication
@EnableCaching
@EnableEurekaClient
@ComponentScan("br.mil.defesa.sisgeodef")
@EnableRabbit
@EnableJpaRepositories(basePackages = {"br.mil.defesa.sisgeodef.repository"})
@EntityScan( basePackages = {"br.mil.defesa.sisgeodef.model"} )
public class NautiloApplication {


	
	@Autowired
	CacheManager cacheManager;
	
	
	public static void main(String[] args) {
		SpringApplication.run(NautiloApplication.class, args);
	}
	
	public void evictAllCaches() {
	    cacheManager.getCacheNames().stream()
	      .forEach(cacheName -> cacheManager.getCache(cacheName).clear());
	}	
	
	
	@Scheduled(fixedRate = 10000)
	public void evictAllcachesAtIntervals() {
		
	    evictAllCaches();
	}	
	
	
}

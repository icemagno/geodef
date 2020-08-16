package br.mil.defesa.sisgeodef;

import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import br.mil.defesa.sisgeodef.services.CachingService;

@SpringBootApplication
@EnableEurekaClient
@EnableCaching
@EnableScheduling
@ComponentScan("br.mil.defesa.sisgeodef")
@EnableRabbit
public class SolucionadorApplication {

	@Autowired
	CacheManager cacheManager;
	
    @Autowired
    CachingService cachingService;	
	
	public static void main(String[] args) {
		SpringApplication.run(SolucionadorApplication.class, args);
	}
	
	
	// https://crontab.guru/examples.html
	@Scheduled( cron = "0 0 */4 * * *" )
	public void evictAllcachesAtIntervals() {
		cachingService.evictAllCaches();
	}	
	

	
}

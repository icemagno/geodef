package br.mil.defesa.sisgeodef;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
@EnableCaching
@EnableEurekaClient
//@EnableJpaRepositories(basePackages = {"br.mil.defesa.sisgeodef.repository"})
//@EntityScan( basePackages = {"br.mil.defesa.sisgeodef.model"} )
@ComponentScan("br.mil.defesa.sisgeodef")
public class HalvdanApplication {


	
	@Autowired
	CacheManager cacheManager;
	
	
	public static void main(String[] args) {
		SpringApplication.run(HalvdanApplication.class, args);
	}
	
	public void evictAllCaches() {
	    cacheManager.getCacheNames().stream()
	      .forEach(cacheName -> cacheManager.getCache(cacheName).clear());
	}	
	
	
	@Scheduled(fixedRate = 10000)
	public void evictAllcachesAtIntervals() {
		
	    evictAllCaches();
	}	
	
	@Configuration
	@EnableWebMvc
	public class MvcConfig implements WebMvcConfigurer {
	    @Override
	    public void addResourceHandlers(ResourceHandlerRegistry registry) {
	        registry
	          .addResourceHandler("/resources/**")
	          .addResourceLocations("/resources/"); 
	    }
	}
	
	
}

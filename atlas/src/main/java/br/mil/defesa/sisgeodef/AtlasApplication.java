package br.mil.defesa.sisgeodef;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Bean;
import org.springframework.web.context.request.RequestContextListener;

@SpringBootApplication
//@EnableJpaRepositories(basePackages = {"br.mil.defesa.sisgeodef.repository"})
//@EntityScan( basePackages = {"br.mil.defesa.sisgeodef.model"} )
@EnableDiscoveryClient
public class AtlasApplication extends SpringBootServletInitializer {


    @Bean
    public RequestContextListener requestContextListener() {
        return new RequestContextListener();
    }

    public static void main(String[] args) {
        SpringApplication.run(AtlasApplication.class, args);
    }
    

    
}
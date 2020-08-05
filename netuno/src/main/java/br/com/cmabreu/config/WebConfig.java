package br.com.cmabreu.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@EnableWebMvc
@ComponentScan( basePackages="br.com.cmabreu.*")
public class WebConfig implements WebMvcConfigurer {


	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		registry.jsp("/WEB-INF/", ".jsp");
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/resources/**").addResourceLocations("resources/");
		registry.addResourceHandler("/photos/**").addResourceLocations("fotos/");
	}	  

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		//
	}	


	@Bean(name = "multipartResolver")
	public MultipartResolver multipartResolver(){
		return new StandardServletMultipartResolver();
	}

}
package br.com.cmabreu.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@Configuration
public class LoginSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	DataSource dataSource;	
	
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
    	auth.jdbcAuthentication().dataSource( dataSource )
    		.passwordEncoder( new BCryptPasswordEncoder(16) )
    		.usersByUsernameQuery(
    			"select user_name as username,password,enabled from users where user_name=?")
    		.authoritiesByUsernameQuery(
    			"select user_name as username, role_name from users_roles ur join users u on ur.user_id = u.user_id and u.user_name = ?");
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
		.csrf().disable()
		.authorizeRequests()
		.antMatchers("/login*").anonymous()
		.antMatchers("/newUserAnonimous").anonymous()
		.antMatchers("/useranonimous/**").anonymous()
		.antMatchers("/photos/**").permitAll()
		.antMatchers("/resources/**").permitAll()
		.antMatchers("/actuator/**").permitAll()
		.antMatchers("/users/**").permitAll()//.access("hasRole('ROLE_ADMIN')")
		.antMatchers("/logs/**").permitAll()//.access("hasRole('ROLE_ADMIN')")
		.antMatchers("/user/**").access("hasRole('ROLE_ADMIN')")
		.antMatchers("/tokens/**").permitAll()//.access("hasRole('ROLE_ADMIN')")
		.antMatchers("/clients/**").permitAll()//.access("hasRole('ROLE_ADMIN')")
		
		.anyRequest().authenticated()
		.and()
          
		.formLogin()
		.loginPage("/loginPage")
		.defaultSuccessUrl("/index", true)
		.failureUrl("/loginPageError")
		.loginProcessingUrl("/login")
		.usernameParameter("username")
		.passwordParameter("password")
		.and()
		
		.logout()
		.logoutSuccessUrl( "/loginPage" )
		.invalidateHttpSession(true); 
        
    }    

    
}

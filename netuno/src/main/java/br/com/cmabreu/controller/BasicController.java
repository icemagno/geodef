package br.com.cmabreu.controller;

import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;

import br.com.cmabreu.dto.UserLesserDTO;
import br.com.cmabreu.misc.Constants;
import br.com.cmabreu.model.User;
import br.com.cmabreu.repository.UserRepository;

public class BasicController {

    @Autowired
    UserRepository userRepository;  	
	
	@Value("${terena.midas.location}")
	private String midasLocation;   
	
	public String getMidasLocation() {
		return this.midasLocation;
	}
    
	public UserLesserDTO whoami() {
		org.springframework.security.core.userdetails.User userDetail = 
				(org.springframework.security.core.userdetails.User)SecurityContextHolder
					.getContext()
					.getAuthentication()
					.getPrincipal();
		
		String userName = userDetail.getUsername();
		Optional<User> tempUser = userRepository.findByName(userName);
		if( tempUser.isPresent() ) {
			return new UserLesserDTO( tempUser.get() );
		}
	    return null;
	    
	}	
		
	
	public UserLesserDTO getLoggedUser( HttpSession session ) {
		UserLesserDTO user = (UserLesserDTO)session.getAttribute( Constants.USEROBJECT ); 
		if( user == null ) {
			user = whoami( );
			session.setAttribute( Constants.USEROBJECT, user );
		} else {
			//
		}
		return user;
	}	
	
}

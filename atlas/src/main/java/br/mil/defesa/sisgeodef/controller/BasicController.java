package br.mil.defesa.sisgeodef.controller;

import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;

import br.mil.defesa.sisgeodef.dto.UserLesserDTO;
import br.mil.defesa.sisgeodef.misc.Constants;
import br.mil.defesa.sisgeodef.model.User;
import br.mil.defesa.sisgeodef.repository.UserRepository;

public class BasicController {
    @Autowired
    UserRepository userRepository;  
    
	@Value("${terena.midas.location}")
	private String midasLocation;   
	
	public String getMidasLocation() {
		return midasLocation;
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
		
	/*  https://www.baeldung.com/get-user-in-spring-security
	 * 
	 *  Authentication authentication
	 * 
	 */
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

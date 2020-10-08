package br.mil.defesa.sisgeodef.controller;

import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import br.mil.defesa.sisgeodef.dto.UserLesserDTO;
import br.mil.defesa.sisgeodef.misc.ConfigModel;
import br.mil.defesa.sisgeodef.misc.Constants;
import br.mil.defesa.sisgeodef.model.User;
import br.mil.defesa.sisgeodef.repository.UserRepository;

@Controller
@RefreshScope
public class ConfigController {

    @Autowired
    UserRepository userRepository;  	
	
	@Value("${terena.midas.location}")
	private String midasLocation;   
	
	@Value("${sisgeodef.hostAddress}")
	private String sisgeodefHost;   

	@Value("${sisgeodef.useGateKeeper}")
	private Boolean useGateKeeper;   

	@Value("${openstreetmap.wms.url}")
	private String osmServer;   

	@Value("${openstreetmap.wms.baseLayer}")
	private String osmLayer;   

	@Value("${openstreetmap.tileserver}")
	private String osmTileServer;
	
	@Value("${openstreetmap.useExternalOsm}")
	private Boolean useExternalOsm;  
	
	@RequestMapping("/config")
	public @ResponseBody ConfigModel getConfig( HttpSession session ) {
		ConfigModel cm = new ConfigModel();
		cm.setOsmServer( osmServer );
		cm.setOsmLayer( osmLayer );
		cm.setSisgeodefHost( sisgeodefHost );
		cm.setOsmTileServer( osmTileServer );
		cm.setUseExternalOsm( useExternalOsm );
		cm.setUser( getLoggedUser( session ) );
		cm.setUseGateKeeper(useGateKeeper);
		return cm;		
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
	
	
}

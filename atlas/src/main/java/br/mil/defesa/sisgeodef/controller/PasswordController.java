package br.mil.defesa.sisgeodef.controller;

import java.net.URLDecoder;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.mil.defesa.sisgeodef.dto.UserDTO;
import br.mil.defesa.sisgeodef.misc.PasswordGenerator;
import br.mil.defesa.sisgeodef.misc.PasswordQuality;
import br.mil.defesa.sisgeodef.model.PasswordHistory;
import br.mil.defesa.sisgeodef.model.User;
import br.mil.defesa.sisgeodef.repository.PasswordRepository;
import br.mil.defesa.sisgeodef.repository.UserRepository;
import br.mil.defesa.sisgeodef.services.MailService;
import br.mil.defesa.sisgeodef.services.PasswordService;

@Controller
public class PasswordController extends BasicController {

	@Autowired
	private MailService mailer;	
	
	@Autowired
	private PasswordService passwordService;
	
    @Autowired
    PasswordRepository passwordRepository;  	
    
    @Autowired
    private UserRepository userRepository;  
    
	
	@RequestMapping(value = "/getPasswordScore", method = RequestMethod.GET) 
	public @ResponseBody PasswordQuality getPasswordScore( @RequestParam("password") String password ) {
		PasswordQuality score = null;
		try {
			score = passwordService.getScore( URLDecoder.decode(password, "UTF-8") );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return score;
	}	
	

	@RequestMapping(value = "/resetpassword", method = RequestMethod.GET)
	public String resetPassword( Model model, HttpSession session ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		return "resetPassword";
	}	
	
	@RequestMapping(value = "/resetpwd", method = RequestMethod.POST)
	public String resetPwd( Model model, HttpSession session, @RequestParam("username") String username, @RequestParam("cpf") String cpf ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		
		List<User> users = userRepository.findAllByCpfAndEmail(cpf, username);
		if( users.size() == 0 ) {
			model.addAttribute( "error", "Usuário inexistente" );
			return "loginPage";
		} else {
			try {
				User user = users.get( 0 );
				UserDTO userDto = new UserDTO( user );
				String newPassword = PasswordGenerator.generateRandomPassword( 10 );
				
				System.out.println( user.getCpf() + " -> " + newPassword );
				
				Optional<User> tempUser = userRepository.findById( user.getId() );
				if ( tempUser.isPresent() ) {
					User userOld = tempUser.get();

					userOld.setMustchange( true );
					userOld.setTempPassword( newPassword );
					
					BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(16);
					userOld.setPassword( encoder.encode( newPassword ) );
					
					
					userRepository.save( userOld );

					mailer.sendPasswordReset( userDto, newPassword );
					model.addAttribute( "error", "Uma senha temporária foi enviada para seu e-mail. Caso tenha perdido acesso ao email " + userOld.getEmail() + " favor entrar em contato com o administrador do sistema." );
					
				}
				
				
			} catch ( Exception e ) {
				model.addAttribute( "error", "Erro ao redefinir a senha." );
				e.printStackTrace();
			}
			
		}
		
		return "loginPage";
	}	
	
	
	@RequestMapping(value = "/generateSamples", method = RequestMethod.GET)
	public void generateSamplePasswords() {
		String password = "SENHA_";
		for( int x=0; x < 5; x++  ) {
			String novaSenha = password + String.valueOf( x );
			
			BCryptPasswordEncoder enc = new BCryptPasswordEncoder(5);
			
			PasswordHistory ph = new PasswordHistory();
			ph.setPassword( enc.encode(novaSenha) );
			ph.setUserId( 1l );
			
			passwordRepository.save( ph );
		}
	}
	
	
	
	@RequestMapping(value = "/checkpassword", method = RequestMethod.GET) 
	public @ResponseBody String checkPassword( @RequestParam("plainPassword") String plainPassword, @RequestParam("userId") Long userId ) {
		
		BCryptPasswordEncoder enc = new BCryptPasswordEncoder(16);
		
		List<PasswordHistory> lastPasswords = passwordRepository.findAllByUserId(userId);
		for( PasswordHistory ph : lastPasswords  ) {
			if( enc.matches( plainPassword, ph.getPassword() ) ) {
				return "NO";
			}
		}
		
		return "YES";
	}	
	
	
}

package br.mil.defesa.sisgeodef.controller;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.mil.defesa.sisgeodef.dto.AccessLogDTO;
import br.mil.defesa.sisgeodef.dto.UserDTO;
import br.mil.defesa.sisgeodef.dto.UserLesserDTO;
import br.mil.defesa.sisgeodef.dto.UserListDTO;
import br.mil.defesa.sisgeodef.dto.UserRolesDTO;
import br.mil.defesa.sisgeodef.misc.AccessType;
import br.mil.defesa.sisgeodef.misc.StandardReturn;
import br.mil.defesa.sisgeodef.model.AccessLog;
import br.mil.defesa.sisgeodef.model.User;
import br.mil.defesa.sisgeodef.model.UserRoles;
import br.mil.defesa.sisgeodef.repository.AccessLogRepository;
import br.mil.defesa.sisgeodef.repository.UserRepository;
import br.mil.defesa.sisgeodef.services.MailService;

@Controller
public class UserController extends BasicController {
	private static final Logger log = LoggerFactory.getLogger( UserController.class ); 
	
	@Autowired
	private MailService mailer;
	
    @Autowired
    private UserRepository userRepository;  
	
    @Autowired
    private AccessLogRepository accessLogRepository;	


	@RequestMapping(value = "/userbyname", method = RequestMethod.GET)
	public @ResponseBody String userByName(  @RequestParam(value = "loginName", required = true) String loginName , Model model, HttpSession session ) {
		String result = "NO";
		Optional<User> tempUser = userRepository.findByName( loginName );
		if ( tempUser.isPresent() ) {
			result = "YES";
		}		
		return result;
	}		
    
	@RequestMapping(value = "/userbycpf", method = RequestMethod.GET)
	public @ResponseBody String userByCpf(  @RequestParam(value = "cpf", required = true) String cpf , Model model, HttpSession session ) {
		String result = "NO";
		List<User> tempUser = userRepository.findAllByCpf( cpf );
		if ( tempUser.size() > 0 ) {
			result = "YES";
		}		
		return result;
	}		
    
	@RequestMapping(value = "/users", method = RequestMethod.GET)
	public String users( Model model, HttpSession session ) {
		model.addAttribute( "user", getLoggedUser( session ) );
		model.addAttribute( "midasLocation", getMidasLocation() );
		return "users";
	}		

    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
	public String userProfile( @PathVariable("id") long userId, Model model, HttpSession session, HttpServletRequest request ) {
    	
    	UserLesserDTO myself = getLoggedUser( session );
		model.addAttribute( "user", myself );
		model.addAttribute( "midasLocation", getMidasLocation() );
    	
		UserLesserDTO user = null;
		Optional<User> tempUser = userRepository.findById( new Long(userId) );
		if ( tempUser.isPresent() ) {
			user = new UserLesserDTO( tempUser.get() );

		
	    	if( ( myself.getId() != userId ) && !myself.isAdmin() ) {
	        	model.addAttribute( "error", "Você não possui permissão para esta ação.");
	    		log( request, myself, "Tentou acessar o registro do usuário " + user.getName() + " (" + user.getFullName() + ")." );
	    		return "index";
	    	}
			
			model.addAttribute( "referenceUser", user );
			return "user";
		} 
		
		model.addAttribute( "error", "Usuário inexistente.");
		return "index";
	}		


	@RequestMapping(value = "/newUserAnonimous", method = RequestMethod.GET)
	public String newUserAnonimousPage( Model model, HttpSession session ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		model.addAttribute( "referenceUser", new UserLesserDTO() );
		return "newUserAnonimous";
	}	
	
	
	@RequestMapping(value = "/newUser", method = RequestMethod.GET)
	public String newUserPage( Model model, HttpSession session ) {
		model.addAttribute( "user", getLoggedUser( session ) );
		model.addAttribute( "midasLocation", getMidasLocation() );
		
		UserLesserDTO newUser = new UserLesserDTO();
		newUser.setEnabled( false );
		
		model.addAttribute( "referenceUser", newUser );
		return "newUser";
	}		
	
	
	@RequestMapping(value = "/userlist", method = RequestMethod.GET, produces = "application/json")
	public @ResponseBody UserListDTO listUsers() {
		UserListDTO uld = new UserListDTO();
		List<User> users = userRepository.findAll();
		for( User usr : users ) {
			uld.addUser( new UserLesserDTO( usr) );
		}
		return uld;
	}	

	

	@RequestMapping(value = "/edituser", method = RequestMethod.POST)
	public String updateUser(
			/*@RequestParam("profileImageFile") MultipartFile file, */Model model, HttpSession session,  
			@RequestParam("method") String method, 
			@ModelAttribute("referenceUser") UserDTO user, 
			@RequestParam("password") String password,
			@RequestParam("password2") String password2,
			@RequestParam(name="userRoles", required=false) Set<String> roles,
			HttpServletRequest request) {

		UserLesserDTO me = getLoggedUser( session );
		
		try {

			user.setEnabled( true );
			
			if ( (password != null) && !password.equals("") && password.equals( password2 ) ) {
				BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(16);
				user.setPassword( encoder.encode( password ) );
			} 
			
			// A foto
			/*
			if ( !file.isEmpty() ) {

				String realPathtoUploads = "/fotos/";
				File dir = new File( realPathtoUploads );
				if ( !dir.exists() ) {
					dir.mkdirs();
				}
				String orgName = UUID.randomUUID().toString().replaceAll("-", "") + "." + FilenameUtils.getExtension( file.getOriginalFilename() );
				String filePath = realPathtoUploads + orgName;
				File dest = new File(filePath);
				FileUtils.writeByteArrayToFile( dest, file.getBytes() );
				user.setProfileImage( orgName );
			}
			*/

			
			
			if( roles != null ) {
				user.getRoles().clear();
				for( String roleName : roles ) {
					UserRolesDTO urdto = new UserRolesDTO( roleName );
					user.getRoles().add( urdto );
				}
			}

			// Gravar
			UserLesserDTO udto = null;
				
			// method = edit
			if( user.getId() != null ) {
				
				Optional<User> tempUser = userRepository.findById( user.getId() );
				if ( tempUser.isPresent() ) {
					User userOld = tempUser.get();
					userOld.setFullName( user.getFullName() );
					userOld.setFuncao( user.getFuncao() );
					userOld.setOrigem( user.getOrigem() );
					userOld.setEmail( user.getEmail() );
					userOld.setEnabled( user.isEnabled() );
					
					// se estiver editando entao o username vem nulo da interface pq o campo esta disabled
					user.setName( userOld.getName() );
					
					if ( (password != null) && !password.equals("") ) {
						userOld.setPassword( user.getPassword() );
					}

					userOld.setProfileImage("nophoto.png");
					
					/*
					if ( !file.isEmpty() ) {
						userOld.setProfileImage( user.getProfileImage() );
					}
					*/
					
					if( roles != null ) {
						userOld.getRoles().clear();
						for ( UserRolesDTO role : user.getRoles() ) {
							UserRoles ur = new UserRoles( role.getRoleName() );
							ur.setUser(userOld);
							userOld.getRoles().add( ur );
						}
					}
					
					userOld.setSetor( user.getSetor() );
					userOld.setTelefone( user.getTelefone() );
					
					userRepository.save( userOld );
					
					log( request, me, "Editou usuário " + user.getName() + " (" + user.getFullName() + ")" );
					mailer.sendConfirmacaoModificacao( new UserLesserDTO( user ), me );
					
				} else {
					throw new Exception("Usuário ID " + user.getId() + " não foi encontrado.");
				}
				
			} else {
				// method = Create
				User userNew = new User( user );
				
				userNew.setMustchange( false );
				userNew.setTempPassword("");
				
				log.info( "Criação do usuário " + user.getName()  );
				udto = new UserLesserDTO( userRepository.save( userNew ) );
				model.addAttribute( "userToCreate", udto );
				log( request, me, "Criação do usuário " + user.getName() + " (" + user.getFullName() + ")" );
				
				mailer.sendConfirmacaoCadastro( new UserLesserDTO( user ), me  );
			}
				
			
		} catch ( Exception e ) {
			log.error( e.getMessage() );
			//model.addAttribute( "referenceUser", new UserLesserDTO( user ) );
			model.addAttribute( "error", "Erro ao efetuar operação: '" + e.getMessage() + "'" );

		}
		
		model.addAttribute( "user", me );
		model.addAttribute( "midasLocation", getMidasLocation() );
		
		if( user.getId() != null ) {
			return "redirect:/user/" + user.getId();
		} else {
			return "redirect:/users";
		}
		
	}	


	/*
	@RequestMapping(value = "/photos/{imageId:.+}", method = RequestMethod.GET, produces = {MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_GIF_VALUE} )
	public @ResponseBody ResponseEntity<byte[]> getImage( @PathVariable String imageId, HttpServletRequest servletRequest )  {
		try {
			String sourceFolder = "/fotos";
			String requestedImage = sourceFolder + "/" + imageId;
			String noPhotoImage = sourceFolder + "/nophoto.png";

			File file = new File( requestedImage );
			if( !file.exists() ) {
				//log.warn("Usuario nao possui foto. Usando a foto padrao.");
				file = new File( noPhotoImage );
			}

			HttpHeaders headers = new HttpHeaders();
			InputStream in = new FileInputStream( file );

			headers.setCacheControl( CacheControl.noCache().getHeaderValue() );
			byte[] media = IOUtils.toByteArray(in);
			ResponseEntity<byte[]> responseEntity = new ResponseEntity<>(media, headers, HttpStatus.OK);
			return responseEntity;			

		} catch ( Exception e ) {
			//log.error("Erro ao recuperar a foto: " + e.getMessage() );
			return null;
		}
	}	
	*/

	@RequestMapping(value = "/user/{id}", method = RequestMethod.DELETE, produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody StandardReturn deleteUser(@PathVariable("id") long id, HttpSession session, HttpServletRequest request ) {
		
		UserLesserDTO me = getLoggedUser( session );
		if ( me.getId() == id ) {
			return new StandardReturn("error","Você não pode apagar seu próprio usuário. Solicite a outro administrador que o faça.");
		}
		
		Optional<User> tempUser = userRepository.findById( id );
		if( !tempUser.isPresent() ) {
			return new StandardReturn("error", "Não foi possível encontrar um usuário com este identificador." );
		}
		
		User checkUser = tempUser.get();
		
		try {
			userRepository.deleteById(id);
		} catch ( Exception e ) {
			return new StandardReturn("error", "Erro ao remover usuário '" + checkUser.getFullName() + "': '" + e.getMessage() + "'." );
		}
		
		log( request, me, "Apagou o usuário " + checkUser.getName() + " (" + checkUser.getFullName() + ") do banco de dados." );
		
		return new StandardReturn("success","Usuário '" + checkUser.getFullName() + "' removido.");
	}

	
	private void log(HttpServletRequest request, UserLesserDTO me, String logString ) {
		AccessLogDTO rld = new AccessLogDTO( request );
		rld.setRequestUrl( logString );
		rld.setRemoteUser( me.getUsername() );
		rld.setRemoteUserId( me.getId() );
		rld.setRemoteUserName( me.getFullName() );
		rld.setProfileImage( me.getProfileImage() );
		rld.setAccessType( AccessType.USER );
		AccessLog al = new AccessLog( rld );
		accessLogRepository.save( al );			
	}

}

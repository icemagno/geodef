package br.mil.defesa.sisgeodef.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import br.mil.defesa.sisgeodef.misc.UserRole;
import br.mil.defesa.sisgeodef.model.User;
import br.mil.defesa.sisgeodef.model.UserRoles;
import br.mil.defesa.sisgeodef.model.UsersClients;

public class UserLesserDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String username;
	private String name;
	private String fullName;
	private Boolean enabled;
    private List<UserRolesDTO> roles;
    private String profileImage;
	private String funcao;
	private String setor;	
	private String telefone;	
	private String origem;		
	private String email;		
	private String cpf;	
	private List<UsersClientsDTO> clients;	

    public UserLesserDTO() {
    	this.roles = new ArrayList<UserRolesDTO>();
    	this.enabled = true;
    	this.profileImage = "nophoto.png";
    	this.clients = new ArrayList<UsersClientsDTO>();
    }
    
    public UserLesserDTO( User user ) {
    	this.clients = new ArrayList<UsersClientsDTO>();
    	this.funcao = user.getFuncao();
    	this.setor = user.getSetor();
    	this.name = user.getName();
    	this.telefone = user.getTelefone();
    	this.origem = user.getOrigem();
    	this.id = user.getId();
    	this.username = user.getUsername();
    	this.enabled = user.isEnabled();
		this.roles = new ArrayList<UserRolesDTO>();
		this.profileImage = user.getProfileImage();
		this.fullName = user.getFullName();
		this.cpf = user.getCpf();
		this.email = user.getEmail();
		
		for( UsersClients cli : user.getClients()  ) {
			this.clients.add( new UsersClientsDTO( cli ) );
		}
		
		
		for( UserRoles ur : user.getRoles() ) {
			this.roles.add( new UserRolesDTO( ur ) );
		}
		
	}
    
    public UserLesserDTO(UserDTO user) {
    	this.funcao = user.getFuncao();
    	this.setor = user.getSetor();
    	this.telefone = user.getTelefone();
    	this.origem = user.getOrigem();
    	this.id = user.getId();
    	this.name = user.getName();
    	this.username = user.getUsername();
    	this.enabled = user.isEnabled();
		this.roles = new ArrayList<UserRolesDTO>();
		this.profileImage = user.getProfileImage();
		this.fullName = user.getFullName();
		this.cpf = user.getCpf();
		this.email = user.getEmail();
		
		this.roles = user.getRoles();
		
	}

	public boolean isAdmin() {
    	for ( UserRolesDTO roles : getRoles() ) {
    		if ( roles.getRoleName().equals( UserRole.ROLE_ADMIN ) ) return true;
    	}
    	return false;
    }
    
	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public List<UserRolesDTO> getRoles() {
		return roles;
	}

	public void setNodes(List<UserRolesDTO> roles) {
		this.roles = roles;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getFuncao() {
		return funcao;
	}

	public void setFuncao(String funcao) {
		this.funcao = funcao;
	}

	public String getSetor() {
		return setor;
	}

	public void setSetor(String setor) {
		this.setor = setor;
	}

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}

	public String getOrigem() {
		return origem;
	}

	public void setOrigem(String origem) {
		this.origem = origem;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public void setRoles(List<UserRolesDTO> roles) {
		this.roles = roles;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getName() {
		return this.name;

	}
	
	public void setName(String name) {
		this.name = name;
	}

	public List<UsersClientsDTO> getClients() {
		return clients;
	}

	public void setClients(List<UsersClientsDTO> clients) {
		this.clients = clients;
	}
	
	
}

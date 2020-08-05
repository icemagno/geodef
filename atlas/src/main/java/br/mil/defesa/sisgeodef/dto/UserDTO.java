package br.mil.defesa.sisgeodef.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import br.mil.defesa.sisgeodef.misc.UserRole;
import br.mil.defesa.sisgeodef.model.User;
import br.mil.defesa.sisgeodef.model.UserRoles;
import br.mil.defesa.sisgeodef.model.UsersClients;


public class UserDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String name;
	private String fullName;
	private String password;
	private boolean enabled;
    private List<UserRolesDTO> roles;
    private String profileImage;
	private String funcao;
	private String setor;	
	private String telefone;	
	private String origem;		
	private String email;	
	private String cpf;	
	private String tempPassword;
	private boolean mustchange;	
	private List<UsersClientsDTO> clients;
	
    public UserDTO() {
    	this.roles = new ArrayList<UserRolesDTO>(); 
    	this.clients = new ArrayList<UsersClientsDTO>();
	}
    
    public UserDTO( User user ) {
    	this();
    	this.mustchange = user.isMustchange();
    	this.tempPassword = user.getTempPassword();
    	this.funcao = user.getFuncao();
    	this.setor = user.getSetor();
    	this.telefone = user.getTelefone();
    	this.origem = user.getOrigem();
    	this.id = user.getId();
    	this.email = user.getEmail();
    	this.cpf = user.getCpf();
    	this.name = user.getName();
    	this.password = user.getPassword();
    	this.enabled = user.isEnabled();
		this.roles = new ArrayList<UserRolesDTO>();
		this.profileImage = user.getProfileImage();
		this.fullName = user.getFullName();
		for( UserRoles ur : user.getRoles() ) {
			this.roles.add( new UserRolesDTO( ur) );
		}
		for( UsersClients cli : user.getClients()  ) {
			this.clients.add( new UsersClientsDTO( cli ) );
		}		
	}
    
    public boolean isAdmin() {
    	for ( UserRolesDTO roles : getRoles() ) {
    		if ( roles.getRoleName().equals( UserRole.ROLE_ADMIN ) ) return true;
    	}
    	return false;
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
	
    public String getName() {
    	return this.name;
    }

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
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

	public String getUsername() {
		return this.name;

	}

	public List<UsersClientsDTO> getClients() {
		return clients;
	}

	public void setClients(List<UsersClientsDTO> clients) {
		this.clients = clients;
	}

	public String getTempPassword() {
		return tempPassword;
	}

	public void setTempPassword(String tempPassword) {
		this.tempPassword = tempPassword;
	}

	public boolean isMustchange() {
		return mustchange;
	}

	public void setMustchange(boolean mustchange) {
		this.mustchange = mustchange;
	}
	
}

package br.mil.defesa.sisgeodef.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Cascade;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import br.mil.defesa.sisgeodef.dto.UserDTO;
import br.mil.defesa.sisgeodef.dto.UserRolesDTO;
import br.mil.defesa.sisgeodef.misc.UserRole;


@Entity
@Table(name = "users")
public class User implements UserDetails {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_id", nullable = false, updatable = false)
	private Long id;
	
	@Column(name = "user_name", length = 100, nullable = false, unique = true)
	private String name;

	@Column(name = "profile_image", nullable = false)
	private String profileImage;
	
	@Column(name = "full_name", length = 200, nullable = false)
	private String fullName;	
	
	@Column( length = 100, nullable = false )
	private String password;

	@Column( name = "temp_password", length = 100 )
	private String tempPassword;
	
	@Column( name = "mustchange", nullable = true )
	private boolean mustchange;

	@Column( nullable = false )
	private boolean enabled;
	
	@Column(length = 100)
	private String funcao;	

	@Column(length = 100)
	private String setor;	

	@Column(length = 100)
	private String email;	
	
	@Column(length = 14)
	private String cpf;	

	@Column(length = 20)
	private String telefone;	
	
	@Column(length = 200)
	private String origem;	
	
    @OneToMany(orphanRemoval=true, fetch = FetchType.EAGER)
    @JoinColumn(name ="user_id")
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    private List<UserRoles> roles;
    
    @OneToMany(
       mappedBy = "user",
       cascade = CascadeType.ALL,
       orphanRemoval = true
	)
	private List<UsersClients> clients = new ArrayList<UsersClients>();	
    
    public User() {
		super();
		this.roles = new ArrayList<UserRoles>();
	}
    
    @Transient
    public boolean isAdmin() {
    	for ( UserRoles roles : getRoles() ) {
    		if ( roles.getRoleName().equals( UserRole.ROLE_ADMIN ) ) return true;
    	}
    	return false;
    }
    
    public User( UserDTO user ) {
    	this.id = null;
    	this.mustchange = user.isMustchange();
    	this.tempPassword = user.getTempPassword();
    	this.name = user.getName();
    	this.password = user.getPassword();
    	this.enabled = user.isEnabled();
		this.roles = new ArrayList<UserRoles>();
		this.profileImage = user.getProfileImage();
		this.fullName = user.getFullName();
		this.email = user.getEmail();
		this.cpf = user.getCpf();
		this.origem = user.getOrigem();
		this.telefone = user.getTelefone();
		this.setor = user.getSetor();
		this.funcao = user.getFuncao();		
		for( UserRolesDTO ur : user.getRoles() ) {
			UserRoles roles = new UserRoles( ur );
			roles.setUser( this );
			this.roles.add( roles );
		}
	}      
    
	public List<UserRoles> getRoles() {
		return roles;
	}

	public void setRoles(List<UserRoles> roles) {
		this.roles = roles;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return false;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	@Override
	public String getUsername() {
		return name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getOrigem() {
		return origem;
	}

	public void setOrigem(String origem) {
		this.origem = origem;
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

	public List<UsersClients> getClients() {
		return clients;
	}

	public void setClients(List<UsersClients> clients) {
		this.clients = clients;
	}


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
 
        if (o == null || getClass() != o.getClass())
            return false;
 
        User user = (User) o;
        return Objects.equals(name, user.name);
    }
 
    @Override
    public int hashCode() {
        return Objects.hash(name);
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

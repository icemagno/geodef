package br.com.cmabreu.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;

import br.com.cmabreu.dto.UserRolesDTO;

@Entity
@Table(name = "users_roles")
public class UserRoles implements GrantedAuthority {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "user_role_id", nullable = false, updatable = false)
	private Long id;

	@Column(name = "role_name", nullable = false)
	private String roleName;	
	
	@ManyToOne()
	@JoinColumn(name="user_id", foreignKey = @ForeignKey(name = "fk_datalayer_server"))
	private User user;

	public UserRoles() {
		super();
	}

	public UserRoles( String roleName ) {
		super();
		this.roleName = roleName;
	}
	
	
	public UserRoles( UserRolesDTO role ) {
		this.id = role.getId();
		this.roleName = role.getRoleName();
	}	
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String getAuthority() {
		return this.getRoleName();
	}		
	
}

package br.mil.defesa.sisgeodef.dto;

import java.io.Serializable;

import br.mil.defesa.sisgeodef.model.UserRoles;

public class UserRolesDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Long id;
	private String roleName;	

	public UserRolesDTO() {
		// 
	}

	public UserRolesDTO( String roleName ) {
		this.roleName = roleName;
	}	
	
	public UserRolesDTO( UserRoles role ) {
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

	
}

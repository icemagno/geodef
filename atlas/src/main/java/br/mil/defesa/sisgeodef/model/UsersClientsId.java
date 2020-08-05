package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class UsersClientsId implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Column(name = "client_id")
	private String clientId;
	
	@Column(name = "user_id")
	private Long userId;

	public UsersClientsId() { }
	
	
	public UsersClientsId( String clientId, Long userId ) {
		this.clientId = clientId;
		this.userId = userId;
	}
	
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UsersClientsId that = (UsersClientsId) o;
        return Objects.equals(clientId, that.clientId) &&  Objects.equals(userId, that.userId);
    }	
	
    @Override
    public int hashCode() {
        return Objects.hash(userId, clientId);
    }


	public String getClientId() {
		return clientId;
	}


	public void setClientId(String clientId) {
		this.clientId = clientId;
	}


	public Long getUserId() {
		return userId;
	}


	public void setUserId(Long userId) {
		this.userId = userId;
	}	
    
    
	
}

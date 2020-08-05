package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "users_clients")
public class UsersClients implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	UsersClientsId id;
	
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("clientId")
    private OAuthClientDetails client;
 
    @ManyToOne(fetch = FetchType.LAZY)
    @MapsId("userId")
    private User user;	
	
    @Column( name="dt_inicial" )
    private Date dtInicial;

    @Column( name="dt_alteracao" )
    private Date dtAlteracao;
    
    @Column( name="dt_final" )
    private Date dtFinal;
    
    @Column(name = "sysadmin")
    private Boolean sysAdmin;

    @Column(name = "respalteracao")
    private String respAlteracao;

    @Column(name = "tipoalteracao")
    private String tipoAlteracao;

	public UsersClientsId getId() {
		return id;
	}

	public void setId(UsersClientsId id) {
		this.id = id;
	}

	public OAuthClientDetails getClient() {
		return client;
	}

	public void setClient(OAuthClientDetails client) {
		this.client = client;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}


	public Date getDtInicial() {
		return dtInicial;
	}

	public void setDtInicial(Date dtInicial) {
		this.dtInicial = dtInicial;
	}

	public Date getDtFinal() {
		return dtFinal;
	}

	public void setDtFinal(Date dtFinal) {
		this.dtFinal = dtFinal;
	}

	public Boolean getSysAdmin() {
		return sysAdmin;
	}

	public void setSysAdmin(Boolean sysAdmin) {
		this.sysAdmin = sysAdmin;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		 
        if (o == null || getClass() != o.getClass())
            return false;
        UsersClients uc = (UsersClients) o;
        return ( Objects.equals( client.getClientId(), uc.getClient().getClientId() ) && Objects.equals( user.getId(), uc.getUser().getId() ) );
        
	}
	
	@Override
	public int hashCode() {
        return Objects.hash(client, user);
	}

	public Date getDtAlteracao() {
		return dtAlteracao;
	}

	public void setDtAlteracao(Date dtAlteracao) {
		this.dtAlteracao = dtAlteracao;
	}

	public String getRespAlteracao() {
		return respAlteracao;
	}

	public void setRespAlteracao(String respAlteracao) {
		this.respAlteracao = respAlteracao;
	}

	public String getTipoAlteracao() {
		return tipoAlteracao;
	}

	public void setTipoAlteracao(String tipoAlteracao) {
		this.tipoAlteracao = tipoAlteracao;
	}
	
    
}

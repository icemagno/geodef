package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "oauth_client_details")
public class OAuthClientDetails implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "client_id", length = 255, nullable = false, unique = true)
	private String clientId;	
	
	@Column(name = "resource_ids", length = 255)
	private String resourceIds;	
	
	@Column(name = "client_secret", length = 255)
	private String clientSecret;	
	
    @OneToMany(
       mappedBy = "client",
       cascade = CascadeType.ALL,
       orphanRemoval = true
	)
    private List<UsersClients> users = new ArrayList<UsersClients>();	
	
	@Column(name = "scope", length = 255)
	private String scope;	
	
	@Column(name = "authorized_grant_types", length = 255)
	private String authorizedGrantTypes;	
	  
	@Column(name = "web_server_redirect_uri", length = 255)
	private String webServerRedirectUri;	
	  
	@Column(name = "authorities", length = 255)
	private String authorities;	
	   
	@Column(name = "access_token_validity")
	private Integer accessTokenValidity;	
	   
	@Column(name = "refresh_token_validity")
	private Integer refreshTokenValidity;	
	   
	@Column(name = "additional_information", columnDefinition="TEXT")
	private String additionalInformation;	
	   
	@Column(name = "autoapprove", length = 50)
	private String autoApprove;

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getResourceIds() {
		return resourceIds;
	}

	public void setResourceIds(String resourceIds) {
		this.resourceIds = resourceIds;
	}

	public String getClientSecret() {
		return clientSecret;
	}

	public void setClientSecret(String clientSecret) {
		this.clientSecret = clientSecret;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}

	public String getAuthorizedGrantTypes() {
		return authorizedGrantTypes;
	}

	public void setAuthorizedGrantTypes(String authorizedGrantTypes) {
		this.authorizedGrantTypes = authorizedGrantTypes;
	}

	public String getWebServerRedirectUri() {
		return webServerRedirectUri;
	}

	public void setWebServerRedirectUri(String webServerRedirectUri) {
		this.webServerRedirectUri = webServerRedirectUri;
	}

	public String getAuthorities() {
		return authorities;
	}

	public void setAuthorities(String authorities) {
		this.authorities = authorities;
	}

	public Integer getAccessTokenValidity() {
		return accessTokenValidity;
	}

	public void setAccessTokenValidity(Integer accessTokenValidity) {
		this.accessTokenValidity = accessTokenValidity;
	}

	public Integer getRefreshTokenValidity() {
		return refreshTokenValidity;
	}

	public void setRefreshTokenValidity(Integer refreshTokenValidity) {
		this.refreshTokenValidity = refreshTokenValidity;
	}

	public String getAdditionalInformation() {
		return additionalInformation;
	}

	public void setAdditionalInformation(String additionalInformation) {
		this.additionalInformation = additionalInformation;
	}

	public String getAutoApprove() {
		return autoApprove;
	}

	public void setAutoApprove(String autoApprove) {
		this.autoApprove = autoApprove;
	}

	public List<UsersClients> getUsers() {
		return users;
	}

	public void setUsers(List<UsersClients> users) {
		this.users = users;
	}	
	
	 @Override
	    public boolean equals(Object o) {
	        if (this == o) return true;
	        if (o == null || getClass() != o.getClass()) return false;
	        OAuthClientDetails oAuth = (OAuthClientDetails) o;
	        return Objects.equals(resourceIds, oAuth.resourceIds);
	    }
	 
	    @Override
	    public int hashCode() {
	        return Objects.hash(resourceIds);
	    }
	
}

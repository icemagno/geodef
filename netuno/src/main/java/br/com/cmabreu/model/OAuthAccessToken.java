package br.com.cmabreu.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "oauth_access_token")
public class OAuthAccessToken {

	@Id
	@Column(name = "authentication_id", length = 255, nullable = false, unique = true)
	private String authenticationId;		
	
	@Column(name = "client_id", length = 255)
	private String clientId;	

	@Column(name = "token_id", length = 255)
	private String tokenId;		
	
	@Column(name = "token")
	private byte[] token;	

	@Column(name = "authentication")
	private byte[] authentication;	

	@Column(name = "user_name", length = 255)
	private String userName;

	@Column(name = "refresh_token", length = 255)
	private String refreshToken;

	public String getAuthenticationId() {
		return authenticationId;
	}

	public void setAuthenticationId(String authenticationId) {
		this.authenticationId = authenticationId;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getTokenId() {
		return tokenId;
	}

	public void setTokenId(String tokenId) {
		this.tokenId = tokenId;
	}

	public byte[] getToken() {
		return token;
	}

	public void setToken(byte[] token) {
		this.token = token;
	}

	public byte[] getAuthentication() {
		return authentication;
	}

	public void setAuthentication(byte[] authentication) {
		this.authentication = authentication;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getRefreshToken() {
		return refreshToken;
	}

	public void setRefreshToken(String refreshToken) {
		this.refreshToken = refreshToken;
	}

	   
	
}

  

package br.com.cmabreu.dto;

import java.io.Serializable;

import com.fasterxml.jackson.databind.ObjectMapper;

import br.com.cmabreu.misc.ClientAdditionalInformation;
import br.com.cmabreu.model.OAuthClientDetails;

public class OAuthClientDetailsLesserDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String clientId;	
	private String resourceIds;	
	private String scope;	
	private String authorizedGrantTypes;	
	private String webServerRedirectUri;	
	private String authorities;	
	private Integer accessTokenValidity;	
	private Integer refreshTokenValidity;	
	private String additionalInformation;	
	private String autoApprove;
	private String clientFullName;
	private String clientImage;
	
	public OAuthClientDetailsLesserDTO( OAuthClientDetails oAuthClientDetails) {
		this.clientId = oAuthClientDetails.getClientId();
		this.resourceIds = oAuthClientDetails.getResourceIds();
		this.scope = oAuthClientDetails.getScope();
		this.authorizedGrantTypes = oAuthClientDetails.getAuthorizedGrantTypes();
		this.webServerRedirectUri = oAuthClientDetails.getWebServerRedirectUri();
		this.authorities = oAuthClientDetails.getAuthorities();
		this.accessTokenValidity = oAuthClientDetails.getAccessTokenValidity();
		this.refreshTokenValidity = oAuthClientDetails.getRefreshTokenValidity();
		this.additionalInformation = oAuthClientDetails.getAdditionalInformation();
		this.autoApprove = oAuthClientDetails.getAutoApprove();
		
		
		ObjectMapper om = new ObjectMapper();
		try {
			ClientAdditionalInformation cai = om.readValue( getAdditionalInformation(), ClientAdditionalInformation.class );
			this.clientFullName = cai.getNome();
			this.clientImage = cai.getLogotipo();
		} catch ( Exception e ) {
			//
		}		
		
		
	}

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

	public String getClientFullName() {
		return clientFullName;
	}

	public void setClientFullName(String clientFullName) {
		this.clientFullName = clientFullName;
	}

	public String getClientImage() {
		return clientImage;
	}

	public void setClientImage(String clientImage) {
		this.clientImage = clientImage;
	}

	
	
	
}

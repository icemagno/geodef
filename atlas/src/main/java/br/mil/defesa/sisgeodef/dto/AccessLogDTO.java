package br.mil.defesa.sisgeodef.dto;


import java.util.Enumeration;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import br.mil.defesa.sisgeodef.misc.AccessType;
import br.mil.defesa.sisgeodef.model.AccessLog;

public class AccessLogDTO {
	private String remoteAddr;
	private String remoteHost;
	private String requestUrl;
	private String queryString;
	private String header;
	private String data;
	private String hora;
	private String method;
	private String remoteUser;
	private Long remoteUserId;
	private String remoteUserName;
	private String profileImage;
	private AccessType accessType;
	
	public AccessLogDTO( AccessLog log ) {
		this.remoteAddr = log.getRemoteAddr();
		this.profileImage = log.getProfileImage();
		this.remoteUserId = log.getRemoteUserId();
		this.remoteUserName = log.getRemoteUserName();
		this.remoteHost = log.getRemoteHost();
		this.requestUrl = log.getRequestUrl();  
		this.queryString = log.getQueryString();	
		this.data = log.data();
		this.hora = log.hora();
		this.header = log.getHeader();
		this.method = log.getMethod();
		this.remoteUser = log.getRemoteUser();
		this.accessType = log.getAccessType();
	}
	
	public AccessLogDTO( ServletRequest req ) {
		HttpServletRequest request = (HttpServletRequest)req;
		
		this.remoteAddr = req.getRemoteAddr();
		this.remoteHost = req.getRemoteHost();
		this.requestUrl = request.getRequestURL().toString();  
		this.queryString = request.getQueryString();
		this.method = request.getMethod();
		this.remoteUser = "";
		this.accessType = AccessType.UNKNOWN;
		this.profileImage = "nophoto.png";
		
		if( request.getUserPrincipal() != null ) {
			this.remoteUser = request.getRemoteUser();

			/*
			if( request.getUserPrincipal() instanceof UsernamePasswordAuthenticationToken ) {
				UsernamePasswordAuthenticationToken principal = (UsernamePasswordAuthenticationToken)request.getUserPrincipal();
				AbstractAuthenticationToken dets = (AbstractAuthenticationToken)principal.getDetails();
			}
			
			if( request.getUserPrincipal() instanceof OAuth2Authentication ) {
				OAuth2Authentication principal = (OAuth2Authentication)request.getUserPrincipal();
				AbstractAuthenticationToken dets = (AbstractAuthenticationToken)principal.getDetails();
			}
			*/			
		}	
		
		
		@SuppressWarnings("rawtypes")
		Enumeration headerNames = request.getHeaderNames();
		StringBuilder sb = new StringBuilder();
        while (headerNames.hasMoreElements()) {
            String key = (String) headerNames.nextElement();
            String value = request.getHeader(key);
            sb.append(key + " : " + value + "</br>");
        }		
        this.header = sb.toString();
		
	}

	public String getRemoteAddr() {
		return remoteAddr;
	}

	public String getRemoteHost() {
		return remoteHost;
	}

	public String getRequestUrl() {
		return requestUrl;
	}

	public String getQueryString() {
		return queryString;
	}

	public String getData() {
		return data;
	}

	public Long getRemoteUserId() {
		return remoteUserId;
	}

	public void setRemoteUserId(Long remoteUserId) {
		this.remoteUserId = remoteUserId;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getHora() {
		return hora;
	}

	public void setHora(String hora) {
		this.hora = hora;
	}

	public void setRemoteAddr(String remoteAddr) {
		this.remoteAddr = remoteAddr;
	}

	public void setRemoteHost(String remoteHost) {
		this.remoteHost = remoteHost;
	}

	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}

	public void setQueryString(String queryString) {
		this.queryString = queryString;
	}

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public String getRemoteUser() {
		return remoteUser;
	}

	public void setRemoteUser(String remoteUser) {
		this.remoteUser = remoteUser;
	}

	public String getRemoteUserName() {
		return remoteUserName;
	}

	public void setRemoteUserName(String remoteUserName) {
		this.remoteUserName = remoteUserName;
	}

	public AccessType getAccessType() {
		return accessType;
	}

	public void setAccessType(AccessType accessType) {
		this.accessType = accessType;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	
}

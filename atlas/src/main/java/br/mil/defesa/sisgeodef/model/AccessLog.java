package br.mil.defesa.sisgeodef.model;


import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import br.mil.defesa.sisgeodef.dto.AccessLogDTO;
import br.mil.defesa.sisgeodef.misc.AccessType;


@Entity
@Table(name = "access_log")
public class AccessLog {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "log_id", nullable = false, updatable = false)
	private Long id;	
	
	@Column(name = "remoteaddr", length = 50)
	private String remoteAddr;
	
	@Column(name = "remotehost", length = 50)
	private String remoteHost;
	
	@Column(name = "requesturl", length = 255)
	private String requestUrl;
	
	@Column(name = "querystring", length = 255)
	private String queryString;
	
	@Column(name = "remoteuser", length = 100)
	private String remoteUser;

	@Column(name = "profileimage", length = 100)
	private String profileImage;
	
	@Column(name = "method", length = 20)
	private String method;
	
	@Column
	@Enumerated(EnumType.STRING)
	private AccessType accessType;
	
	@Column(name = "header", columnDefinition="TEXT")
	private String header;
	
	@Column(name = "remoteuserid")
	private Long remoteUserId;
	
	@Column(name = "remoteusername")
	private String remoteUserName; 
	
	@Column(name = "date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date date;

	public AccessLog() {
		// 
	}
	
	@Transient
	public String data() {
		SimpleDateFormat formato = new SimpleDateFormat( "dd/MM/yyyy" );
		return formato.format( this.date );
	}

	@Transient
	public String hora() {
		SimpleDateFormat formato = new SimpleDateFormat( "HH:mm:ss" );
		return formato.format( this.date );
	}
	
	public AccessLog( AccessLogDTO accessLogDTO ) {
		this.date = new java.util.Date();
		this.remoteAddr = accessLogDTO.getRemoteAddr();
		this.profileImage = accessLogDTO.getProfileImage();
		this.remoteHost = accessLogDTO.getRemoteHost();
		this.requestUrl = accessLogDTO.getRequestUrl();  
		this.queryString = accessLogDTO.getQueryString();
		this.header = accessLogDTO.getHeader();
		this.method = accessLogDTO.getMethod();
		this.remoteUser = accessLogDTO.getRemoteUser();
		this.remoteUserId = accessLogDTO.getRemoteUserId();
		this.remoteUserName = accessLogDTO.getRemoteUserName();
		this.accessType = accessLogDTO.getAccessType();
	}
	
	public String getRemoteAddr() {
		return remoteAddr;
	}

	public void setRemoteAddr(String remoteAddr) {
		this.remoteAddr = remoteAddr;
	}

	public String getRemoteHost() {
		return remoteHost;
	}

	public void setRemoteHost(String remoteHost) {
		this.remoteHost = remoteHost;
	}

	public String getRequestUrl() {
		return requestUrl;
	}

	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}

	public String getQueryString() {
		return queryString;
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

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getRemoteUser() {
		return remoteUser;
	}

	public void setRemoteUser(String remoteUser) {
		this.remoteUser = remoteUser;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
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
	
	public Long getRemoteUserId() {
		return remoteUserId;
	}

	public void setRemoteUserId(Long remoteUserId) {
		this.remoteUserId = remoteUserId;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}
	
}

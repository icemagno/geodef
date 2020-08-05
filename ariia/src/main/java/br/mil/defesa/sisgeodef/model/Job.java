package br.mil.defesa.sisgeodef.model;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class Job {
	private String serialNumber;
	private String userId;
	private String data;
	private String status;
	private List<String> log;
	
	public void addLog( String s ) {
		this.log.add( s );
	}
	
	public Job() {
		this.serialNumber = UUID.randomUUID().toString().replace("-", "").toUpperCase();
		this.log = new ArrayList<String>();
		this.status = "RUNNING";
	}
	
	public String getSerialNumber() {
		return serialNumber;
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getData() {
		return data;
	}
	
	public void setData(String data) {
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;  
	}

	public List<String> getLog() {
		return log;
	}
	
}

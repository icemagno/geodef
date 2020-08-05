package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

public class JobInfo implements Serializable {
	private static final long serialVersionUID = 1L;
	private String jobSerial;
	private String message;
	private String hostName;
	
	public JobInfo( String jobSerial, String message ) {
		this.jobSerial = jobSerial;
		this.message = message;
		this.hostName = "ICARO";
	}
	
	public String getJobSerial() {
		return jobSerial;
	}
	
	public void setJobSerial(String jobSerial) {
		this.jobSerial = jobSerial;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public String getHostName() {
		return hostName;
	}
	
	public void setHostName(String hostName) {
		this.hostName = hostName;
	}	
	
}

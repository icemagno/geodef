package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

public class JobInfo implements Serializable {
	private static final long serialVersionUID = 1L;
	private String jobSerial;
	private String message;
	private String detail;
	private String hostName;
	
	public JobInfo( String jobSerial, String message ) {
		this.jobSerial = jobSerial;
		this.message = message;
		this.hostName = "ODISSEU";
	}

    public JobInfo(String jobSerial, String message, String detail) {
        this.jobSerial = jobSerial;
        this.message = message;
        this.detail = detail;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
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

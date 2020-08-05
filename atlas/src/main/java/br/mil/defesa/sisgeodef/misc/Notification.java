package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

import com.netflix.appinfo.InstanceInfo.InstanceStatus;

public class Notification implements Serializable {
	private static final long serialVersionUID = 1L;
	private String name;
	private String url;
	private InstanceStatus status;
	private String id;
	private String version;
	private Integer hitCount;
	private Boolean newData;

	public Notification (String name, String url, InstanceStatus status, String id, String version) {
		this.status = status;
		this.name = name;
		this.url = url;
		this.id = id;
		this.version = version;
		this.hitCount = 0;
		this.newData = true;
	}
	
	public void incHitCount() {
		if ( this.hitCount > 10 ) {
			this.newData = false;
		} else {
			this.hitCount++;
		}
	}

	public Integer getHitCount() {
		return hitCount;
	}
	
	public Boolean getNewData() {
		return newData;
	}
	
	public Boolean isNewData() {
		return this.newData;
	}
	
	public void setHitCount(Integer hitCount) {
		this.hitCount = hitCount;
	}
	
	public String getName() {
		return name;
	}	
	
	public String getUrl() {
		return url;
	}
	
	public InstanceStatus getStatus() {
		return status;
	}
	
	public String getId() {
		return id;
	}
	
	public String getVersion() {
		return version;
	}
	
}

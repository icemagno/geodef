package br.com.cmabreu.misc;

public class Config {
	private long totalUsers;
	private long totalClients;
	private long totalTokens;
	private String fotoServer;
	
	public Config() {
		// TODO Auto-generated constructor stub
	}
	
	public Config(long totalUsers, long totalClients, long totalTokens ) {
		this.totalClients = totalClients;
		this.totalTokens = totalTokens;
		this.totalUsers = totalUsers;
		this.fotoServer = "";
	}
	
	public long getTotalUsers() {
		return totalUsers;
	}
	
	public void setTotalUsers(long totalUsers) {
		this.totalUsers = totalUsers;
	}
	
	public long getTotalClients() {
		return totalClients;
	}
	
	public void setTotalClients(long totalClients) {
		this.totalClients = totalClients;
	}
	
	public long getTotalTokens() {
		return totalTokens;
	}
	
	public void setTotalTokens(long totalTokens) {
		this.totalTokens = totalTokens;
	}

	public String getFotoServer() {
		return fotoServer;
	}

	public void setFotoServer(String fotoServer) {
		this.fotoServer = fotoServer;
	}
	
	
}

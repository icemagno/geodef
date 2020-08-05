package br.com.cmabreu.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ClientListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private List<OAuthClientDetailsDTO> clients;
	
	public ClientListDTO() {
		this.clients = new ArrayList<OAuthClientDetailsDTO>();
	}
	
	public void addClient( OAuthClientDetailsDTO client ) {
		clients.add( client );
	}

	public List<OAuthClientDetailsDTO> getClients() {
		return clients;
	}

	public void setClients(List<OAuthClientDetailsDTO> clients) {
		this.clients = clients;
	}
	
	
}

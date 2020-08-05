package br.com.cmabreu.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class ClientListLesserDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private List<OAuthClientDetailsLesserDTO> clients;
	
	public ClientListLesserDTO() {
		this.clients = new ArrayList<OAuthClientDetailsLesserDTO>();
	}
	
	public void addClient( OAuthClientDetailsLesserDTO client ) {
		clients.add( client );
	}

	public List<OAuthClientDetailsLesserDTO> getClients() {
		return clients;
	}

	public void setClients(List<OAuthClientDetailsLesserDTO> clients) {
		this.clients = clients;
	}
	
	
}

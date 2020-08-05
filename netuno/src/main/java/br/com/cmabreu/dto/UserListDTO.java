package br.com.cmabreu.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import br.com.cmabreu.model.User;

public class UserListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private List<UserLesserDTO> data;

	public void addUser( UserLesserDTO user ) {
		data.add( user );
	}

	public UserListDTO() {
		this.data = new ArrayList<UserLesserDTO>();
	}
	
	public void addUsers( List<User> users ) {
		for ( User user : users ) {
			this.data.add( new UserLesserDTO( user ) );
		}
	}

	public void addUsersDTO( List<UserDTO> users ) {
		this.data = new ArrayList<UserLesserDTO>();
		for ( UserDTO user : users ) {
			this.data.add( new UserLesserDTO( user ) );
		}
	}

	public void addUsersLesserDTO( List<UserLesserDTO> users ) {
		this.data = users;
	}
	
	public void emptyList() {
		this.data = new ArrayList<UserLesserDTO>();
	}
	
	public List<UserLesserDTO> getData() {
		return data;
	}

	public void setData(List<UserLesserDTO> data) {
		this.data = data;
	}
	
	
}

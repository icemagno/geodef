package br.com.cmabreu.misc;

import java.util.ArrayList;
import java.util.List;

import br.com.cmabreu.dto.AccessLogDTO;
import br.com.cmabreu.model.AccessLog;

public class AccessLogList {
	private List<AccessLogDTO> list;

	public AccessLogList( List<AccessLog> list ) {
		this.list = new ArrayList<AccessLogDTO>();
		for( AccessLog al : list ) {
			this.list.add( new AccessLogDTO( al ) );
		}
	}

	public List<AccessLogDTO> getList() {
		return list;
	}
	
}

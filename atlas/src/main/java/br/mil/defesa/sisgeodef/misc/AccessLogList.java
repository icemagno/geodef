package br.mil.defesa.sisgeodef.misc;

import java.util.ArrayList;
import java.util.List;

import br.mil.defesa.sisgeodef.dto.AccessLogDTO;
import br.mil.defesa.sisgeodef.model.AccessLog;

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

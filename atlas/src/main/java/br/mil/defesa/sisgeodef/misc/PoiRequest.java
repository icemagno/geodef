package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

/*
	data.routegeom = JSON.stringify(geometry);
	data.criteria = "bridge = 'viaduct'";
	data.source = "planet_osm_line";
	data.distance = 500;

*/
public class PoiRequest implements Serializable{
	private static final long serialVersionUID = 1L;
	String routegeom;
	String criteria;
	String source;
	String distance;
	String type;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getRoutegeom() {
		return routegeom;
	}

	public void setRoutegeom(String routegeom) {
		this.routegeom = routegeom;
	}

	public String getCriteria() {
		return criteria;
	}
	
	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}
	
	public String getSource() {
		return source;
	}
	
	public void setSource(String source) {
		this.source = source;
	}
	
	public String getDistance() {
		return distance;
	}
	
	public void setDistance(String distance) {
		this.distance = distance;
	}
	
}

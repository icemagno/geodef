package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class RouteRequest implements Serializable {
	private static final long serialVersionUID = 1L;
	private List<Point> points;
	private List<BlockedArea> blockedAreas;
	private Boolean alternatives;

	public RouteRequest() {
		points = new ArrayList<Point>();
		alternatives = false;
		blockedAreas = new ArrayList<BlockedArea>();
	}
	
	public List<Point> getPoints() {
		return points;
	}

	public void setPoints(List<Point> points) {
		this.points = points;
	}

	public Boolean getAlternatives() {
		return alternatives;
	}

	public void setAlternatives(Boolean alternatives) {
		this.alternatives = alternatives;
	}

	public List<BlockedArea> getBlockedAreas() {
		return blockedAreas;
	}

	public void setBlockedAreas(List<BlockedArea> blockedAreas) {
		this.blockedAreas = blockedAreas;
	}
	
	
}

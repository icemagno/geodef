package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

import org.json.JSONObject;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Layer implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/*	
		"queryable": 1,
		"opaque": 0,
		"CRS": [],
		"Abstract": "",
		"EX_GeographicBoundingBox": {
			"northBoundLatitude": -22.8082256317139,
			"southBoundLatitude": -22.8278903961182,
			"westBoundLongitude": -45.2225074768066,
			"eastBoundLongitude": -45.1824951171875
		},
		"BoundingBox": [],
		"KeywordList": {},
		"Title": "aglomerado_rural_de_extensao_urbana_p",
		"Style": {},
		"Name": "aglomerado_rural_de_extensao_urbana_p"	
	*/	
	
	private Integer queryable;
	private Integer opaque;
	private String title;
	private String name;
	private String layerAbstract;
	private String scale;
	private Double northBoundLatitude;
	private Double southBoundLatitude;
	private Double westBoundLongitude;
	private Double eastBoundLongitude;
	
	//LegendURL
	private boolean valid;
	
	public Layer( JSONObject obj ) {
		this.valid = true;
		try {
			setName( obj.getString("Name") );
			setOpaque( obj.getInt("opaque") );
			setQueryable( obj.getInt("queryable") );
			setLayerAbstract( obj.getString("Abstract") );
			setTitle( obj.getString("Title") );
			
			JSONObject bb = obj.getJSONObject("EX_GeographicBoundingBox");
			setNorthBoundLatitude( bb.getDouble("northBoundLatitude") );
			setSouthBoundLatitude( bb.getDouble("southBoundLatitude") );
			setWestBoundLongitude( bb.getDouble("westBoundLongitude") );
			setEastBoundLongitude( bb.getDouble("eastBoundLongitude") );
		} catch ( Exception e ) {
			System.out.println( e.getMessage() );
			valid = false;
		}
		
		
	}
	
	public boolean isValid() {
		return valid;
	}
	
	public Double getNorthBoundLatitude() {
		return northBoundLatitude;
	}

	public void setNorthBoundLatitude(Double northBoundLatitude) {
		this.northBoundLatitude = northBoundLatitude;
	}

	public Double getSouthBoundLatitude() {
		return southBoundLatitude;
	}

	public void setSouthBoundLatitude(Double southBoundLatitude) {
		this.southBoundLatitude = southBoundLatitude;
	}

	public Double getWestBoundLongitude() {
		return westBoundLongitude;
	}

	public void setWestBoundLongitude(Double westBoundLongitude) {
		this.westBoundLongitude = westBoundLongitude;
	}

	public Double getEastBoundLongitude() {
		return eastBoundLongitude;
	}

	public void setEastBoundLongitude(Double eastBoundLongitude) {
		this.eastBoundLongitude = eastBoundLongitude;
	}

	public String getScale() {
		return scale;
	}

	public void setScale(String scale) {
		this.scale = scale;
	}

	public String getLayerAbstract() {
		return layerAbstract;
	}

	public void setLayerAbstract(String layerAbstract) {
		this.layerAbstract = layerAbstract;
	}

	public Integer getQueryable() {
		return queryable;
	}
	
	public void setQueryable(Integer queryable) {
		this.queryable = queryable;
	}
	
	public Integer getOpaque() {
		return opaque;
	}
	
	public void setOpaque(Integer opaque) {
		this.opaque = opaque;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
}

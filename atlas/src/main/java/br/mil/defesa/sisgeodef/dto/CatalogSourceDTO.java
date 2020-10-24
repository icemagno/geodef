package br.mil.defesa.sisgeodef.dto;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import br.mil.defesa.sisgeodef.model.CatalogSource;

public class CatalogSourceDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private Integer id;
	private Integer parentId;
	private String text;
	private String icon;
	private Boolean checked;
	private Boolean hasChildren;
	private List<CatalogSourceDTO> children;
	private CatalogSource data;
	private String treeIcon;
	
	public CatalogSourceDTO( CatalogSource source ) {
		this.checked = false;
		this.hasChildren = source.getSources().size() > 0;
		source.getSources().clear();
		this.children = new ArrayList<CatalogSourceDTO>();
		this.data = source;
		this.id = source.getId().intValue();
		this.parentId = source.getParentId();
		this.text = source.getSourceName();
		if( source.getSourceAddress().length() > 10  ) this.treeIcon = "http://sisgeodef.defesa.mil.br/midas/atlas/icons/tree-layer.png";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	public Boolean getHasChildren() {
		return hasChildren;
	}

	public void setHasChildren(Boolean hasChildren) {
		this.hasChildren = hasChildren;
	}

	public List<CatalogSourceDTO> getChildren() {
		return children;
	}

	public void setChildren(List<CatalogSourceDTO> children) {
		this.children = children;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public CatalogSource getData() {
		return data;
	}

	public void setData(CatalogSource data) {
		this.data = data;
	}

	public String getTreeIcon() {
		return treeIcon;
	}

	public void setTreeIcon(String treeIcon) {
		this.treeIcon = treeIcon;
	}
	
	
}

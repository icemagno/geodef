package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;

import br.mil.defesa.sisgeodef.dto.UserLesserDTO;

public class ConfigModel implements Serializable {
	private static final long serialVersionUID = 1L;
	private String osmServer;
	private String routeServerAPI;
	private String calistoLocalPath;
	private String osmLayer;
	private String sisgeodefHost;
	private String osmTileServer;
	private boolean useExternalOsm;
	private UserLesserDTO user;
	
	public boolean isUseExternalOsm() {
		return useExternalOsm;
	}
	public void setUseExternalOsm(boolean useExternalOsm) {
		this.useExternalOsm = useExternalOsm;
	}
	public String getOsmTileServer() {
		return osmTileServer;
	}
	public void setOsmTileServer(String osmTileServer) {
		this.osmTileServer = osmTileServer;
	}
	public String getSisgeodefHost() {
		return sisgeodefHost;
	}
	public void setSisgeodefHost(String sisgeodefHost) {
		this.sisgeodefHost = sisgeodefHost;
	}
	public String getOsmLayer() {
		return osmLayer;
	}
	public void setOsmLayer(String osmLayer) {
		this.osmLayer = osmLayer;
	}
	public String getOsmServer() {
		return osmServer;
	}
	public void setOsmServer(String osmServer) {
		this.osmServer = osmServer;
	}
	public String getCalistoLocalPath() {
		return calistoLocalPath;
	}
	public void setCalistoLocalPath(String calistoLocalPath) {
		this.calistoLocalPath = calistoLocalPath;
	}
	public String getRouteServerAPI() {
		return routeServerAPI;
	}
	public void setRouteServerAPI(String routeServerAPI) {
		this.routeServerAPI = routeServerAPI;
	}
	public UserLesserDTO getUser() {
		return user;
	}
	public void setUser(UserLesserDTO user) {
		this.user = user;
	}
	
}

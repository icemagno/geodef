package br.com.cmabreu.misc;

import java.io.Serializable;
import java.text.SimpleDateFormat;

import com.fasterxml.jackson.databind.ObjectMapper;

import br.com.cmabreu.model.UsersClients;

public class UsersClientsDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String clientId;
	private String clientImage;
	private String clientFullName;
	private Integer users;
	private String dtInicial;
	private String dtFinal;
	private String dtAlteracao;
	private boolean sysadmin;
    private String respAlteracao;
    private String tipoAlteracao;
    private String url;
    private String homePath;
    private String descricao;
	
	
	public UsersClientsDTO( UsersClients usersClients ) {	
		this.clientId = usersClients.getClient().getClientId();
		this.users = usersClients.getClient().getUsers().size();
		this.respAlteracao = usersClients.getRespAlteracao();
		this.tipoAlteracao = usersClients.getTipoAlteracao();
		this.url = usersClients.getClient().getWebServerRedirectUri();
		this.sysadmin = usersClients.getSysAdmin();
		
		SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("dd/MM/yyyy");
		this.dtInicial = DATE_FORMAT.format( usersClients.getDtInicial() );
		this.dtFinal = DATE_FORMAT.format( usersClients.getDtFinal() );
		this.dtAlteracao = DATE_FORMAT.format( usersClients.getDtAlteracao() );
		
		
		ObjectMapper om = new ObjectMapper();
		try {
			ClientAdditionalInformation cai = om.readValue( usersClients.getClient().getAdditionalInformation(), ClientAdditionalInformation.class );
			this.clientFullName = cai.getNome();
			this.clientImage = cai.getLogotipo();
			this.homePath = cai.getHomePath();
			this.descricao = cai.getDescricao();
		} catch ( Exception e ) {
			//
		}
		
		if( this.clientImage == null || this.clientImage == "" ) {
			this.clientImage = "/resources/img/apolo-symbol.png";
		}
		
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientImage() {
		return clientImage;
	}

	public void setClientImage(String clientImage) {
		this.clientImage = clientImage;
	}

	public String getClientFullName() {
		return clientFullName;
	}

	public void setClientFullName(String clientFullName) {
		this.clientFullName = clientFullName;
	}

	public Integer getUsers() {
		return users;
	}

	public void setUsers(Integer users) {
		this.users = users;
	}

	public String getDtInicial() {
		return dtInicial;
	}

	public void setDtInicial(String dtInicial) {
		this.dtInicial = dtInicial;
	}

	public String getDtFinal() {
		return dtFinal;
	}

	public void setDtFinal(String dtFinal) {
		this.dtFinal = dtFinal;
	}

	public boolean isSysadmin() {
		return sysadmin;
	}

	public void setSysadmin(boolean sysadmin) {
		this.sysadmin = sysadmin;
	}

	public String getDtAlteracao() {
		return dtAlteracao;
	}

	public void setDtAlteracao(String dtAlteracao) {
		this.dtAlteracao = dtAlteracao;
	}

	public String getRespAlteracao() {
		return respAlteracao;
	}

	public void setRespAlteracao(String respAlteracao) {
		this.respAlteracao = respAlteracao;
	}

	public String getTipoAlteracao() {
		return tipoAlteracao;
	}

	public void setTipoAlteracao(String tipoAlteracao) {
		this.tipoAlteracao = tipoAlteracao;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getHomePath() {
		return homePath;
	}

	public void setHomePath(String homePath) {
		this.homePath = homePath;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	

}

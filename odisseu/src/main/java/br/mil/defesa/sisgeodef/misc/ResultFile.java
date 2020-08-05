package br.mil.defesa.sisgeodef.misc;

public class ResultFile {
	private String fileId;
	private String url;
	private String contact;
	private String distributionFormat;
	private String citation;
	private String series;
	private String collectiveTitle;
	private String escala;

    public ResultFile() {
    }
	
        
        
        
	public ResultFile( String fileId, String contact, String distributionFormat, String citation, String series, String collectiveTitle, String escala ) {
		this.fileId = fileId;
		this.escala = escala;
		this.series = series;
		this.collectiveTitle = collectiveTitle;
		this.contact = contact;
		this.citation = citation;
		this.distributionFormat = distributionFormat;
		this.url = "https://bdgex.eb.mil.br/mediador/index.php?modulo=download&acao=baixar&identificador=" + fileId;
	}
	
	public String getFileId() {
		return fileId;
	}
	
	public String getUrl() {
		return url;
	}
	
	public String getContact() {
		return contact;
	}
	
	public String getDistributionFormat() {
		return distributionFormat;
	}

	public String getCitation() {
		return citation;
	}

	public String getSeries() {
		return series;
	}

	public String getCollectiveTitle() {
		return collectiveTitle;
	}

	public String getEscala() {
		return escala;
	}
	
	
}

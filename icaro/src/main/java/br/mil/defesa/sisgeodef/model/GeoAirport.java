package br.mil.defesa.sisgeodef.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.json.JSONObject;

@Entity
@Table(name = "aerodromo")
public class GeoAirport implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id", nullable = false, updatable = false)
	private Long id;

	@Column()
    private Integer gid;
	
	@Column(name = "aerodromoid", length = 200, unique = true)
    private String aerodromoId;
	
	@Column(name = "ciad", length = 200)
    private String ciad;
	
	@Column(name = "localidadeid", length = 200)
    private String localidadeId;
	
	@Column(name = "nome", length = 200)
    private String nome;
	
	@Column(name = "tipo", length = 200)
    private String tipo;
	
	@Column(name = "efetivacao", length = 200)
    private String efetivacao;
	
	@Column(name = "fir", length = 200)
    private String fir;
	
	@Column(name = "jurisdicao", length = 200)
    private String jurisdicao;
	
	@Column()
    private Integer latitudeDec;
	
	@Column(name = "latitude", length = 200)
    private String latitude;
	
	@Column()
    private Integer longitudeDec;
	
	@Column(name = "longitude", length = 200)
    private String longitude;
	
	@Column()
    private Integer elevacao;
	
	@Column(name = "elevuom", length = 200)
    private String elevUom;
	
	@Column(name = "tipoutil", length = 200)
	private String tipoUtil;
	
	@Column(name = "catsigla", length = 200)
    private String catSigla;
	
	@Column(name = "opr", length = 200)
    private String opr;
	
	@Column(name = "wh", length = 200)
    private String wh;
	
	@Column(name = "cidade", length = 200)
    private String cidade;
	
	@Column(name = "uf", length = 200)
    private String uf;
	
	@Column(name = "utc", length = 200)
    private String utc;
	
	@Column(name = "emendan", length = 200)
    private String emendaN;
	
	@Column(name = "emenda", length = 200)
    private String emenda;
	
	@Column(name = "coordinates", length = 200)
    private String coordinates;

	@Column( name = "ais_airport", columnDefinition="TEXT" )
    private String aisAirport;
	
	@Column( name = "cartas", columnDefinition="TEXT" )
    private String cartas;	
	
	@Column( name = "notam", columnDefinition="TEXT" )
    private String notam;	
	
	public GeoAirport( JSONObject feature, String coordinates ) {
    	setGid( getInt(feature, "gid") );
    	setCatSigla( getString(feature,"cat_sigla") );
    	setCiad( getString( feature, "ciad") );
    	setCidade( getString( feature, "cidade") );
    	setEfetivacao( getString( feature, "efetivacao") );
    	setElevacao( getInt( feature,"elevacao") );
    	setElevUom( getString( feature, "elev_uom") );
    	setEmenda( getString( feature, "emenda") );
    	setEmendaN( getString(feature, "emenda_n") );
    	setFir( getString( feature, "fir") );
    	setAerodromoId( getString( feature, "id") );
    	setJurisdicao( getString( feature, "jurisdicao") );
    	setLatitude( getString( feature, "latitude") );
    	setLatitudeDec( getInt( feature, "latitude_dec") );
    	setLocalidadeId( getString( feature, "localidade_id") );
    	setLongitude( getString( feature, "longitude") );
    	setLongitudeDec( getInt( feature, "longitude_dec") );
    	setNome( getString( feature, "nome") );
    	setOpr( getString(feature, "opr") );
    	setTipo( getString( feature, "tipo") );
    	setTipoUtil( getString(feature,"tipo_util") );
    	setUf( getString( feature, "uf") );
    	setUtc( getString(feature, "utc") );
    	setWh( getString(feature, "wh") );
    	setCoordinates( coordinates );
	}
    
    @Transient
    private String getString( JSONObject feature, String key ) {
    	try {
	    	if( feature.has(key) ) 
	    		return feature.getString( key ).trim(); 
	    	else
	    		return null;
    	} catch ( Exception e ) {
    		System.out.println( e.getMessage() );
    		return null;
    	}
    }
    
    @Transient
    private Integer getInt( JSONObject feature, String key ) {
    	try {
	    	if( feature.has(key) ) 
	    		return feature.getInt( key ); 
	    	else
	    		return null;
    	} catch ( Exception e ) {
    		System.out.println( e.getMessage() );
    		return null;
    	}
    }

    public GeoAirport() {
		// TODO Auto-generated constructor stub
	}

	public Integer getGid() {
		return gid;
	}

	public void setGid(Integer gid) {
		this.gid = gid;
	}

	public String getCiad() {
		return ciad;
	}

	public void setCiad(String ciad) {
		this.ciad = ciad;
	}

	public String getLocalidadeId() {
		return localidadeId;
	}

	public void setLocalidadeId(String localidadeId) {
		this.localidadeId = localidadeId;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getEfetivacao() {
		return efetivacao;
	}

	public void setEfetivacao(String efetivacao) {
		this.efetivacao = efetivacao;
	}

	public String getFir() {
		return fir;
	}

	public void setFir(String fir) {
		this.fir = fir;
	}

	public String getJurisdicao() {
		return jurisdicao;
	}

	public void setJurisdicao(String jurisdicao) {
		this.jurisdicao = jurisdicao;
	}

	public Integer getLatitudeDec() {
		return latitudeDec;
	}

	public void setLatitudeDec(Integer latitudeDec) {
		this.latitudeDec = latitudeDec;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public Integer getLongitudeDec() {
		return longitudeDec;
	}

	public void setLongitudeDec(Integer longitudeDec) {
		this.longitudeDec = longitudeDec;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public Integer getElevacao() {
		return elevacao;
	}

	public void setElevacao(Integer elevacao) {
		this.elevacao = elevacao;
	}

	public String getElevUom() {
		return elevUom;
	}

	public void setElevUom(String elevUom) {
		this.elevUom = elevUom;
	}

	public String getTipoUtil() {
		return tipoUtil;
	}

	public void setTipoUtil(String tipoUtil) {
		this.tipoUtil = tipoUtil;
	}

	public String getCatSigla() {
		return catSigla;
	}

	public void setCatSigla(String catSigla) {
		this.catSigla = catSigla;
	}

	public String getOpr() {
		return opr;
	}

	public void setOpr(String opr) {
		this.opr = opr;
	}

	public String getWh() {
		return wh;
	}

	public void setWh(String wh) {
		this.wh = wh;
	}

	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}

	public String getUf() {
		return uf;
	}

	public void setUf(String uf) {
		this.uf = uf;
	}

	public String getUtc() {
		return utc;
	}

	public void setUtc(String utc) {
		this.utc = utc;
	}

	public String getEmendaN() {
		return emendaN;
	}

	public void setEmendaN(String emendaN) {
		this.emendaN = emendaN;
	}

	public String getEmenda() {
		return emenda;
	}

	public void setEmenda(String emenda) {
		this.emenda = emenda;
	}

	public String getAisAirport() {
		return aisAirport;
	}

	public void setAisAirport(String aisAirport) {
		this.aisAirport = aisAirport;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getAerodromoId() {
		return aerodromoId;
	}

	public void setAerodromoId(String aerodromoId) {
		this.aerodromoId = aerodromoId;
	}

	public String getCoordinates() {
		return coordinates;
	}

	public void setCoordinates(String coordinates) {
		this.coordinates = coordinates;
	}

	public String getCartas() {
		return cartas;
	}

	public void setCartas(String cartas) {
		this.cartas = cartas;
	}

	public void setNotam(String notam) {
		this.notam = notam;
		
	}

	public String getNotam() {
		return notam;
	}
	
}

package br.mil.defesa.sisgeodef.controller;

import java.util.Arrays;

import javax.validation.Valid;

import org.apache.http.HttpException;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequest;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.CredentialsProvider;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.conn.routing.HttpRoute;
import org.apache.http.conn.routing.HttpRoutePlanner;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.impl.client.BasicCredentialsProvider;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.client.LaxRedirectStrategy;
import org.apache.http.impl.conn.DefaultProxyRoutePlanner;
import org.apache.http.protocol.HttpContext;
import org.apache.http.ssl.SSLContextBuilder;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.misc.Cartas;
import br.mil.defesa.sisgeodef.misc.DataFusor;
import br.mil.defesa.sisgeodef.misc.FileImporter;
import br.mil.defesa.sisgeodef.misc.ImportObserver;
import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;
import br.mil.defesa.sisgeodef.repository.AerodromoRepository;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

@RestController
@RequestMapping("/v1")
@RefreshScope
public class V1Controller {
	private static Logger log = LoggerFactory.getLogger( V1Controller.class );
	
    @Autowired
    AerodromoRepository aerodromoRepository;		
	
	@Value("${icaro.ais.key}")
	private String aisKey;		

	@Value("${icaro.ais.api.url}")
	private String aisApiUrl;	
	
	@Value("${icaro.ais.pass}")
	private String aisPass;		
	
	@Value("${icaro.ais.geoserver.url}")
	private String aisGeoserverUrl;		
	
	@Value("${icaro.proxyUser}")
	private String proxyUser;
	
	@Value("${icaro.proxyHost}")
	private String proxyHost;
	
	@Value("${icaro.proxyPassword}")
	private String proxyPassword;	
	
	@Value("${icaro.nonProxyHosts}")
	private String nonProxyHosts;
	
	@Value("${icaro.proxyPort}")
	private int proxyPort;	

	@Value("${icaro.useProxy}")
	private boolean useProxy;	
	
	@Value("${icaro.chartFolder}")
	private String chartFolder;
	
	@Value("${server.port}")
	private Integer serverPort;	
	
	@Autowired
	JobInfoSender sender;	
	
	private ImportObserver observer;
	
	/****************************************************************************************************
	* 	ENDPOINT PRINCIPAL :: Importa o arquivo AIXM e os dados da API AIS-WEB
	* 	USA UM THREAD PARA CADA IMPORTACAO (AIXM e AIS em processos diferentes).
	* 	http://sisgeodef.defesa.mil.br:36311/v1/import?l=-45&b=-24&r=-40&t=-20&jobSerial=sddsadsadsad
	*****************************************************************************************************/
	@ApiOperation(value = "Ponto de entrada principal. Migra tudo. Precisa de um retângulo composto pelas coordenadas L,B e R,T")
	@RequestMapping(value = "/import", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String importFiles( 
			@ApiParam(value = "Coordenada do limite lateral esquerdo", required = true) @Valid @RequestParam(value="l", required = true) String l, 
			@ApiParam(value = "Coordenada do limite lateral direito", required = true) @Valid @RequestParam(value="r", required = true) String r, 
			@ApiParam(value = "Coordenada do limite superior", required = true) @Valid @RequestParam(value="t", required = true) String t, 
			@ApiParam(value = "Coordenada do limite inferior", required = true) @Valid @RequestParam(value="b", required = true) String b,
			@ApiParam(value = "Identificador da tarefa", required = true) @Valid @RequestParam(value="jobSerial", required = true) String jobSerial ) {
		
		log.info("Iniciando...");
		String result = "";
		
		this.observer = new ImportObserver( jobSerial, sender );
		//importAis( jobSerial, l, r, t, b, observer );
		
		try {
			result = getPub("AIXM");
			JSONObject obj = new JSONObject( result );
			importAIXM( obj, jobSerial );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		
		log.info( "Fim." );
		return result;
	}
	

	// NAO EH ENDPOINT! METODO USADO INTERNAMENTE. Importa os dados da API AIS-WEB e do Geoserver GEO-AIS
	private void importAis( String jobSerial, String l, String r, String t, String b, ImportObserver observer  ) {
		JSONObject cartas = new JSONObject( getCartas( null ) ); 
		Cartas cartasList = new Cartas( cartas );
		log.info("Temos " + cartasList.getCartas().size() + " cartas.");
				
		DataFusor df = new DataFusor( this, getLayer("ICA:airport", l, r, t, b), getLayer("ICA:heliport", l, r, t, b), observer, this.aerodromoRepository, cartasList );
	    Thread thread = new Thread( df );
	    thread.start();	
	}
	
	
	
	/*****************************************************************************************************
	 * 
	 * 
	 * 			METODOS ACESSORIOS - NAO BULA E NAO FACA MUGANGA A PARTIR DESTE PONTO
	 * 
	 * 
	 *****************************************************************************************************/
	
	
	@RequestMapping(value = "/cartas", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getCartas( @RequestParam(value="data", required = false) String data ) {
		String result = "";
		if ( data == null ) data = "last_amdt";
		// http://localhost:36311/v1/cartas?data=last_amdt
		//String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=cartas&dt=" + data;
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=cartas";
		result = get( url );
		return result;
	}	
	
	@ApiOperation(value = "Dados sobre um aeródromo")
	@RequestMapping(value = "/aerodromo", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getDadosAerodromo( @RequestParam(value="icaoCode", required = true) String icaoCode ) {
		return getDadosAerodromoAsJsonObject( icaoCode ).toString();
	}
	public JSONObject getDadosAerodromoAsJsonObject( String icaoCode ) {
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=rotaer&icaoCode=" + icaoCode;
		return getAsObject( url );
	}
	
	@RequestMapping(value = "/notam", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getNotam( @RequestParam(value="icaoCodes", required = true) String icaoCodes ) {
		// http://www.aisweb.aer.mil.br/api/?apiKey=2046730488&apiPass=adc9f816-5cf6-11e7-a4c1-00505680c1b4&area=notam&IcaoCode=SBBR,SBGL,SBRJ&dist=N
		String result = "";
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "area=notam&IcaoCode=" + icaoCodes;
		result = get( url );
		return result;
	}
	public JSONObject getNotamAsJsonObject( String icaoCode ) {
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=notam&icaoCode=" + icaoCode;
		return getAsObject( url );
	}	
	
	@RequestMapping(value = "/geiloc", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getGeiloc( @RequestParam(value="name", required = false) String name ) {
		String result = "";
		if ( name == null ) name = "";
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=geiloc&name=" + name;
		result = get( url );
		return result;
	}
	
	@RequestMapping(value = "/pub", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getPub( /*@RequestParam(value="data", required = true) String data,*/ @RequestParam(value="tipo", required = true) String tipo ) {
		String result = "";
		// http://www.aisweb.aer.mil.br/api/?apiKey=2046730488&apiPass=adc9f816-5cf6-11e7-a4c1-00505680c1b4&area=pub&type=AIXM&dt=2019-03-10
		// http://localhost:36311/v1/pub?tipo=AIXM&data=2019-03-10
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=pub&type=" + tipo;// + "&dt=" + data;
		result = get( url );
		return result;
	}
	
	@RequestMapping(value = "/metar", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getMetar( @RequestParam(value="icaoCode", required = true) String icaoCode ) {
		String result = "";
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=met&icaoCode=" + icaoCode;
		result = get( url );
		return result;
	}		
	
	@RequestMapping(value = "/sol", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getSol( @RequestParam(value="icaoCode", required = true) String icaoCode ) {
		String result = "";
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=sol&icaoCode=" + icaoCode;
		result = get( url );
		return result;
	}	
	
	@RequestMapping(value = "/helipontos", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getHelipontos(  ) {
		return null;//getLayer("ICA:heliport");
	}	
	
	@RequestMapping(value = "/proximaementa", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getNextEmenta(  ) {
		// http://www.aisweb.aer.mil.br/api/?apiKey=2046730488&apiPass=adc9f816-5cf6-11e7-a4c1-00505680c1b4&area=routesp&amdt=next
		String result = "";
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "area=routesp&amdt=next";
		result = get( url );
		return result;
	}	
	
	@RequestMapping(value = "/aerodromos", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getListaAerodromos( ) {
		String url = aisApiUrl + "?apiKey=" + aisKey + "&apiPass=" + aisPass + "&area=rotaer&&rowstart=0&rowend=99999";
		
		JSONObject aisweb = getAsObject( url ); 
		JSONArray itens = aisweb.getJSONObject("aisweb").getJSONObject("rotaer").getJSONArray("item");
		
		for (int i = 0; i < itens.length(); i++) {
			JSONObject item = itens.getJSONObject(i);
			
			String icaoCode = item.getString("AeroCode");
			JSONObject aerodromo = getDadosAerodromoAsJsonObject( icaoCode );
			
			itens.getJSONObject(i).put("aerodromo", aerodromo);
		}
		
		
		return aisweb.toString();
	}		
	
	private JSONObject getLayer( String layerName, String l, String r, String t, String b ) {
		// http://www.aisweb.aer.mil.br/geoserver//ows?service=WFS&version=1.0.0&request=GetFeature&typeName=ICA:airport&outputFormat=application/json&bbox=-45,-24,-40,-20
		
		String bbox = "&bbox=" + l + "," + b + "," + r + "," + t;
		if( b==null || l==null || r==null || t==null ) bbox = "";
		
		String url = aisGeoserverUrl + "/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=" + layerName + "&outputFormat=application/json&srsName=EPSG:4326" + bbox;
		String js = getAsJsonString( url );
		JSONObject featureCollection = new JSONObject( js );
		return featureCollection;
	}		
	
	private String getAsJsonString( String url ) {
		String result = "";
		log.info( url );
		try {
			RestTemplate restTemplate = getRestTemplate();
			ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
			result = response.getBody(); 
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return result;
	}
		
	private RestTemplate getRestTemplate() throws Exception {
		RestTemplate restTemplate;
		if ( useProxy ) {
			restTemplate = new RestTemplate( getFactory() );
		} else {
			restTemplate = new RestTemplate(  );
		}
		return restTemplate;
	}	
	
	private String get( String url ) {
		JSONObject obj = getAsObject( url ); 
		return obj.toString();
	}
	
	private JSONObject getAsObject( String url ) {
		JSONObject result = null;
		//log.info( url );
		try {
			RestTemplate restTemplate = getRestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			headers.setAccept(Arrays.asList(MediaType.APPLICATION_XML));
			HttpEntity<String> entity = new HttpEntity<String>("parameters", headers);
			ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			result = XML.toJSONObject( response.getBody() ); 
		} catch ( Exception e ) {
			log.error( e.getMessage() );
		}
		return result;
	}	
	
	private void importAIXM( JSONObject obj, String jobSerial ) throws Exception {
		
		//String arquivo = obj.getJSONObject("aisweb").getJSONObject("pub").getJSONObject("item").getString("file");
		///Integer arquivoId = obj.getJSONObject("aisweb").getJSONObject("pub").getJSONObject("item").getInt("id");
		
		//observer.notify("Baixando arquivo AIXM " + arquivoId + " | " + arquivo );
            String arquivo = "AIXM_FULL.xml";
		
            FileImporter fd = new FileImporter( this.chartFolder, observer, arquivo, getRestTemplate() );
	    Thread thread = new Thread( fd );
	    thread.start();
	    
	}	

	
	/*
	private void index() {
		// Pede ao Lucene que indexe os dados.
		
		ServiceInstance serviceInstance = loadBalancer.choose("lucene");
		
		String luceneBaseUrl = null;
		
		if ( serviceInstance != null ) {
			luceneBaseUrl = serviceInstance.getUri().toString();
			String serviceUrl = luceneBaseUrl + "/v1/index/database"; 
			
			RestTemplate restTemplate = new RestTemplate();
			Map<String, String> params = new HashMap<String, String>();
			params.put( "jobSerial", this.jobSerial );
			
			HttpEntity< Map<String, String> > request2 = new HttpEntity<>( params ); 			
			HttpEntity<String> response2 = restTemplate.exchange( serviceUrl, HttpMethod.GET, request2, String.class );
			
		}
		
	}
	*/
	
	

	private HttpComponentsClientHttpRequestFactory getFactory() throws Exception {


		int timeout = 1000 * 60 * 60;
		
		RequestConfig requestConfig = RequestConfig.custom()
		        .setConnectTimeout( timeout )
		        .setConnectionRequestTimeout( timeout )
		        .setSocketTimeout( timeout )
		        .build();				
		
		HttpHost proxy = new HttpHost(proxyHost, proxyPort);
        HttpRoutePlanner routePlanner = new DefaultProxyRoutePlanner( proxy ) {
            @Override
            public HttpRoute determineRoute(final HttpHost host, final HttpRequest request, final HttpContext context) throws HttpException {
                String hostname = host.getHostName();
                if ( nonProxyHosts.contains(hostname) ) {
                    return new HttpRoute(host);
                }
                return super.determineRoute(host, request, context);
            }
        };		
		
        CredentialsProvider credsProvider = new BasicCredentialsProvider();
        credsProvider.setCredentials(new AuthScope(proxyHost, proxyPort), new UsernamePasswordCredentials(proxyUser, proxyPassword ));		
        
		SSLContextBuilder sslcontext = new SSLContextBuilder().loadTrustMaterial( null, new TrustSelfSignedStrategy() );
		
        CloseableHttpClient httpClient = HttpClients.custom()
        		.setRedirectStrategy( new LaxRedirectStrategy() )
        		.setDefaultRequestConfig( requestConfig )
        		.setSSLContext( sslcontext.build() )
        		.setSSLHostnameVerifier( NoopHostnameVerifier.INSTANCE )
        		.setRoutePlanner(routePlanner).
        		setDefaultCredentialsProvider(credsProvider)
        .build();				

        
        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setConnectionRequestTimeout( timeout );
        factory.setReadTimeout( timeout );
        factory.setHttpClient( httpClient );
        return factory;
	}
	
	
}

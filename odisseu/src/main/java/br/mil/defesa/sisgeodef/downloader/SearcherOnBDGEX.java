/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.sisgeodef.downloader;

import br.mil.defesa.sisgeodef.controller.V1Controller;
import br.mil.defesa.sisgeodef.misc.AreaMigracao;
import br.mil.defesa.sisgeodef.misc.ResultFile;
import br.mil.defesa.sisgeodef.misc.ResultFileList;
import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;
import br.mil.defesa.sisgeodef.repository.ShapeFileRepository;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.Authenticator;
import java.net.PasswordAuthentication;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.ServiceInstance;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.slf4j.Logger;

/**
 *
 * @author joaquim
 */
public class SearcherOnBDGEX {
    
    @Autowired
    ShapeFileRepository shapeFileRepository;	
    
    private V1Controller vc;
    private Logger log;

    public SearcherOnBDGEX(V1Controller vc) {
        this.vc = vc;
        this.log = vc.getLog();
    }
    
    
	
    
    public ResultFileList getListFiles(AreaMigracao am, String jobSerial, V1Controller vc) {
		
		//log.info("Consulta BDGEX: iniciando...");
		String result = "";                
		//setEnvironment();
		ResultFileList rfl = new ResultFileList();
                
                //this.jobSerial = jobSerial;
		
		try {
			// Ler o arquivo XML com o criterio de busca
			File file = new File( vc.getTargetDirectory() + "/parametros.xml");
			FileInputStream fi = new FileInputStream(file);
	        String str = "";
	        StringBuffer buf = new StringBuffer();
	        
	        try {
	            BufferedReader reader = new BufferedReader( new InputStreamReader( fi ) );
	            if ( fi != null ) {                            
	                while ( ( str = reader.readLine() ) != null) {    
	                    buf.append( str );
	                }                
	            }
	            reader.close();
	        } finally {
	            try { fi.close(); } catch (Throwable ignore) {}
	        }			
			
			
			
		    String data = buf.toString().replace("#ll#", am.getL()).replace("#rr#", am.getR()).replace("#tt#", am.getT()).replace("#bb#", am.getB());
		    
	
		    // Prepara o POST
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_JSON);
			HttpEntity<String> requestB = new HttpEntity<String>( data, headers );
			
			// Executa o POST
			// Submete a consulta ao BDGEX
			
			
			RestTemplate restTemplateB = new RestTemplate( getFactory() );
                        //setEnvironment();
                        
			ResponseEntity<String> responseB = restTemplateB.postForEntity( "http://bdgex.eb.mil.br/csw", requestB , String.class );		
			result = responseB.getBody();
                        //unsetEnvironment();
			
			//System.out.println( result );
			
			// ATENCAO: NAO ESTOU PREPARADO PARA RECEBER UM UNICO RESULTADO.
			// ISSO TRARIA "gmd:MD_Metadata" COMO UM OBJECT E NAO COMO UM ARRAY
			JSONObject jsonObject = new JSONObject(result);
			JSONArray mdMetadata = jsonObject.getJSONObject("csw:GetRecordsResponse").getJSONObject("csw:SearchResults").getJSONArray("gmd:MD_Metadata");
			
			//log.info( mdMetadata.length() + " registros encontrados.");
			
			// Analiza o JSON resultante e pega todos os arquivos encontrados
			for (int i = 0; i < mdMetadata.length(); i++) {
				JSONObject jsonObj = mdMetadata.getJSONObject(i);
				
				String GMDfileId = jsonObj.getJSONObject("gmd:fileIdentifier").getString("gco:CharacterString");
				String contact = jsonObj.getJSONObject("gmd:contact").getJSONObject("gmd:CI_ResponsibleParty").getJSONObject("gmd:organisationName").getString("gco:CharacterString");
				
                                String debug = jsonObj.getJSONObject("gmd:distributionInfo")
					.getJSONObject("gmd:MD_Distribution")
					.getJSONObject("gmd:distributionFormat")
					.getJSONObject("gmd:MD_Format").toString();
                                        
                                System.out.println("Json: "+ debug);
				String distributionFormat = jsonObj.getJSONObject("gmd:distributionInfo")
					.getJSONObject("gmd:MD_Distribution")
					.getJSONObject("gmd:distributionFormat")
					.getJSONObject("gmd:MD_Format")
					//.getJSONArray("gmd:name")
					//.getJSONObject(0)
                                        .getJSONObject("gmd:name")
					.getString("gco:CharacterString");

				String citation = jsonObj.getJSONObject("gmd:identificationInfo")
						.getJSONObject("gmd:MD_DataIdentification")
						.getJSONObject("gmd:citation")
						.getJSONObject("gmd:CI_Citation")
						.getJSONObject("gmd:title")
						.getString("gco:CharacterString");				

				
				String series = jsonObj.getJSONObject("gmd:identificationInfo")
						.getJSONObject("gmd:MD_DataIdentification")
						.getJSONObject("gmd:citation")
						.getJSONObject("gmd:CI_Citation")
						.getJSONObject("gmd:series")
						.getJSONObject("gmd:CI_Series")
						.getJSONObject("gmd:name")
						.getString("gco:CharacterString");					

				
				String escala = jsonObj.getJSONObject("gmd:identificationInfo")
						.getJSONObject("gmd:MD_DataIdentification")
						.getJSONObject("gmd:citation")
						.getJSONArray("gmd:spatialResolution").getJSONObject(0)
						.getJSONObject("gmd:MD_Resolution")
						.getJSONObject("gmd:equivalentScale")
						.getJSONObject("gmd:MD_RepresentativeFraction")
						.getJSONObject("gmd:denominator")
						.getString("gco:Integer");
							
				
				String collectiveTitle = "Sem Titulo";
				try {
					collectiveTitle = jsonObj.getJSONObject("gmd:identificationInfo")
							.getJSONObject("gmd:MD_DataIdentification")
							.getJSONObject("gmd:citation")
							.getJSONObject("gmd:CI_Citation")
							.getJSONObject("gmd:collectiveTitle")
							.getString("gco:CharacterString");					
				} catch ( Exception ee ) {
					//log.error( ee.getMessage() );
				}
		
				//log.info( " > Registro " + citation );
				
				// Guarda internamente as informacoes dos arquivos encontrados na consulta
				ResultFile rf = new ResultFile( GMDfileId, contact, distributionFormat, citation, series, collectiveTitle, escala );
				rfl.addFile(rf);
			}
			
			// Baixa os arquivos
			//downloadList( rfl );
			
		} catch( Exception e ) {
			e.printStackTrace();
			//log.error( e.getMessage() );
		}
		
		
		
		//log.info( "Fim." );
		return rfl;
	}
    
    public void setEnvironment2() {
		
        String user = this.vc.getProxyHost();
        String password = this.vc.getProxyPassword();
		Authenticator.setDefault(
			new Authenticator() {
			    @Override
			     public PasswordAuthentication getPasswordAuthentication() {
			    	return new PasswordAuthentication( user, password.toCharArray() );
			    }
			}
		);		
				
		System.setProperty("https.proxyHost", this.vc.getProxyHost());
		System.setProperty("https.proxyPort", String.valueOf(this.vc.getProxyPort()) );		
		System.setProperty("https.proxyUser", this.vc.getProxyUser());
		System.setProperty("https.proxyPassword", this.vc.getProxyPassword() );				

		System.setProperty("http.proxyHost", this.vc.getProxyHost());
		System.setProperty("http.proxyPort", String.valueOf(this.vc.getProxyPort()));		
		System.setProperty("http.proxyUser", this.vc.getProxyUser());
		
		System.setProperty("http.proxyPassword", this.vc.getProxyPassword());				
		System.setProperty("http.nonProxyHosts", this.vc.getNonProxyHosts());		
		
	}
	
	private void unsetEnvironment2() {
		
		System.setProperty("https.proxyHost", "");
		System.setProperty("https.proxyPort", "" );		
		System.setProperty("https.proxyUser", "");
		System.setProperty("https.proxyPassword", "" );				

		System.setProperty("http.proxyHost", "");
		System.setProperty("http.proxyPort", "");		
		System.setProperty("http.proxyUser", "");
		
		System.setProperty("http.proxyPassword", "");				
		System.setProperty("http.nonProxyHosts", "");		
		
	}
        
        public void index(String jobSerial) {
		// Pede ao Lucene que indexe os dados.
		
		ServiceInstance serviceInstance = this.vc.getLoadBalancer().choose("lucene");
		//unsetEnvironment();
		
		String luceneBaseUrl = null;
		
		if ( serviceInstance != null ) {
			luceneBaseUrl = serviceInstance.getUri().toString();
			String serviceUrl = luceneBaseUrl + "/v1/index"; 
			
			RestTemplate restTemplate = new RestTemplate();
                        
			Map<String, String> params = new HashMap<String, String>();
			params.put( "job", jobSerial );
                        params.put( "fonte", "DSG" );
			
			HttpEntity< Map<String, String> > request = new HttpEntity<>( params ); 			
			HttpEntity<String> response = restTemplate.exchange( serviceUrl, HttpMethod.GET, request, String.class );
                        System.out.println(response.getBody());
			
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String doLogin() throws Exception {
		//log.info( "Login..." );
		
		//setEnvironment();
                
                System.out.println(this.vc.getProxyPort());
		
		final String url = "https://bdgex.eb.mil.br/mediador/index.php?modulo=login&acao=verificar&email=" + this.vc.getSisGeoDefUser() + "&senha=" + this.vc.getProxyPassword();
		RestTemplate restTemplate = new RestTemplate( getFactory() );
		
		Map<String, String> params = new HashMap<String, String>();
		HttpEntity< Map<String, String> > request2 = new HttpEntity<>( params ); 
		
		HttpEntity<String> response2 = restTemplate.exchange( url, HttpMethod.GET, request2, String.class );
		HttpHeaders headers2 = response2.getHeaders();
		
		List<String> cookies = headers2.get("Set-Cookie");
		
		for (Map.Entry<String, List<String> > entry : headers2.entrySet()) {
			//log.info("   > Key = " + entry.getKey() + ", Value = " + entry.getValue());
                        System.out.println("   > Key = " + entry.getKey() + ", Value = " + entry.getValue());
		}	
		int numSessionsOpen = cookies.size()-1;
                String sessionId2 = null;
                
                try {
                    String[] cookieArr2 = cookies.get(numSessionsOpen).replace(" ", "").split(";");
                    sessionId2 = cookieArr2[0].trim();
                } catch (Exception e) {
                    System.out.println("Erro ao abrir a sessão");
                }
			
		
		
		return sessionId2;
	}
	
	public HttpComponentsClientHttpRequestFactory getFactory() throws Exception {
		int timeout = 1000 * 60 * 60;
		
		RequestConfig requestConfig = RequestConfig.custom()
		        .setConnectTimeout( timeout )
		        .setConnectionRequestTimeout( timeout )
		        .setSocketTimeout( timeout )
		        .build();				
		
		HttpHost proxy = new HttpHost(this.vc.getProxyHost(), this.vc.getProxyPort());
        HttpRoutePlanner routePlanner = new DefaultProxyRoutePlanner( proxy ) {
            @Override
            public HttpRoute determineRoute(final HttpHost host, final HttpRequest request, final HttpContext context) throws HttpException {
                String hostname = host.getHostName();
            
                if ( vc.getNonProxyHosts().contains(hostname) ) {
                    return new HttpRoute(host);
                }
                return super.determineRoute(host, request, context);
            }
        };		
		
        CredentialsProvider credsProvider = new BasicCredentialsProvider();
        credsProvider.setCredentials(new AuthScope(this.vc.getProxyHost(), this.vc.getProxyPort()), new UsernamePasswordCredentials(this.vc.getProxyUser(), this.vc.getProxyPassword()));		
        
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

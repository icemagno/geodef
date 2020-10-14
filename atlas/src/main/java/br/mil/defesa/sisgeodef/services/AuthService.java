package br.mil.defesa.sisgeodef.services;

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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;

@Service
public class AuthService {
	@Value("${proxy.proxyUser}")
	private String proxyUser;
	
	@Value("${proxy.proxyHost}")
	private String proxyHost;
	
	@Value("${proxy.proxyPassword}")
	private String proxyPassword;	
	
	@Value("${proxy.nonProxyHosts}")
	private String nonProxyHosts;
	
	@Value("${proxy.proxyPort}")
	private int proxyPort;	
	
	public HttpComponentsClientHttpRequestFactory getFactory() {
		int timeout = 1000 * 60 * 60;
		
		RequestConfig requestConfig = RequestConfig.custom()
		        .setConnectTimeout( timeout )
		        .setConnectionRequestTimeout( timeout )
		        .setSocketTimeout( timeout )
		        .build();				
		
		HttpHost proxy = new HttpHost( proxyHost, proxyPort );
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
        credsProvider.setCredentials( new AuthScope( proxyHost, proxyPort ), new UsernamePasswordCredentials( proxyUser, proxyPassword ) );		

        try {
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
        } catch ( Exception e ) {
        	return null;
        }
        
	}	
	
	
}

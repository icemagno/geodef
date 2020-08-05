package br.mil.defesa.sisgeodef.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import br.mil.defesa.sisgeodef.downloader.DownloadObserver;
import br.mil.defesa.sisgeodef.downloader.FileDownloader;
import br.mil.defesa.sisgeodef.downloader.IDownloaderObserver;
import br.mil.defesa.sisgeodef.downloader.SearcherOnBDGEX;
import br.mil.defesa.sisgeodef.misc.AreaMigracao;
import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;
import br.mil.defesa.sisgeodef.repository.ShapeFileRepository;
import java.util.logging.Level;

@RestController
@RequestMapping("/v1")
public class V1Controller {
	private static Logger log = LoggerFactory.getLogger( V1Controller.class );
	
	
        @Autowired
        ShapeFileRepository shapeFileRepository;
        
        @Autowired
	JobInfoSender sender;        
	
	@Autowired
	private LoadBalancerClient loadBalancer;	
	
	@Value("${odisseu.proxyUser}")
	private String proxyUser;
	
	@Value("${odisseu.proxyHost}")
	private String proxyHost;
	
	//@Value("${odisseu.proxyPassword}")
	private String proxyPassword;	
	
	@Value("${odisseu.nonProxyHosts}")
	private String nonProxyHosts;
	
	@Value("${odisseu.proxyPort}")
	private int proxyPort;
	
	@Value("${odisseu.sisGeoDefUser}")
	private String sisGeoDefUser;	
	
	@Value("${odisseu.sisGeoDefPassword}")
	private String sisGeoDefPassword;
	        
        @Value("${odisseu.targetDirectory}")
	private String targetDirectory;	
        
        private IDownloaderObserver observer;
        
        
	
	@RequestMapping(value = "/run", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public Boolean run( 
			@RequestParam(value="l", required = true) String l, 
			@RequestParam(value="r", required = true) String r, 
			@RequestParam(value="t", required = true) String t, 
			@RequestParam(value="b", required = true) String b,
			@RequestParam(value="jobSerial", required = true) String jobSerial ) {
            
            
            
            SearcherOnBDGEX bdg = new SearcherOnBDGEX(this);
            this.observer = new DownloadObserver( jobSerial, sender );
            this.observer.notify("Iniciando o processo de migração dos dados do BDGEX.");
            
            
            this.proxyPassword = "da03082001MB!";
            
            
            AreaMigracao am = new AreaMigracao(l, r, t, b);            
            String cookie;
            
            
            try {
                cookie = bdg.doLogin();
                this.observer.notify("Login no BDGEX efetuado com sucesso.");
                
                FileDownloader fd = new FileDownloader( this.observer , bdg.getFactory(), targetDirectory, null, am, cookie, jobSerial, shapeFileRepository, this );
                Thread thread = new Thread( fd );
                thread.start();
                
		
                
            } catch (Exception ex) {
                this.observer.notify("Erro ao iniciar o processo de migração dos dados do BDGEX.");
                java.util.logging.Logger.getLogger(V1Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            
            
            return true;
        }

        
        
    @RequestMapping(value = "/identifica-produto", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getIdentificadorProduto(
			@RequestParam(value="id", required = true) Long id ) {
            
            String gmdId = shapeFileRepository.findById(id).get().getGmdFileIdentifier();
            
            
            return gmdId;
        }
        
        
    public static Logger getLog() {
        return log;
    }

    public static void setLog(Logger log) {
        V1Controller.log = log;
    }



    public ShapeFileRepository getShapeFileRepository() {
        return shapeFileRepository;
    }

    public void setShapeFileRepository(ShapeFileRepository shapeFileRepository) {
        this.shapeFileRepository = shapeFileRepository;
    }

    public JobInfoSender getSender() {
        return sender;
    }

    public void setSender(JobInfoSender sender) {
        this.sender = sender;
    }

    public LoadBalancerClient getLoadBalancer() {
        return loadBalancer;
    }

    public void setLoadBalancer(LoadBalancerClient loadBalancer) {
        this.loadBalancer = loadBalancer;
    }

    public String getProxyUser() {
        return proxyUser;
    }

    public void setProxyUser(String proxyUser) {
        this.proxyUser = proxyUser;
    }

    public String getProxyHost() {
        return proxyHost;
    }

    public void setProxyHost(String proxyHost) {
        this.proxyHost = proxyHost;
    }

    public String getProxyPassword() {
        return proxyPassword;
    }

    public void setProxyPassword(String proxyPassword) {
        this.proxyPassword = proxyPassword;
    }

    public String getNonProxyHosts() {
        return nonProxyHosts;
    }

    public void setNonProxyHosts(String nonProxyHosts) {
        this.nonProxyHosts = nonProxyHosts;
    }

    public int getProxyPort() {
        return proxyPort;
    }

    public void setProxyPort(int proxyPort) {
        this.proxyPort = proxyPort;
    }

    public String getSisGeoDefUser() {
        return sisGeoDefUser;
    }

    public void setSisGeoDefUser(String sisGeoDefUser) {
        this.sisGeoDefUser = sisGeoDefUser;
    }

    public String getSisGeoDefPassword() {
        return sisGeoDefPassword;
    }

    public void setSisGeoDefPassword(String sisGeoDefPassword) {
        this.sisGeoDefPassword = sisGeoDefPassword;
    }

    public String getTargetDirectory() {
        return targetDirectory;
    }

    public void setTargetDirectory(String targetDirectory) {
        this.targetDirectory = targetDirectory;
    }
	
}

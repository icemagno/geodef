package br.mil.defesa.sisgeodef.misc;

import java.util.ArrayList;
import java.util.List;

import org.springframework.cloud.client.loadbalancer.LoadBalancerClient;
import org.springframework.web.client.RestTemplate;

import com.netflix.appinfo.InstanceInfo;
import com.netflix.appinfo.InstanceInfo.InstanceStatus;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;

import br.mil.defesa.sisgeodef.services.NotificationService;

public class MainHeartBeat implements Runnable {
	private EurekaClient discoveryClient;
	private NotificationService notificationService;
	private Notifications notifications;
	private boolean working = false;
	private RestTemplate restTemplate;
	private List<String> ids;
	private LoadBalancerClient loadBalancer;
	
	public MainHeartBeat( EurekaClient discoveryClient, NotificationService notificationService, LoadBalancerClient loadBalancer ) {
		this.discoveryClient = discoveryClient;
		this.notificationService = notificationService;
		this.notifications = new Notifications();
		this.restTemplate = new RestTemplate();
		this.ids = new ArrayList<String>();
		this.loadBalancer = loadBalancer;
	}

	@Override
	public void run() {
		if ( working ) return;
		working = true;
		try {
			List<Application> applications = discoveryClient.getApplications().getRegisteredApplications();
			
			//ServiceInstance serviceInstance = loadBalancer.choose("gaia");
			//String gaiaBaseUrl = serviceInstance.getUri().toString();			
			
			for (Application application : applications) {
				List<InstanceInfo> applicationsInstances = application.getInstances();
				
				for (InstanceInfo applicationsInstance : applicationsInstances) {
					String name = applicationsInstance.getAppName();
					String url = applicationsInstance.getHomePageUrl();
					InstanceStatus status = applicationsInstance.getStatus();
					String id = applicationsInstance.getId();
					
					
					
					/* TEMP */
					//gaiaBaseUrl = "http://osm.casnav.mb:36207";
					//String serviceInfoUrl = gaiaBaseUrl + "/" + name.toLowerCase()+ "/actuator/info";
					//System.out.println( serviceInfoUrl );
					
					/*
					try {
						ResponseEntity<String> response = restTemplate.getForEntity( serviceInfoUrl, String.class);
						System.out.println( response.getBody() );
					} catch ( Exception ra ) {
						System.out.println("Sem rota para " + name );
					}
					*/
					
					
					ids.add(id);
					notifications.addNotification( new Notification(name, url, status, id, "1.0") );
				}
				
			}
			
			try {
				notifications.cleanUp( ids );
			} catch ( Exception ex ) {
				
			}
			
			
			notificationService.notify( notifications );
			this.ids.clear();
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		working = false;
	}
	
}	

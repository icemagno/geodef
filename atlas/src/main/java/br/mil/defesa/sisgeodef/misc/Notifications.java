package br.mil.defesa.sisgeodef.misc;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Notifications implements Serializable {
	private static final long serialVersionUID = 1L;
	private List<Notification> notifications;
	
	public Notifications() {
		this.notifications = new ArrayList<Notification>();
	}
	
	public synchronized void addNotification( Notification notification ) {
		boolean found = false;
		
		for( Notification not : notifications ) {
			if ( not.getId().equals( notification.getId() ) ) {
				not.incHitCount();
				found = true;
			}
		}
		
		if ( !found ) {
			this.notifications.add( notification );	
		}
	}
	
	public synchronized void cleanUp( List<String> ids ) throws Exception {
		Iterator<Notification> it = notifications.iterator();
		while ( it.hasNext() ) {
			Notification not = it.next();
			boolean found = false;
			for ( String id : ids) {
				if ( id.equals( not.getId()) ) found = true;
			}
			if ( !found ) notifications.remove( not );
		}
		
	}

	public List<Notification> getNotifications() {
		return notifications;
	}
	
	
	
}

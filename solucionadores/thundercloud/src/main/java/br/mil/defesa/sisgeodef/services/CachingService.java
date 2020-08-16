package br.mil.defesa.sisgeodef.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Service;


@Service
public class CachingService {
	private Logger logger = LoggerFactory.getLogger( CachingService.class );

	@Autowired
	CacheManager cacheManager;
	 
	public void evictSingleCacheValue(String cacheName, String cacheKey) {
	    cacheManager.getCache(cacheName).evict(cacheKey);
	}
	 
	public void evictAllCacheValues(String cacheName) {
	    cacheManager.getCache(cacheName).clear();
	}	
	

	public void evictAllCaches() {
		logger.info("Limpando o cache...");
	    for ( String cacheName : cacheManager.getCacheNames() ) {
	    	logger.info( " > " + cacheName );
	    	cacheManager.getCache(cacheName).clear();
	    }
	}		

	
}

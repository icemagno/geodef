package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.CachingService;

@RestController
@RequestMapping("/cache")
public class CachingController {
	
    @Autowired
    CachingService cachingService;
	
    @GetMapping("/clear")
    public void clearAllCaches() {
        cachingService.evictAllCaches();
    }

}

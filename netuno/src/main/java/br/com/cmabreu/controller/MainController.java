package br.com.cmabreu.controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController extends BasicController {
	
	@Value("${terena.midas.location}")
	private String midasLocation;   
	
	public String getMidasLocation() {
		return this.midasLocation;
	}	
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Model model, HttpSession session, Principal principal ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		model.addAttribute( "user", getLoggedUser( session ) );
		return "index";
	}	

	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test(Model model, HttpSession session, Principal principal ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		model.addAttribute( "user", getLoggedUser( session ) );
		return "test";
	}	
	
	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String loginPage(Model model, HttpSession session ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		return "loginPage";
	}
	
	@RequestMapping(value = "/loginPageError", method = RequestMethod.GET)
	public String loginPageError(Model model, HttpSession session ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		return "loginPageError";
	}	

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root(Model model, HttpSession session, Principal principal ) {
		return index( model,session,principal );
	}	
	
	
	@RequestMapping(value = "/sidebar", method = RequestMethod.GET)
	public String sidebar(Model model, HttpSession session ) {
		return "sidebar";
	}
		
	
}

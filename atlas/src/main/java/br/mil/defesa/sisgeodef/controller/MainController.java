package br.mil.defesa.sisgeodef.controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.mil.defesa.sisgeodef.services.ExportService;
import br.mil.defesa.sisgeodef.services.MailService;

@Controller
public class MainController extends BasicController {
	
	@Autowired
	private MailService mailer;
	
	@Autowired
	private ExportService exportService;
	
	@RequestMapping(value = "/saveimage", method = RequestMethod.POST)
	public @ResponseBody String saveImage( @RequestParam("imgBase64") String imgBase64 ) {
		return exportService.exportToPng( imgBase64 );
	}
	

	@RequestMapping(value = "/createchart", method = RequestMethod.POST)
	public @ResponseBody String createChart( @RequestParam("imgBase64") String imgBase64, @RequestParam("legends") String legends ) {
		return exportService.exportToPdf( imgBase64, legends );
	}
	
	
    @GetMapping({"/", "/index", "/home"})
    public String index(Model model, HttpSession session, Principal principal ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		model.addAttribute( "user", getLoggedUser(  session ) );
		return "index";
    }	

    @GetMapping({"/new"})
    public String indexNew(Model model, HttpSession session, Principal principal ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		model.addAttribute( "user", getLoggedUser(  session ) );
		return "index-new";
    }	    
    
    @GetMapping({"/testmail"})
    public @ResponseBody String testMail( @RequestParam("target") String target ) {
    	try {
    		mailer.testaEmail( target );
    	} catch( Exception e) {
    		e.printStackTrace();
    	}
    	return "{ok:\"" + target + "\"}";
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

    
    @GetMapping({"/camera"})
    public String cameraScreen(Model model, HttpSession session, Principal principal ) {
		model.addAttribute( "midasLocation", getMidasLocation() );
		model.addAttribute( "user", getLoggedUser(  session ) );
		return "camera";
    }	    
    
	@RequestMapping(value = "/sidebar", method = RequestMethod.GET)
	public String sidebar(Model model, HttpSession session ) {
		return "sidebar";
	}

    
}

package br.mil.defesa.sisgeodef.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import br.mil.defesa.sisgeodef.services.GenerateChartPDF;
import br.mil.defesa.sisgeodef.services.MailService;

@Controller
public class MainController extends BasicController {
	

	@Value("${calisto.sharedfolder}")
	private String calistofolder;   

	@Value("${calisto.url}")
	private String calistoUrl;   
	
	@Autowired
	private GenerateChartPDF chartPdf;
	
	@Autowired
	private MailService mailer;
	
	@RequestMapping(value = "/saveimage", method = RequestMethod.POST)
	public @ResponseBody String saveImage( @RequestParam("imgBase64") String imgBase64, @RequestParam("imgName") String imgName ) {
		
        try {
        	if ( !calistofolder.endsWith("/") ) calistofolder = calistofolder + "/";
        	String base64Image = imgBase64.split(",")[1];
        	byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
            String directory = calistofolder + imgName;
            FileOutputStream fos = new FileOutputStream(directory);
            fos.write( imageBytes );
            fos.close();
            
            return "success ";
        } catch( Exception e ) {
        	e.printStackTrace();
            return "error = " + e.getMessage();
        }		
		
	}
	

	@RequestMapping(value = "/createchart", method = RequestMethod.POST)
	public @ResponseBody String createChart( @RequestParam("imgBase64") String imgBase64, @RequestParam("imgName") String imgName ) {
		
        try {
        	if ( !calistofolder.endsWith("/") ) calistofolder = calistofolder + "/";
        	if ( !calistoUrl.endsWith("/") ) calistoUrl = calistoUrl + "/";

        	String pdfWorkFolder = "pdf/"; 
        	
        	String imageName = imgName + ".png";
        	String pdfName = imgName + ".pdf";
        	
        	String base64Image = imgBase64.split(",")[1];
        	byte[] imageBytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
            
        	
        	String imageFullName = calistofolder + pdfWorkFolder + imageName;
        	new File( calistofolder + pdfWorkFolder ).mkdirs();
        	
        	FileOutputStream fos = new FileOutputStream( imageFullName );
            fos.write( imageBytes );
            fos.close();

            String pdfUrl = calistoUrl + pdfWorkFolder + pdfName; 
            String pdfFullName = calistofolder + pdfWorkFolder + pdfName; 
            chartPdf.getChart( imageFullName, pdfFullName );
            
            return pdfUrl;
            
        } catch( Exception e ) {
        	e.printStackTrace();
            return "error = " + e.getMessage();
        }		
		
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

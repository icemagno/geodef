package br.mil.defesa.sisgeodef.services;

import java.io.File;
import java.io.FileOutputStream;
import java.util.UUID;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ExportService {
	private String calistoFolder = "/srv/calisto/";
	private String calistoUrl = "http://sisgeodef.defesa.mil.br/calisto/photos/";
	
	@Autowired
	private GenerateChartPDF chartPdf;
	

	public String exportToPng( String imgBase64 ) {
		calistoFolder = calistoFolder + "photos/";
		new File(calistoFolder).mkdirs();
		String imgName = UUID.randomUUID().toString().replaceAll("-", "")+".png";
		
        try {
        	String base64Image = imgBase64.split(",")[1];
        	
        	byte[] imageBytes = Base64.decodeBase64( base64Image );
        	
            String directory = calistoFolder + imgName;
            FileOutputStream fos = new FileOutputStream(directory);
            fos.write( imageBytes );
            fos.close();
            
            return "success ";
        } catch( Exception e ) {
        	e.printStackTrace();
            return "";
        }		
		
	}
	
	public String exportToPdf( String imgBase64, String legends ) {
		new File(calistoFolder + "pdf/").mkdirs();
		String imgName = UUID.randomUUID().toString().replaceAll("-", "");

        try {
    		JSONArray legendFiles = new JSONArray( legends );

    		String pdfWorkFolder = "pdf/"; 
        	
        	String imageName = imgName + ".png";
        	String pdfName = imgName + ".pdf";
        	
        	String base64Image = imgBase64.split(",")[1];
        	byte[] imageBytes = Base64.decodeBase64( base64Image );
            
        	
        	String imageFullName = calistoFolder + pdfWorkFolder + imageName;
        	new File( calistoFolder + pdfWorkFolder ).mkdirs();
        	
        	FileOutputStream fos = new FileOutputStream( imageFullName );
            fos.write( imageBytes );
            fos.close();

            String pdfUrl = calistoUrl + pdfWorkFolder + pdfName; 
            String pdfFullName = calistoFolder + pdfWorkFolder + pdfName; 
            chartPdf.getChart( imageFullName, pdfFullName, legendFiles );
            
            return pdfUrl;
            
        } catch( Exception e ) {
        	e.printStackTrace();
            return "";
        }		
		
		
	}
	
}

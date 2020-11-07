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
	private String calistoUrl = "http://sisgeodef.defesa.mil.br/calisto/";
	
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
		String targetFolder = calistoFolder + "pdf/";
		new File(targetFolder).mkdirs();
		String imgName = UUID.randomUUID().toString().replaceAll("-", "");

        try {
    		JSONArray legendFiles = new JSONArray( legends );

        	String imageName = imgName + ".png";
        	String pdfName = imgName + ".pdf";
        	
        	String base64Image = imgBase64.split(",")[1];
        	byte[] imageBytes = Base64.decodeBase64( base64Image );
            
        	String imageFullName = targetFolder + imageName;
        	
        	FileOutputStream fos = new FileOutputStream( imageFullName );
            fos.write( imageBytes );
            fos.close();

            String pdfUrl = calistoUrl + "pdf/" + pdfName; 
            String pdfFullName = targetFolder + pdfName; 
            chartPdf.getChart( imageFullName, pdfFullName, legendFiles );
            
            return pdfUrl;
            
        } catch( Exception e ) {
        	e.printStackTrace();
            return "";
        }		
		
		
	}

	public String saveLegend(String imgBase64, String id) {
		String targetFolder = calistoFolder + "legends/";
		new File(targetFolder).mkdirs();
		String imgName = id.replaceAll("-", "") + ".png"; 
		String imgUrl = calistoUrl + "legends/" + imgName;
        try {
        	String base64Image = imgBase64.split(",")[1];
        	
        	byte[] imageBytes = Base64.decodeBase64( base64Image );
        	
            String directory = targetFolder + imgName;
            FileOutputStream fos = new FileOutputStream(directory);
            fos.write( imageBytes );
            fos.close();
            
            return imgUrl;
        } catch( Exception e ) {
        	e.printStackTrace();
            return "";
        }		
	}
	
}

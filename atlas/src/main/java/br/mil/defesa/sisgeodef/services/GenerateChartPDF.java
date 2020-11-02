package br.mil.defesa.sisgeodef.services;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;

import javax.imageio.ImageIO;

import org.json.JSONArray;
import org.springframework.stereotype.Service;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import br.mil.defesa.sisgeodef.misc.HeaderAndFooter;


@Service
public class GenerateChartPDF {
	private String calistoFolder = "/srv/calisto/";
	private int LEG_WIDTH = 150;
	private int LEG_HEIGHT = 200;
	private Document document;
	
	public void getChart( String imagePath, String savePath, JSONArray legendFiles ) throws Exception {
		
		String imagesFolder = calistoFolder + "images/";
		
        float left = 30;
        float right = 30;
        float top = 115;
        float bottom = 40;

        document = new Document(PageSize.A4, left, right, top, bottom);
        
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream( savePath ));
        
        
        document.open();

        document.addCreator("SisGeoDef");
        document.addAuthor("Ministério da Defesa");
        document.addTitle("SISGEODEF");
        document.addCreationDate();

        
        //PdfPTable table = new PdfPTable( new float[]{5, 1} );
        PdfPTable table = new PdfPTable( 1 );
        
        table.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.setWidthPercentage(100);
        Image thumb = Image.getInstance( imagePath );
        
        writer.setPageEvent(new HeaderAndFooter( "( Definir o título do documento )", imagesFolder ) );

        float scaler = ((document.getPageSize().getWidth() - document.leftMargin() - document.rightMargin()) / thumb.getWidth()) * 100;

        thumb.scalePercent(scaler);
        thumb.setBorder(Image.BOX);
        thumb.setBorderWidth(1);

        thumb.setAlignment(Element.ALIGN_CENTER);
        table.addCell(thumb);
        	
        /*
        Font fontValue = new Font(Font.FontFamily.COURIER, 7, Font.NORMAL, BaseColor.BLACK);
        PdfPCell cell = new PdfPCell(new Paragraph("Magno", fontValue));
        cell.addElement(new Paragraph("Carlos", fontValue));
        cell.addElement(new Paragraph("Magno", fontValue));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        */
        
        
       	document.add( table );

    	PdfPTable aTable = createImageTable();
    	int columnCounter = 0;
       	for( int x = 0; x < legendFiles.length(); x++ ) {
       		try {
	       		String filename = calistoFolder + "legends/" + legendFiles.getString( x );
	       		
	       		BufferedImage img = ImageIO.read( new File(filename) );
	       		BufferedImage resizedImage = resize( img, LEG_WIDTH, LEG_HEIGHT);
	       		
	       		ByteArrayOutputStream baos = new ByteArrayOutputStream();
	       		ImageIO.write( resizedImage, "png", baos );       		
	       		
	            Image leg = Image.getInstance( baos.toByteArray() );
	            leg.setBorderWidth( 0.5f );
	            leg.scaleAbsolute( LEG_WIDTH, LEG_HEIGHT );
	            leg.setScaleToFitHeight(false);
	            
	            
	            PdfPCell legCell = new PdfPCell( leg, false );
	            legCell.setHorizontalAlignment(Element.ALIGN_LEFT);
	            legCell.setBorder( Rectangle.NO_BORDER );
	            aTable.addCell( legCell );
	       		columnCounter++;
	       		if ( columnCounter == 4 ) columnCounter = 0;
       		} catch ( Exception e ) {
       			
       		}
            		
       	}
       	
       	for( int y = columnCounter; y < 4; y++) {
       		aTable.addCell( getCellVal("") );
       	}

       	document.add( aTable );
       	
        document.close();        
        writer.close();
        
	}

	public BufferedImage resize(BufferedImage img, int newW, int newH) {  
	    int w = img.getWidth();  
	    int h = img.getHeight();  
	    
	    BufferedImage dimg = new BufferedImage( newW, newH, img.getType() );  
	    Graphics2D g = dimg.createGraphics();  
	    g.setBackground( Color.WHITE );
	    g.fillRect(0, 0, newW, newH);
	    g.setRenderingHint( RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BILINEAR);  

	    if( newH > h ) newH = h;
	    if( newW > w ) newW = w; 
	    
	    g.drawImage(img, 0, 0, newW, newH, 0, 0, w, h, null);  
	    g.dispose();  
	    return dimg;  
	}  	
	
	
	private PdfPTable createImageTable() {
		float cw = ( document.getPageSize().getWidth() - document.leftMargin() - document.rightMargin() ) / 4 ;
		System.out.println( cw );
		Float legW = cw - 20;
		
		if( cw < LEG_WIDTH) LEG_WIDTH = legW.intValue(); 
		
    	PdfPTable aTable = new PdfPTable( 4 );
    	try {
    		aTable.setTotalWidth( new float[]{cw, cw, cw, cw}  );
    	} catch ( Exception e ) {
    		e.printStackTrace();
    	}
    	aTable.setSpacingBefore(15);
    	aTable.setWidthPercentage(100);
    	aTable.setLockedWidth(true);
    	//aTable.setSpacingAfter(15);       		
		return aTable;
	}
	
	
    private PdfPCell getCellVal(String value) {
        Font fontValue = new Font(Font.FontFamily.COURIER, 7, Font.NORMAL, BaseColor.BLACK);
        PdfPCell cell = new PdfPCell(new Phrase(value, fontValue));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        return cell;
    }
    
    /*
    private PdfPCell getCellKey(String key) {
        Font fontKey = new Font(Font.FontFamily.COURIER, 7, Font.BOLD, BaseColor.BLACK);
        PdfPCell cell = new PdfPCell(new Phrase(key, fontKey));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        return cell;
    }	
	*/
 
    	
}

package br.mil.defesa.sisgeodef.services;

import java.io.FileOutputStream;

import org.springframework.stereotype.Service;

import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;


@Service
public class GenerateChartPDF {
	
	public void getChart( String imagePath, String savePath ) throws Exception {
		
        //ByteArrayOutputStream out = new ByteArrayOutputStream();
		
        float left = 30;
        float right = 30;
        float top = 115;
        float bottom = 40;

        Document document = new Document(PageSize.A4, left, right, top, bottom);
        
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream( savePath ));
        
        
        document.open();

        document.addCreator("SisGeoDef");
        document.addAuthor("Ministério da Defesa");
        document.addTitle("SISGIDE - Relatório de PCN");
        document.addCreationDate();

        
        PdfPTable table = new PdfPTable(1);
        table.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.setWidthPercentage(100);
        Image thumb = Image.getInstance( imagePath );

        float scaler = ((document.getPageSize().getWidth() - document.leftMargin() - document.rightMargin()) / thumb.getWidth()) * 100;

        thumb.scalePercent(scaler);
        thumb.setBorder(Image.BOX);
        thumb.setBorderWidth(1);

        thumb.setAlignment(Element.ALIGN_CENTER);
        table.addCell(thumb);
        	
       	document.add( table );
        
        document.close();        
        writer.close();
	}
	
	/*
    private PdfPCell getCellVal(String value) {
        Font fontValue = new Font(Font.FontFamily.COURIER, 7, Font.NORMAL, BaseColor.BLACK);
        PdfPCell cell = new PdfPCell(new Phrase(value, fontValue));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        return cell;
    }

    private PdfPCell getCellKey(String key) {
        Font fontKey = new Font(Font.FontFamily.COURIER, 7, Font.BOLD, BaseColor.BLACK);
        PdfPCell cell = new PdfPCell(new Phrase(key, fontKey));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        return cell;
    }	
	*/
 
    	
}

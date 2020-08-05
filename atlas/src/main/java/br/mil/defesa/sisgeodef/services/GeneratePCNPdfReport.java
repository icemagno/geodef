package br.mil.defesa.sisgeodef.services;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import br.mil.defesa.sisgeodef.misc.HeaderAndFooter;
import br.mil.defesa.sisgeodef.misc.PCNParameters;


@Service
public class GeneratePCNPdfReport {
	
	@Value("${calisto.sharedfolder}")
	private String calistoFolder;   
	
	@Value("${mapproxy.url}")
	private String mapproxyUrl;   	// http://sisgeodef.defesa.mil.br:36890	
	
	public ByteArrayInputStream getPCNReport( JSONObject json, PCNParameters params ) throws Exception {
		
    	if ( !calistoFolder.endsWith("/") ) calistoFolder = calistoFolder + "/";
    	String imagesFolder = calistoFolder + "images/";
    	//new File( outputPdfFolder ).mkdirs();
    	
        ByteArrayOutputStream out = new ByteArrayOutputStream();
		
        float left = 30;
        float right = 30;
        float top = 115;
        float bottom = 40;

        Document document = new Document(PageSize.A4, left, right, top, bottom);
        PdfWriter writer = PdfWriter.getInstance( document, out );
        document.open();

        document.addCreator("SisGeoDef");
        document.addAuthor("Ministério da Defesa");
        document.addTitle("SISGIDE - Relatório de PCN");
        document.addCreationDate();

        String pcn = "*";
        String larg = "*";
        String comp = "*";
        if( params.getPcn() > -1 ) pcn = String.valueOf( params.getPcn() ); 
        if( params.getLargura() > -1 ) larg = String.valueOf( params.getLargura() ); 
        if( params.getComprimento() > -1 ) comp = String.valueOf( params.getComprimento() ); 
        
        String pcnString = pcn + "/" + params.getPavimento() + "/" + params.getResistencia() + "/" + params.getPressao() + "/" + params.getAvaliacao();
        
        PdfPTable table = new PdfPTable(new float[]{1, 3});
        writer.setPageEvent(new HeaderAndFooter( "Relatório de PCN", imagesFolder ) );		

        table.addCell( getCellKey("Parâmetros da Busca:") );
        table.addCell( getCellVal("") );
        
        table.addCell( getCellKey("PCN") );
        table.addCell( getCellVal( pcnString ) );
        
        table.addCell( getCellKey("ICAO") );
        table.addCell( getCellVal( params.getIcao() ) );
        
        table.addCell( getCellKey("Largura") );
        table.addCell( getCellVal( larg ) );
        
        table.addCell( getCellKey("Comprimento") );
        table.addCell( getCellVal( comp ) );
        
        table.addCell( getCellKey("") );
        table.addCell( getCellVal("") );

        table.addCell( getCellKey("Pistas Localizadas:") );
        table.addCell( getCellVal("") );

        table.addCell( getCellKey("") );
        table.addCell( getCellVal("") );
        
        
        document.add(table);
        
        JSONArray features = json.getJSONArray("features");
        @SuppressWarnings("unused")
		int runwayIndex = 0;
        String lastIcao = "";
        for( int x = 0; x < features.length(); x++ ) {
        	JSONObject feature = features.getJSONObject(x);
        	
        	//System.out.println( feature );
        	
        	JSONObject geometry = feature.getJSONObject("geometry");
        	JSONArray coordinates = geometry.getJSONArray("coordinates");
        	Double longitude = coordinates.getJSONArray(0).getDouble(0);
        	Double latitude = coordinates.getJSONArray(0).getDouble(1);
        	JSONObject properties = feature.getJSONObject("properties");
        	
        	PdfPTable aTable = new PdfPTable(new float[]{1, 3});        	
        	aTable.setSpacingBefore(10);
        	aTable.setSpacingAfter(15);
        	
        	
        	String icao = properties.getString("designator");
        	if( !lastIcao.equals( icao ) ) runwayIndex = 0;
        	runwayIndex++;
        	lastIcao = icao;

        	/*
        	Double offset = 0.01;
        	Double l = longitude - offset;
        	Double r = longitude + offset;
        	Double t = latitude + offset;
        	Double b = latitude - offset;
        	String imgPicture = getBackgroundMapPath( getMapUrl( t, b, l, r, 256, 256 ), icao, runwayIndex );
            Image thumb = Image.getInstance( imgPicture );
            thumb.scaleAbsolute( 50, 50 );
            thumb.setAbsolutePosition( 100, 100 + (x * 50) );
            */
        	
        	aTable.addCell( getCellKey("Aeródromo") );
        	aTable.addCell( getCellVal( properties.getString("name") ) );
        	
        	aTable.addCell( getCellKey("ICAO") );
        	aTable.addCell( getCellVal( icao ) );
            
        	aTable.addCell( getCellKey("Pista") );
        	aTable.addCell( getCellVal( properties.getString("way_designator")  ) );
        	aTable.addCell( getCellKey("Comprimento") );
        	aTable.addCell( getCellVal( properties.getString("nominallength") + "m"  ) );
        	aTable.addCell( getCellKey("Largura") );
        	aTable.addCell( getCellVal( properties.getString("nominalwidth") + "m" ) );
        	aTable.addCell( getCellKey("PCN") );
        	aTable.addCell( getCellVal( properties.getString("pcn_code")  ) );
        	aTable.addCell( getCellKey("Tipo") );
        	aTable.addCell( getCellVal( properties.getString("controltype")  ) );
        	aTable.addCell( getCellKey("Cabeceira") );
        	aTable.addCell( getCellVal(  latitude + ", " + longitude ) );
        	
        	document.add( aTable );
        }
        
        document.close();        
        
        return new ByteArrayInputStream( out.toByteArray() );
	}
	
	
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
	
	/*
    private String getSerial() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 10);
    }
    */	

    /*
    private String getMapUrl( Double t, Double b, Double l, Double r, Integer width, Integer height ) {
    	String layerName = "osmlocal";
		String bbox = l + "," + b + "," + r + "," + t; 
		String url = mapproxyUrl + "/service/wms?service=WMS&srs=EPSG:4326&styles=&width="+width+"&height="+height+"&version=1.1.1&request=GetMap&layers="+layerName+"&format=image/png&bbox=" + bbox;
    	return url;
    }
	
    private String getBackgroundMapPath(String mapUrl, String icao, int runwayIndex) {
        String airportFilePath = calistoFolder + "/airports/";
        String airportFileName = airportFilePath + icao + "-" + runwayIndex + ".png"; 

        new File( airportFilePath ).mkdirs(); 

        if( new File( airportFileName ).exists() ) return airportFileName; 
        
        try (InputStream in = new URL(mapUrl).openStream()) {
            Files.copy(in, Paths.get( airportFileName ));
            return airportFileName;
        } catch (Exception e) {
            return null;
        }
    }    
    */	
}

package br.mil.defesa.sisgeodef.misc;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

public class HeaderAndFooter extends PdfPageEventHelper {
    
    private String titulo;
    private String path;

    public HeaderAndFooter(String titulo, String path) {
        super();
        this.titulo = titulo;
        this.path = path;
    }

    public HeaderAndFooter() {
        super();
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        new PdfHeaderAndFooterUtil(path, titulo).generate(writer, document);
    }	
	
}

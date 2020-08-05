package br.mil.defesa.sisgeodef.misc;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Font.FontFamily;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfWriter;

/**
 * Classe auxiliar para o evento de cabeçalho e rodapé dos relatórios do
 * sistema.
 *
 * @author arthur
 */
public class PdfHeaderAndFooterUtil {

    private final String titulo;
    private final String path;
    private static Font headerFont = new Font(FontFamily.HELVETICA, 9, Font.NORMAL, BaseColor.BLACK);
    private static Font headerMiniFont = new Font(FontFamily.HELVETICA, 8, Font.NORMAL, BaseColor.BLACK);
    private static Font footerFont = new Font(FontFamily.COURIER, 8, 0, BaseColor.GRAY);

    public PdfHeaderAndFooterUtil(String path) {
        this(path, null);
    }

    public PdfHeaderAndFooterUtil(String path, String titulo) {
        super();
        this.titulo = titulo;
        this.path = path;
    }

    public void generate(PdfWriter writer, Document document) {
        PdfContentByte cb = writer.getDirectContent();

        SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
        Date now = new Date();
        String strDate = sdfDate.format(now);
        String strTime = sdfTime.format(now);

        // Header
        float padding = 10;
        float p1 = document.top() + 45;
        float p2 = p1 - padding;
        float p3 = p2 - padding;
        float p4 = p3 - padding;
        //float p5 = p4 - padding;

        float xAxisCenterContent = (document.right() - document.left()) / 2 + document.leftMargin();

        ColumnText.showTextAligned(cb, Element.ALIGN_CENTER, new Phrase("MINISTÉRIO DA DEFESA", headerFont), xAxisCenterContent, p1, 0);

        ColumnText.showTextAligned(cb, Element.ALIGN_CENTER, new Phrase("ESTADO-MAIOR CONJUNTO DAS FORÇAS ARMADAS", headerFont), xAxisCenterContent, p2, 0);

        //ColumnText.showTextAligned(cb, Element.ALIGN_CENTER, new Phrase("CHEFIA DE LOGÍSTICA E MOBILIZAÇÃO", headerFont), xAxisCenterContent, p3, 0);

        //ColumnText.showTextAligned(cb, Element.ALIGN_CENTER, new Phrase("SUBCHEFIA DE INTEGRAÇÃO LOGÍSTICA", headerFont), xAxisCenterContent, p4, 0);

        if (this.titulo != null) {
            ColumnText.showTextAligned(cb, Element.ALIGN_CENTER, new Phrase(this.titulo, headerMiniFont), xAxisCenterContent, p4, 0);
        }

        // Footer
        ColumnText.showTextAligned(cb, Element.ALIGN_LEFT, new Phrase("SisGIDE", footerFont),
                document.leftMargin() - 1, document.bottom() - 20, 0);

        ColumnText.showTextAligned(cb, Element.ALIGN_RIGHT, new Phrase(strDate + " " + strTime, footerFont),
                document.right() - 2, document.bottom() - 10, 0);

        ColumnText.showTextAligned(cb, Element.ALIGN_RIGHT, new Phrase("SISGEODEF", footerFont),
                document.right() - 2, document.bottom() - 20, 0);

        if (this.path != null) {
            try {

                String brasaoDefesaPath = path + "/defesa-novo.png";
                Image brasaoDefesa = Image.getInstance(brasaoDefesaPath);
                float brasaoDefesaWidth = 50;
                brasaoDefesa.scaleAbsolute(brasaoDefesaWidth, 45);
                brasaoDefesa.setAbsolutePosition(xAxisCenterContent - (brasaoDefesaWidth / 2), PageSize.A4.getHeight() - brasaoDefesa.getScaledHeight() - 15 );

                /*
                String brasaoSisclatenPath = path + "/sisclaten_sem_fundo.png";
                Image brasaoSisclaten = Image.getInstance(brasaoSisclatenPath);
                brasaoSisclaten.scaleAbsolute(120, 60);
                brasaoSisclaten.setAbsolutePosition(document.leftMargin(), PageSize.A4.getHeight() - brasaoSisclaten.getScaledHeight() - 40);

                String brasaoApoloPath = path + "/apolo.png";
                Image brasaoApolo = Image.getInstance(brasaoApoloPath);
                brasaoApolo.scaleAbsolute(110, 60);
                brasaoApolo.setAbsolutePosition(PageSize.A4.getWidth() - ((document.rightMargin() / 2) + brasaoSisclaten.getScaledWidth()), PageSize.A4.getHeight() - brasaoApolo.getScaledHeight() - 35);
                
                document.add(brasaoSisclaten);
                document.add(brasaoApolo);
                */
                
                
                document.add(brasaoDefesa);
                
            } catch (DocumentException | IOException e) {
                System.out.println("Erro ao pegar imagens para o relatório. " + e.getMessage() );
            }
        }
    }

}

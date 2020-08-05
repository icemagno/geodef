/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.apolo.interoperabilidade.resource;

import br.mil.defesa.apolo.interoperabilidade.controller.ResourceController;
import br.mil.defesa.apolo.interoperabilidade.misc.ImportObserver;
import br.mil.defesa.apolo.interoperabilidade.model.Geodata;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.StringField;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.index.Term;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.highlight.Formatter;
import org.apache.lucene.search.highlight.Fragmenter;
import org.apache.lucene.search.highlight.Highlighter;
import org.apache.lucene.search.highlight.InvalidTokenOffsetsException;
import org.apache.lucene.search.highlight.QueryScorer;
import org.apache.lucene.search.highlight.SimpleHTMLFormatter;
import org.apache.lucene.search.highlight.SimpleSpanFragmenter;
import org.apache.lucene.search.highlight.TokenSources;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author joaquim
 */
public class Lucene {
    
    
    public Boolean indexDatabase(List<Geodata> c, Boolean regenerateIndex, Boolean deleteAll, ImportObserver observer){
        ResolveEspecialChar ec = new ResolveEspecialChar();
        LuceneConf lc = new LuceneConf();
        try
        {
            //org.apache.lucene.store.Directory instance
            Directory dir = FSDirectory.open( Paths.get(lc.INDEX_DIR) );
             
            //analyzer with the default stop words
            Analyzer analyzer = new StandardAnalyzer();
            
             
            //IndexWriter Configuration
            IndexWriterConfig iwc = new IndexWriterConfig(analyzer);
            iwc.setOpenMode(IndexWriterConfig.OpenMode.CREATE_OR_APPEND);
             
            //IndexWriter writes new index files to the directory
            IndexWriter writer = new IndexWriter(dir, iwc);
            
            /*if(deleteAll){
                System.out.println("Apagando completamente o Indice");
                writer.deleteAll();
            } else{
            */ 
                if(!regenerateIndex){
                    System.out.println("Apagando parcialmente o Indice");

                    Integer ident = (c.get(0).getFonte() + c.get(0).getTipo()).hashCode();

                    Term term= new Term("tipo",ident.toString());
                    writer.deleteDocuments(term);
                }
                     
            //}
            
            
            for(int i = 0; i< c.size(); i++){
                Document doc = new Document();
                Integer ident = (c.get(i).getFonte() + c.get(i).getTipo()).hashCode();
                
                
                        
                doc.add(new StringField("path", c.get(i).getId().toString(), Field.Store.YES));
                doc.add(new TextField("contents", ec.especialChar(c.get(i).getMetadados()), Field.Store.YES));
                doc.add(new TextField("geom", c.get(i).getGeom(), Field.Store.YES));
                doc.add(new StringField("tipo", c.get(i).getTipo(), Field.Store.YES));
                doc.add(new StringField("fonte", c.get(i).getFonte(), Field.Store.YES));
                doc.add(new StringField("origem", ident.toString(), Field.Store.YES));
                doc.add(new StringField("resumo", c.get(i).getResumo(), Field.Store.YES));
                
                if(c.get(i).getSimbolo() == null){
                   c.get(i).setSimbolo("");
                }
                
                doc.add(new StringField("simbolo", c.get(i).getSimbolo(), Field.Store.YES));

                if(regenerateIndex){
                    writer.addDocument(doc);
                } else{
                    writer.updateDocument(new Term("path",c.get(i).getId().toString()), doc);
                }
                c.set(i, new Geodata());
       
            }
            
            //System.out.println("Tem alteracao:"+ writer.hasPendingMerges());
            //System.out.println("Tamanho em Bytes:"+ writer.ramBytesUsed());
            writer.close();
 
            return true;
        } 
        catch (Exception e) 
        {   
            observer.notify("Erro ao indexar os dados de "+c.get(0).getTipo()+" para o Geocodificador", e.getMessage());
            e.printStackTrace();
            return false;
        }
}
    
    public JSONObject search(String q, Integer limit, Boolean peso, JdbcTemplate jdbcT) throws IOException, InvalidTokenOffsetsException, ParseException{
        
        GeoJson geojson = new GeoJson();
        ResourceController rc = new ResourceController();
        ResolveEspecialChar ec = new ResolveEspecialChar();
        LuceneConf lc = new LuceneConf();
        
        
        
        //Get directory reference
        Directory dir = FSDirectory.open(Paths.get(lc.INDEX_DIR));
        //
        //Index reader - an interface for accessing a point-in-time view of a lucene index
        IndexReader reader = DirectoryReader.open(dir);
        
        //Create lucene searcher. It search over a single IndexReader.
        IndexSearcher searcher = new IndexSearcher(reader);
         
        //analyzer with the default stop words
        Analyzer analyzer = new StandardAnalyzer();
         
        //Query parser to be used for creating TermQuery
        QueryParser qp = new QueryParser("contents", analyzer);
         
        q = ec.especialChar(q);
        
        if(peso){
            q = rc.weightTerms(q, jdbcT);
        }
        System.out.println("Buscando: "+q);
        //Create the query
        Query query = qp.parse(q);
       
        //Search the lucene documents
        TopDocs hits = searcher.search(query, limit);
        
        /** Highlighter Code Start ****/
         
        //Uses HTML &lt;B&gt;&lt;/B&gt; tag to highlight the searched terms
        Formatter formatter = new SimpleHTMLFormatter();
         
        //It scores text fragments by the number of unique query terms found
        //Basically the matching score in layman terms
        QueryScorer scorer = new QueryScorer(query);
         
        //used to markup highlighted terms found in the best sections of a text
        Highlighter highlighter = new Highlighter(formatter, scorer);
         
        //It breaks text up into same-size texts but does not split up spans
        Fragmenter fragmenter = new SimpleSpanFragmenter(scorer, 10);
         
        //breaks text up into same-size fragments with no concerns over spotting sentence boundaries.
        //Fragmenter fragmenter = new SimpleFragmenter(10);
         
        //set fragmenter to highlighter
        highlighter.setTextFragmenter(fragmenter);
         
        JSONObject featureCollection = new JSONObject();
        featureCollection.put("type", "FeatureCollection");
        JSONArray features = new JSONArray();
        
        
        //Iterate over found results
        for (int i = 0; i < hits.scoreDocs.length; i++) 
        {
            int docid = hits.scoreDocs[i].doc;
            Document doc = searcher.doc(docid);
            
            String title = doc.get("path");
             
            //Printing - to which document result belongs
            Geodata geo = new Geodata();
            
            geo.setId(Long.parseLong(title));
            geo.setMetadados(doc.get("contents"));
            geo.setFonte(doc.get("fonte"));
            geo.setTipo(doc.get("tipo"));
            geo.setGeom(doc.get("geom"));
            geo.setResumo(doc.get("resumo"));
            geo.setSimbolo(doc.get("simbolo"));
            
            //System.out.println("Path " + " : " + title);
            //System.out.println(doc.get("contents"));
             
            //Get stored text from found document
            String text = doc.get("contents");
           
            //Create token stream
            TokenStream stream = TokenSources.getAnyTokenStream(reader, docid, "contents", analyzer);
             
            //Get highlighted text fragments
            String[] frags = highlighter.getBestFragments(stream, text, 10);
            /*for (String frag : frags) 
            {
                //System.out.println("=======================");
                //System.out.println(frag);
                
            }*/
            geo.setMatch(frags);
            features.add(geojson.createGeoJson(geo.getResumo(), geo.getGeom(), geo.getMetadados(), geo.getSimbolo(), i));
            
            
            
        }
        dir.close();
    


        featureCollection.put("features", features);
        
        return featureCollection;
    }
    
}

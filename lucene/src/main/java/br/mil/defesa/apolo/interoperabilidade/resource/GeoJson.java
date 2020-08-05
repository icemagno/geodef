/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.mil.defesa.apolo.interoperabilidade.resource;

import br.mil.defesa.apolo.interoperabilidade.controller.LucineController;
import java.io.IOException;
import java.util.logging.Level;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/**
 *
 * @author joaquim
 */
public class GeoJson {
    public JSONObject createGeoJson(String Resumo, String geom, String prop, String simbolo, Integer ordem) throws IOException{
        
        
        JSONObject feature = new JSONObject();
        feature.put("type", "Feature");
        
        JSONObject sort = new JSONObject();         
        feature.put("relevance", ordem); 
        
        feature.put("simbolo", simbolo);
        
        try {
            JSONParser parser = new JSONParser();
            JSONObject json = (JSONObject) parser.parse(geom);            
            feature.put("geometry", json);
            
        } catch (org.json.simple.parser.ParseException ex) {
            ex.printStackTrace();
            java.util.logging.Logger.getLogger(LucineController.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        try {
            JSONParser parser = new JSONParser();
            JSONObject pr = (JSONObject) parser.parse(prop); 
            feature.put("properties", pr);            
            
        } catch (org.json.simple.parser.ParseException ex) {
            ex.printStackTrace();            
            java.util.logging.Logger.getLogger(LucineController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            JSONParser parser = new JSONParser();            
            JSONObject res = (JSONObject) parser.parse(Resumo);            
            feature.put("resumo", res);
            
        } catch (org.json.simple.parser.ParseException ex) {
            ex.printStackTrace();            
            java.util.logging.Logger.getLogger(LucineController.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        return feature;
    }
}

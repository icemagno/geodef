package br.com.cmabreu.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.com.cmabreu.model.ConstantesHarmonicas;
import br.com.cmabreu.model.Previsao;
import br.com.cmabreu.model.Previsoes;
import br.com.cmabreu.services.PrevisaoDLLService;

@RestController
public class PrevisaoController {
	
	@Value("${mare.targetdir}")
	private String targetDir;
	
	@Value("${mare.sourcedir}")
	private String sourceDir;
	
	@Autowired
	PrevisaoDLLService previsaoDLLService; 

	@RequestMapping(value = "/previsao/{estacao}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE )
	public Previsoes previsaoEstacao( @PathVariable("estacao") String estacao, 
			@RequestParam(value="dtini", required=true) String dtInicial, 
			@RequestParam(value="dtfim", required=true) String dtFinal,
			@RequestParam(value="analise", required=false) Integer forceAnalise) {
		

		String stationDir = targetDir + "/" + estacao;
		String arqPrevMaxMin = stationDir + "/PREVMAXMINCOL.txt";
		String arqPrevHoraria = stationDir + "/PREVHORCOL.txt";
		
		Previsoes prevs = new Previsoes();
		File dir = new File( stationDir );
		dir.mkdirs();
		
		File prevHor = new File( arqPrevHoraria );
		File prevMaxMin = new File( arqPrevMaxMin );
		
		prevHor.delete();
		prevMaxMin.delete();
		
		try {
			previsaoDLLService.geraPrevisaoCombinada( estacao, dtInicial, dtFinal, arqPrevHoraria, arqPrevMaxMin, forceAnalise );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		

		if( prevHor.exists() ) {
		
			try {
				FileReader fr = new FileReader( prevHor );
				BufferedReader br = new BufferedReader(fr);			
				String sCurrentLine;
				br.readLine();  // Descarta o cabecalho
				
				while ((sCurrentLine = br.readLine()) != null) {
					
					if( sCurrentLine != null && !sCurrentLine.trim().equals("") ) {
						String data = sCurrentLine.substring(0, 10);
						String valor = sCurrentLine.substring(10, 16);
						String hora = sCurrentLine.substring(16, sCurrentLine.length() );
						prevs.addHoraria( new Previsao(data.trim(), hora.trim(), valor.trim() ) );
					}
					
				}			
				if (br != null)	br.close();
				if (fr != null)	fr.close();
			} catch( Exception ee ) {
				ee.printStackTrace();
			}
			
		}

		if( prevMaxMin.exists() ) {
			
			try {
				FileReader fr = new FileReader( prevMaxMin );
				BufferedReader br = new BufferedReader(fr);			
				String sCurrentLine;
				br.readLine(); br.readLine(); // Descarta o cabecalho

				while ((sCurrentLine = br.readLine()) != null) {
					if( sCurrentLine != null && !sCurrentLine.trim().equals("") ) {

						String data = sCurrentLine.substring(0, 10);
						String hora = sCurrentLine.substring(10, 16);
						String valor = sCurrentLine.substring(16, sCurrentLine.length() );
						prevs.addMaxMin( new Previsao(data.trim(), hora.trim(), valor.trim() ) );
					
					}
				}			
				if (br != null)	br.close();
				if (fr != null)	fr.close();
			} catch( Exception ee ) {
				ee.printStackTrace();
			}
			
		}
		
		return prevs;
		
	}	
	

	@RequestMapping(value = "/previsao/constantes/{estacao}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_UTF8_VALUE )	
	public ConstantesHarmonicas previsaoConstantes(@PathVariable("estacao") String estacao ) {
		ConstantesHarmonicas constantes = previsaoDLLService.getConstantesHarmonicas( estacao );
		return constantes;
	}
	
	
}

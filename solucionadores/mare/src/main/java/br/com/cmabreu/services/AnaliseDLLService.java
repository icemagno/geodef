package br.com.cmabreu.services;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sun.jna.Native;

import br.com.cmabreu.external.AnaliseDLL;
import br.com.cmabreu.misc.TipoAnaliseEnum;

@Service
public class AnaliseDLLService {
	private Logger logger = LoggerFactory.getLogger( AnaliseDLLService.class );
	private AnaliseDLL analiseDll;
	
	@Value("${mare.targetdir}")
	private String targetDir;
	
	private void geraArquivoAlturas( String arquivo ) {
		try {  
			File file = new File( arquivo );  
			FileReader fr = new FileReader( file );  
			BufferedReader br = new BufferedReader( fr );  
			StringBuffer sb = new StringBuffer();  
			String line;  
			while( ( line = br.readLine() ) != null ) {  
				sb.append(line);  
				sb.append("\n");   
			}  
			fr.close();  
			System.out.println( sb.toString() );  
		}  catch(IOException e)	{  
			e.printStackTrace();  
		}  
	}
	
	
	public void analise( 
			String arqAlt, 
			String arqConst, 
			String arqReduc, 
			String arqRelat, 
			String arq13Ciclos, 
			String arq9Ciclos, 
			String klm1, 
			String cons, 
			String niveis, 
			String del, 
			String dataImp ) {
		try {
			logger.info("Gerando Analise");
			analiseDll.analise_( arqAlt, arqConst, arqReduc, arqRelat, arq13Ciclos, arq9Ciclos, klm1, cons, niveis, del, dataImp );
			logger.info("Consluido");
		} catch ( Exception e ) {
			e.printStackTrace();
		}
	}

	public void nimed( 
			String arqAlt, 
			String filtro, 
			String listagem, 
			String deleta, 
			String grava, 
			String arqCotas, 
			String diaAnter, 
			String diaPoster, 
			String arqImpre, 
			String dataImp) {
		try {
			logger.info("Gerando Nimed");
			analiseDll.nimed_( arqAlt, filtro, listagem, deleta, grava, arqCotas, diaAnter, diaPoster, arqImpre, dataImp );
			logger.info("Concluido");
		} catch ( Exception e ) {
			e.printStackTrace();
		}
			
	}
	
	
	@PostConstruct
	public void startup() {
		logger.info("Carregando biblioteca de Analise");
		logger.info( System.getProperty("java.library.path" ) );
		
		try {
			analiseDll = ( AnaliseDLL )Native.loadLibrary( /*lib*/"analise"/*.so*/, AnaliseDLL.class); // libanalise.so.so
			logger.info("Biblioteca de Analise carregada.");
		} catch ( Exception e ) {
			logger.error( e.getMessage() );
		}
	}


	public void analiseHarmonica(TipoAnaliseEnum tipoAnalise, String arquivoAlt, String arquivoAh, String arquivoConst) {
		String arqReducao = targetDir + "/reducaoSondagem.tmp";
		String arqAlt = arquivoAlt + ".tmp";
		String arq13Ciclos = targetDir + "/tab_13_ciclos.dat";
		String arq9Ciclos = targetDir + "/tab_9_ciclos.dat";
		
		String klm1 = "0";
		if( tipoAnalise == TipoAnaliseEnum.NIVEL_MEDIO ) klm1 = "1";

		String cons = "S";
		String niveis = "S";
		String del = "N";
		
		String pattern = "dd/MM/yyyy";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat( pattern );		
		String dataImp = simpleDateFormat.format( new Date() );
		
		this.geraArquivoAlturas( arquivoAlt );
		
		this.analise( arqAlt, arquivoConst, arqReducao, arquivoAh, arq13Ciclos, arq9Ciclos, klm1, cons, niveis, del, dataImp );
		
		float z0 = retornaZ0Reducao( arqReducao );
		formataCostantes( arquivoConst, z0 );
	}
	
	
	private void formataCostantes( String arquivoConst, float z0 ) {
/*		
var
  ArqConst, ArqSaida: TextFile;
  QtdConstantes: Integer;
  Nome: string[7];
  Veloc: string[11];
  H, G: string[8];
  LinhaCompo: string;
begin
  QtdConstantes:= BbtFuncoes.contaLinhasArquivo(ArquivoConst);
  AssignFile(ArqConst, ArquivoConst);
  AssignFile(ArqSaida, ArquivoConst + '.tmp');
  Reset(ArqConst);
  Rewrite(ArqSaida);
  Write(ArqSaida, FormatFloat('000', QtdConstantes));
  Write(ArqSaida, FormatFloat('0000000.00', Z0));
  Write(ArqSaida, FormatDateTime('ddmmyyyy', DataInicial));
  Write(ArqSaida, FormatDateTime('ddmmyyyy', DataFinal));
  Write(ArqSaida, NumEstacao);
  Write(ArqSaida, NomeEstacao);
  Write(ArqSaida, Latitude);
  Write(ArqSaida, Longitude);
  Writeln(ArqSaida, Fuso);
  while not (Eof(ArqConst)) do
    begin
      Readln(ArqConst, Nome, Veloc, H, G);
      LinhaCompo:= retornaLinhaComponente(Nome, H, G);
      if (LinhaCompo <> '') then
        Writeln(ArqSaida, LinhaCompo);
    end;
  CloseFile(ArqSaida);
  CloseFile(ArqConst);
  DeleteFile(ArquivoConst);
  RenameFile(ArquivoConst + '.tmp', ArquivoConst);

*/	
	}
	
	
	private float retornaZ0Reducao( String arqReducao ) {
/*		
	var
	  ArqReduc: TextFile;
	  NumEstacao: string[5];
	  DataIni, DataFim: string[8];
	  NivelMedio, NivelClassif, Z0, NivelReduc: string[7];
	  PreSizi, PreQuadrat, BaixaSizi, BaixaQuadrat: string[7];
	  Classif: string[21];
	  Hora, Minuto: string[2];
	begin
	  AssignFile(ArqReduc, ArqReducao);
	  Reset(ArqReduc);
	  Readln(ArqReduc, NumEstacao, DataIni, DataFim, NivelMedio, NivelClassif, Classif,
	    Z0, NivelReduc, Hora, Minuto, PreSizi, PreQuadrat, BaixaSizi, BaixaQuadrat);
	  CloseFile(ArqReduc);
	  NivelMedio:= Trim(NivelMedio);
	  NivelClassif:= Trim(NivelClassif);
	  Z0:= Trim(Z0);
	  NivelReduc:= Trim(NivelReduc);
	  PreSizi:= Trim(PreSizi);
	  PreQuadrat:= Trim(PreQuadrat);
	  BaixaSizi:= Trim(BaixaSizi);
	  BaixaQuadrat:= Trim(BaixaQuadrat);
	  Classif:= Trim(Classif);
	  Hora:= Trim(Hora);
	  Minuto:= Trim(Minuto);
	  Result:= StrToFloat(Trim(Z0));
		
*/
		return 0.0f;
	}
	
}

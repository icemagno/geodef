package br.com.cmabreu.services;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.sun.jna.Native;

import br.com.cmabreu.external.PrevisaoDLL;
import br.com.cmabreu.mappers.AnaliseMareMapper;
import br.com.cmabreu.mappers.ComponenteMapper;
import br.com.cmabreu.mappers.EstacaoMapper;
import br.com.cmabreu.model.AnaliseMare;
import br.com.cmabreu.model.Componente;
import br.com.cmabreu.model.ConstantesHarmonicas;
import br.com.cmabreu.model.Estacao;

@Service
public class PrevisaoDLLService {
	private Logger logger = LoggerFactory.getLogger( PrevisaoDLLService.class );
	private PrevisaoDLL previsaoDll;

	@Value("${mare.targetdir}")
	private String targetDir;
	
	@Value("${mare.sourcedir}")
	private String sourceDir;
	
	@Autowired
    JdbcTemplate jdbcTemplate;		
	
	private boolean geraArqConst;
	
	public void setGeraArqConst( boolean value ) {
		this.geraArqConst = value;
	}
	
	public ConstantesHarmonicas getConstantesHarmonicas( String codEstacao ){
		int codAnalise = retornaCodigoAnalisePeriodoPadrao( codEstacao );
		int codEstacaoI = Integer.valueOf( codEstacao );
		List<Estacao> estacoes = getEstacoes( codEstacaoI );
		List<AnaliseMare> analises = getAnalisesMare( codAnalise );
		
		if( estacoes.size() > 0 && analises.size() > 0 ) {
			List<Componente> componentes = getComponentes( codAnalise );
			return new ConstantesHarmonicas( estacoes.get(0), analises.get(0), componentes );
		} else return new ConstantesHarmonicas();
	}

	
	public void geraPrevisaoCombinada( String estacao, String dataInicial, String dataFinal, String arqPrevHoraria, String arqPrevMaxMin, Integer forceAnalise ) {
		String arqConst = sourceDir + "/constantes_" + estacao + ".txt";
		previsaoColunas( 1, estacao, dataInicial, dataFinal, targetDir, 1, arqConst, arqPrevHoraria, arqPrevMaxMin, forceAnalise );
		previsaoColunas( 1, estacao, dataInicial, dataFinal, targetDir, 2, arqConst, arqPrevHoraria, arqPrevMaxMin, forceAnalise );
	}
	
	private void previsaoColunas(int area, String codEstacao, String dataIni, String dataFim, String targetDir, int tipoSaida, String arqConst, 
			String arqPrevHoraria, String arqPrevMaxMin, Integer forceAnalise ) {
		
		int codAnalise = 0;
		if( forceAnalise != null ) {
			codAnalise = forceAnalise;
		} else {
			codAnalise = retornaCodigoAnalisePeriodoPadrao( codEstacao );			
		}
		logger.info("Codigo da analise: " + codAnalise );
		
		double z0 = retornaZ0Analise( codAnalise );									
		logger.info("Z-Zero: " + z0 );
		
		int numeroEstacao = retornaNumeroEstacao( codEstacao );
		logger.info("Numero estacao: " + numeroEstacao );
		
		if( geraArqConst ) {
			File fil = new File( arqConst );
			fil.delete();
			geraArquivoConstantesSisDll( arqConst, area, codEstacao, codAnalise ); 
		} else {
			logger.warn("Nao estou gerando o arquivo " + arqConst + " a pedido.");
		}
		
		String nivel = String.format("%010.2f", z0 ).replace(',', '.');
		String op = "N";
		String sim = "S";
		
		String[] dtIni = dataIni.split("/");
		String[] dtFim = dataFim.split("/");

		String di = formataDiaMes( dtIni[0] );
		String mi = formataDiaMes( dtIni[1] );
		String ai = formataDiaMes( dtIni[2] );

		String df = formataDiaMes( dtFim[0] );
		String mf = formataDiaMes( dtFim[1] );
		String af = formataDiaMes( dtFim[2] );
		
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy"); 
		String hoje = formato.format( new Date() );
		if( tipoSaida == 1 ) {
			previsaoHoraria( arqConst, arqPrevHoraria, String.valueOf(tipoSaida), di, mi, ai, df, mf, af, nivel, op, sim, hoje );
		}
		
		if( tipoSaida == 2 ) {
			previsaoMaxminExcel( arqConst, arqPrevMaxMin, String.valueOf(tipoSaida), di, mi, ai, df, mf, af, nivel, op, sim );
		}
		
	}

	
	private String formataDiaMes( String valor ) {
		return String.format("%02d", Integer.valueOf( valor ) );
	}

	
/*	
        character*150   arq_const       ! nome do arquivo de constantes
        character*1     tipo            ! se = 0 imprime preamar e baixamar
!c                                      ! se = 1 imprime alturas horarias
!c                                      ! se = 2 imprime ambos
        character*2     di,mi,df,mf
        character*4     ai,af
        character*10    nivel   
        character*1     op              ! se s deleta o arquivo de constantes

        CHARACTER*1     SIM             ! DESEJA GRAVAR ARQUIVO DE ALTURA E OU PREVISAO.
        character*150 arq_prev
        character*10 data_relatorio	
*/	
	public void previsaoHoraria(
			String arqConst, 
			String arqPrev, 
			String tipo, 
			String di, 
			String mi, 
			String ai, 
			String df, 
			String mf, 
			String af, 
			String nivel, 
			String op,
			String sim,
			String data_relatorio ) {
		try {
			logger.info("Gerando Previsao Horaria para " + di + "/" + mi + "/" + ai + " ate " + df + "/" + mf + "/" + af );
			logger.info(" > Constantes " + arqConst );
			logger.info(" > Saida " + arqPrev );
			previsaoDll.previsao_alturas_excel_(arqConst, arqPrev, tipo, di, mi, ai, df, mf, af, nivel, op );
			logger.info("Previsao gerada com sucesso");
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		
	}
	
	public void previsaoMaxminExcel(
			String arqConst, 
			String arqPrev, 
			String tipo, 
			String di, 
			String mi, 
			String ai, 
			String df, 
			String mf, 
			String af, 
			String nivel, 
			String op, 
			String sim ) {
		try {
			logger.info("Gerando Previsao Max/Min para " + di + "/" + mi + "/" + ai + " ate " + df + "/" + mf + "/" + af );
			logger.info(" > Constantes " + arqConst );
			logger.info(" > Saida " + arqPrev );
			previsaoDll.previsao_maxmin_excel_( arqConst, arqPrev, tipo, di, mi, ai, df, mf, af, nivel, op, sim );
			logger.info("Previsao gerada com sucesso");
		} catch ( Exception e ) {
			e.printStackTrace();
		}
	}
	
	
	@PostConstruct
	public void startup() {
		this.geraArqConst = true;
		logger.info("Carregando biblioteca de Previsao");
		logger.info( System.getProperty("java.library.path" ) );
		
		try {
			previsaoDll = (PrevisaoDLL)Native.loadLibrary( /*lib*/"previsao"/*.so*/, PrevisaoDLL.class); // libprevisao.so
			logger.info("Biblioteca de Previsao carregada.");
		} catch ( Exception e ) {
			logger.error( e.getMessage() );
		}
	}
	
	
	// Rotinas Genericas
	private int retornaCodigoAnalisePeriodoPadrao( String codEstacao ) {
		String sql = "select cod_analise_mares from sc_mare.vw_analise_mare where cod_estacao_maregrafica = ? and periodo_padrao = 'S'";
		int codEstacaoI = Integer.valueOf( codEstacao );
		Number number = jdbcTemplate.queryForObject(sql, new Object[] { codEstacaoI }, Integer.class );
		return (number != null ? number.intValue() : 0);
	}
	
	private double retornaZ0Analise( int codAnalise ) {
		String sql = "select z0 from sc_mare.vw_analise_mare where cod_analise_mares = ?";
		Number number = jdbcTemplate.queryForObject(sql, new Object[] { codAnalise }, Double.class );
		return (number != null ? number.doubleValue() : 0);
	}
	
	
	private int retornaNumeroEstacao( String codEstacao ) {
		String sql = "select num_estacao_maregrafica from sc_mare.tb_estacao_maregrafica where cod_estacao_maregrafica = ?";
		int codEstacaoI = Integer.valueOf( codEstacao );
		Number number = jdbcTemplate.queryForObject(sql, new Object[] { codEstacaoI }, Integer.class );
		return (number != null ? number.intValue() : 0);
	}

	
	private void geraArquivoConstantesSisDll( String arqConst, int area, String codEstacao, int codAnalise ) {
		logger.info("Gerando arquivo de constantes...");
		StringBuilder result = new StringBuilder();
		
		int codEstacaoI = Integer.valueOf( codEstacao );
		List<Estacao> estacoes = getEstacoes( codEstacaoI );
		logger.info("Estacoes encontradas: " + estacoes.size() );
		if( estacoes.size() > 0 ) {
			Estacao estacao = estacoes.get(0);
			logger.info("Estacao " + estacao.getNomeEstacaoMaregrafica() );
			
			List<AnaliseMare> analises = getAnalisesMare( codAnalise );
			
			if( analises.size() > 0 ) {
				AnaliseMare analise = analises.get(0);
				
				List<Componente> componentes = getComponentes( codAnalise );
				//int compAtt = atualizaNumComponentes( codAnalise );
				int compAtt = componentes.size();
				
				String z0F = String.format("%010.2f", analise.getZ0() ).replace(',', '.');
				String compAttF = String.format("%03d", compAtt);
				
				SimpleDateFormat formato = new SimpleDateFormat("ddMMyyyy"); 
				String dhIniF = formato.format( analise.getDataHoraInicio() );
				String dhFimF = formato.format( analise.getDataHoraFim() );
				
				String numEstacaoF = String.format("%05d", Integer.valueOf( estacao.getNumEstacaoMaregrafica() ) );
				String nomeEstacaoF = String.format("%1$-" + 38 + "s", estacao.getNomeEstacaoMaregrafica() );
				String fusoF = estacao.getFuso();
				
				String latF = estacao.getLatitude();
				String lonF = estacao.getLongitude();
				
				String constHeader = compAttF + z0F + dhIniF + dhFimF + numEstacaoF + nomeEstacaoF + latF + lonF + fusoF;
				
				result.append( constHeader );
				result.append("\n");
				
				
				
				StringBuilder compLine = new StringBuilder();
				for( Componente componente : componentes ) {
					compLine.append( String.valueOf( componente.getTipo() ) );
					compLine.append( String.format("%1$-" + 7 + "s", componente.getNome() ) );
					compLine.append( String.format("%011.7f", componente.getVelocidade() ).replace(',', '.') );
					
					
					compLine.append( formataIndice( componente.getIndice1() ) );
					compLine.append( formataIndice( componente.getIndice2() ) );
					compLine.append( formataIndice( componente.getIndice3() ) );
					compLine.append( formataIndice( componente.getIndice4() ) );
					compLine.append( formataIndice( componente.getIndice5() ) );
					compLine.append( formataIndice( componente.getIndice6() ) );
					compLine.append( formataIndice( componente.getIndice7() ) );
					compLine.append( formataIndice( componente.getIndice8() ) );
					compLine.append( formataIndice( componente.getIndice9() ) );
					compLine.append( formataIndice( componente.getIndice10() ) );
					compLine.append( formataIndice( componente.getIndice11() ) );
					compLine.append( formataIndice( componente.getIndice12() ) );
					compLine.append( formataIndice( componente.getIndice13() ) );
					compLine.append( formataIndice( componente.getIndice14() ) );
					
					compLine.append( String.format("%08.2f", componente.getH() ).replace(',', '.') );
					compLine.append( String.format("%08.2f", componente.getG() ).replace(',', '.') );
					
					result.append( compLine.toString() );
					result.append("\n");
					compLine.setLength( 0 );
				}
				
				
				
			} else {
				logger.error("Nenhuma analise encontrada.");
			}
		} else {
			logger.error("Nao foi possivel processar. Nenhuma estacao encontrada");
		}
		
		try {
			File file = new File( arqConst );
			try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
			    writer.write( result.toString() );
			}
		} catch( Exception e ) {
			logger.error( e.getMessage() );
			
		}
		
		System.out.println( result.toString() );
		
	}
	
	
	private List<AnaliseMare> getAnalisesMare( int codAnalise ) {
		String sqlAnalise = "select data_hora_inicio, data_hora_fim, z0, num_componentes from sc_mare.vw_analise_mare where cod_analise_mares = ?";
		List<AnaliseMare> analises = jdbcTemplate.query(sqlAnalise, new Object[] { codAnalise }, new AnaliseMareMapper() );
		logger.info("Analises encontradas: " + analises.size() );
		return analises;
	}


	private List<Estacao> getEstacoes( int codEstacao ){
		String sql = "select cod_estacao_maregrafica, num_estacao_maregrafica," + 
				"nome_estacao_maregrafica, latitude, longitude, fuso, tabua," + 
				"num_ana, fluviometrica, local_origem, cod_pais, instituicao," + 
				"identificacao_nivel_datum, data_referencia_datum," + 
				"elevacao_nivel_medio_mar_local, elevacao_nivel_medio_mar_ibge," + 
				"num_ana, fluviometrica, identificacao_rn_local, identificacao_rn_ibge " + 
				"from sc_mare.tb_estacao_maregrafica " + 
				"where cod_estacao_maregrafica = ?";
		List<Estacao> estacoes = jdbcTemplate.query(sql, new Object[] { codEstacao }, new EstacaoMapper() );
		return estacoes;
	}
	
	
	private List<Componente> getComponentes( int codAnalise ){
		logger.info("Selecionando componentes harmonicos da analise " + codAnalise );
		String sqlComponentes = "select ct.cod_analise_mares, ct.g, ct.h, cp.* from sc_mare.tb_constante_analise ct," +
		"(select * from sc_mare.tb_componente) as cp where cod_analise_mares = ? and ct.cod_componente = cp.cod_componente order by velocidade";
		List<Componente> componentes = jdbcTemplate.query(sqlComponentes, new Object[] { codAnalise }, new ComponenteMapper() );
		logger.info("Componentes encontrados: " + componentes.size() );
		return componentes;
	}

	
	/*
	private int atualizaNumComponentes( int codAnalise ) {
		String sql = "select count(*) as cont from sc_mare.tb_constante_analise where cod_analise_mares = ? and cod_componente > 6";
		Number number = jdbcTemplate.queryForObject(sql, new Object[] { codAnalise }, Integer.class );
		return (number != null ? number.intValue() : 0);
	}
	*/

	
	private String formataIndice( int indice ) {
		if( indice == 0 ) return "  ";
		if( String.valueOf( indice ).length() == 1 ) return " " + indice;
		return "" + indice;
	}
	
}

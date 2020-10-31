package br.mil.defesa.sisgeodef.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import br.mil.defesa.sisgeodef.misc.ColorData;
import br.mil.defesa.sisgeodef.misc.ColorHelper;
import br.mil.defesa.sisgeodef.misc.MetarData;
import br.mil.defesa.sisgeodef.services.AuthService;
import io.github.mivek.enums.CloudQuantity;
import io.github.mivek.enums.CloudType;
import io.github.mivek.enums.Descriptive;
import io.github.mivek.facade.MetarFacade;
import io.github.mivek.model.Cloud;
import io.github.mivek.model.Metar;
import io.github.mivek.model.WeatherCondition;

@RestController
@RequestMapping("/metar")
public class MeteoroCorController {
	
	@Value("${proxy.useProxy}")
	private boolean useProxy;	
	    
    
    @Autowired
    AuthService authService;

	private String doRequestGet( String url ) {
		
		String uri = "http://www.redemet.aer.mil.br/api/consulta_automatica/index.php?" + url;

		String responseBody = "";
		
		RestTemplate restTemplate;
		if( useProxy ) {
			restTemplate = new RestTemplate( authService.getFactory() );
		} else {
			restTemplate = new RestTemplate( );
		}
		
		
		try {
			ResponseEntity<String> result = restTemplate.getForEntity( uri, String.class);
			responseBody = result.getBody().toString();
		} catch (HttpClientErrorException e) {
		    responseBody = e.getResponseBodyAsString();
		} catch ( Exception ex) {
			return ex.getMessage();
		}
		return responseBody;
	}

	
	@RequestMapping(value = "/plain", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody List<MetarData> plainMetarData() {
		LocalDateTime dateStart = LocalDateTime.now().minusHours(4);
		DateTimeFormatter formatterStart = DateTimeFormatter.ofPattern("yyyyMMddHH");
		String startDate = dateStart.format(formatterStart);
		
		SimpleDateFormat formatterNow= new SimpleDateFormat("yyyyMMddHH");
		Date date = new Date( System.currentTimeMillis() );
		String endDate = formatterNow.format(date);		
		String url = "local=sbrj,sbgl,sbaf,sbsc,sbes,sbcb,sbme,sbcp&msg=metar&data_ini=" + startDate+ "&data_fim=" + endDate;
		String metarData = doRequestGet(url);
		
		String[] metars = metarData.split("\n");
		
		List<MetarData> metarList = new ArrayList<MetarData>();
		MetarFacade facade = MetarFacade.getInstance();
		for( String s : metars ) {
			String ss = s.substring(19, s.length() - 1);
			try {
				Metar mm = facade.decode( ss );
				MetarData md = new MetarData( mm );
				metarList.add( md );

			} catch ( Exception e ) {
				System.out.println("METAR Invalido: " + ss );
			}
		} 
		return metarList;
	}
	
	
	
	@RequestMapping(value = "/retrieve", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody List<MetarData> retrieveMetarData() {
		// http://www.redemet.aer.mil.br/api/consulta_automatica/index.php?local=sbrj,sbgl,sbaf,sbsc,sbes,sbcb,sbme,sbcp&msg=metar&data_ini=2019102111&data_fim=2019102114
		
		LocalDateTime dateStart = LocalDateTime.now().minusHours(4);
		DateTimeFormatter formatterStart = DateTimeFormatter.ofPattern("yyyyMMddHH");
		String startDate = dateStart.format(formatterStart);
		
		SimpleDateFormat formatterNow= new SimpleDateFormat("yyyyMMddHH");
		Date date = new Date( System.currentTimeMillis() );
		String endDate = formatterNow.format(date);		
		String url = "local=sbrj,sbgl,sbaf,sbsc,sbes,sbcb,sbme,sbcp&msg=metar&data_ini=" + startDate+ "&data_fim=" + endDate;
		String metarData = doRequestGet(url);
		
		String[] metars = metarData.split("\n");
		
		List<MetarData> metarList = new ArrayList<MetarData>();
		MetarFacade facade = MetarFacade.getInstance();
		for( String s : metars ) {
			try {
				System.out.println("------------------------------------------------------------------------");
				String theAp = s.substring(19, s.length() - 1);
				Metar mm = facade.decode( theAp );
				System.out.println("METAR: " + s );
				MetarData md = new MetarData( mm );
				System.out.println("Parametros: ");
				md.setCm( calcColor( md ) );
				metarList.add( md );
			} catch ( Exception e ) {
				System.out.println("------------------------------------------------------------------------");
				System.out.println("ERRO. A mensagem recebida da REDEMET foi:");
				System.out.println( s );
				System.out.println("------------------------------------------------------------------------");
				e.printStackTrace();
			}
		} 
		return metarList;
	}

	@RequestMapping(value = "/checkmetar", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody MetarData checkMetar( @RequestParam(value="icaoCode",required=true) String icaoCode  ) {
		MetarData md = null;
		try {
			MetarFacade facade = MetarFacade.getInstance();
			Metar metar = facade.retrieveFromAirport(icaoCode);
			md = new MetarData( metar );
			md.setCm( calcColor( md ) );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return md;
	}	
	
	@RequestMapping(value = "/validate", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody List<MetarData> validate(  ) {
		List<MetarData> metarList = new ArrayList<MetarData>();
		try {
			metarList.add( getTest("SBRJ 271100Z 13003KT 100V160 0500 R02/0450N R20/0550N FG VV001 13/13 Q1020") );  	// OK !
			metarList.add( getTest("SBRJ 271100Z /////KT 0500 FG VV/// 12/12 Q1022") );									// OK !
			metarList.add( getTest("SBRJ 271100Z 07003KT 9000 NSC 17/15 Q1006") );										// OK !
			
			metarList.add( getTest("SBRJ 271100Z AUTO 13003KT 070V160 8000 SCT001 OVC003 15/14 Q1021") );
			metarList.add( getTest("SBRJ 271100Z AUTO 17007KT 6000 OVC002 15/14 Q1020") );
			metarList.add( getTest("SBRJ 271100Z 36003KT 1000 -RA BR OVC005 16/15 Q1021") );


			/*
			metarList.add( getTest("SBRJ 221100Z 35006KT 9999 FEW020 SCT080 25/20 Q1012") );
			metarList.add( getTest("SBRJ 221100Z 35006KT 9999 FEW020TCU SCT080 25/20 Q1012") );
			metarList.add( getTest("SBRJ 221100Z 35006KT 9999 BKN020 SCT080 25/20 Q1012") );
			metarList.add( getTest("SBRJ 221100Z 35006KT 4000 +TSRA BKN020 OVC080 25/20 Q1012") );
			metarList.add( getTest("SBRJ 221100Z 35006KT 8000 -TSRA BKN020 OVC080 25/20 Q1012") );
			metarList.add( getTest("SBRJ 221100Z 35006KT 9000 -RA BKN020 OVC080 25/20 Q1012") );
			metarList.add( getTest("SBRJ 221100Z 35006KT 9999 -TS BKN020 OVC080 25/20 Q1012") );
			metarList.add( getTest("SBRJ 231100Z 20003KT 2000 DZ BR BKN005 OVC015 22/21 Q1016") ); // ( VM )
			metarList.add( getTest("SBRJ 231100Z 21007KT 9999 BKN008 BKN020 OVC080 22/21 Q1016") ); // ( AM )
			metarList.add( getTest("SBRJ 231100Z 15005KT 080V190 2000 -DZ OVC005 17/15 Q1022") ); // ( VM )
			metarList.add( getTest("SBRJ 231100Z AUTO VRB02KT 9999 FEW002 23/23 Q1011") ); // ( VM )
			metarList.add( getTest("SBRJ 231136Z AUTO 16003KT 9999 BKN002 23/23 Q1012") ); // ( VM )
			metarList.add( getTest("SBRJ 261800Z 08015KT CAVOK 80/20 Q1012") );
			*/ 
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return metarList;
	}	
	
	private MetarData getTest( String metarString  ) throws Exception {
		System.out.println("Testando: " + metarString );
		MetarFacade facade = MetarFacade.getInstance();
		Metar mm = facade.decode( metarString );
		MetarData md = new MetarData( mm );
		md.setCm( calcColor( md ) );
		return md;
	}
	
	
	private ColorData calcColor( MetarData metarData ) {
		Metar metar = metarData.getMetar();
		String neb = "***";
		String weatherCondition = "***";
		
		
		// Visibilidade
		int visib = 0;
		String vv = metar.getVisibility().getMainVisibility();
		if( vv.equals(">10km") ) { visib = 11000; } else visib = Integer.valueOf(  vv.replace("m", "")  );
		
		// condicao climatica
		for( WeatherCondition wc : metar.getWeatherConditions() ) {
			if( wc.getDescriptive() == Descriptive.THUNDERSTORM ) weatherCondition = "TS";
		}
		
		
		// Teto
		Integer teto = metar.getVerticalVisibility();
		String nuvem = "VV";
		
		if ( teto == null ) {
			// Nao tem Visibilidade vertical
			Cloud theCloud = null;
			for( Cloud cloud : metar.getClouds() ) {
				//if( ( cloud.getType() == CloudType.TCU ) ) neb = "TCU";
				if( ( cloud.getType() == CloudType.CB ) ) neb = "CB";
				//if ( cloud.getType()  )
				if( cloud.getQuantity() == CloudQuantity.BKN || cloud.getQuantity() == CloudQuantity.OVC ) {
					if( theCloud == null ) {
						theCloud = cloud;
					} else {
						if( theCloud.getHeight() > cloud.getHeight() ) {
							theCloud = cloud;
						}
					}
					teto = theCloud.getHeight();
					nuvem = theCloud.getQuantity().name();
				}
			}
		}
		
		if( metar.isCavok() ) {
			System.out.println("  > Retornou AZ por CAVOK.");
			return new ColorData( "AZ", teto, nuvem );
		}		
		
		return calcColor( visib, teto, metarData.getAlpha(), metarData.getBeta(), neb, weatherCondition, nuvem );
	}
	
	
	private ColorData calcColor( Integer visib, Integer teto, Integer alpha, Integer beta, String neb, String weatherCondition, String nuvem ) {
		System.out.println("  > " + visib +" "+teto+" "+alpha+" "+beta+" "+neb );

		String colorVisibilidade = null;
		String colorTeto = null;

		if( visib >= 10000)  colorVisibilidade = "AZ"; else 
		if( (visib < 10000) && ( visib >= 5000) )  colorVisibilidade = "VD"; else
		if( (visib < 50000) && ( visib >= alpha)  ) colorVisibilidade = "AM"; else
		if( (visib < alpha) && ( visib >= 1000)  ) colorVisibilidade = "AB"; else
		if( visib < 1000) colorVisibilidade = "VM";
		
		
		if( teto != null ) {
			if( teto >= 5000 ) colorTeto = "AZ"; else
			if( (teto < 5000) && (teto >= 1500) ) colorTeto = "VD"; else
			if( (teto < 1500) && (teto >= beta) ) colorTeto = "AM"; else
			if( (teto < beta) && (teto >= 200) ) colorTeto = "AB"; else
			if( teto < 200) colorTeto = "VM";
		}

		ColorHelper ch = new ColorHelper();
		String piorCor = ch.pegaPior( colorVisibilidade, colorTeto );
		
		System.out.println("  > Visibilidade: " + colorVisibilidade + "   Teto: " + colorTeto);
		System.out.println("  > Pior cenario: " + piorCor );
		
		String piorCorP1 = piorCor;
		if( (neb.equals("CB")) /*|| neb.equals("TCU")*/ ) {
			piorCorP1 = ch.pegaPior("AM", piorCor);
			System.out.println("  > Agravado por TCU/CB: " + piorCorP1 );
		}
		
		String piorCorP2 = piorCor;
		if( weatherCondition.equals("TS") ) {
			piorCorP2 = ch.pegaPior("AM", piorCor);
			System.out.println("  > Agravado por TS: " + piorCorP2 );
		}
		
		String finalColor = ch.pegaPior(piorCorP1, piorCorP2);
		System.out.println("  > RESULTADO FINAL ( entre '" + piorCorP1 + "' e '" + piorCorP2 + "' ) : "  + finalColor );

		return new ColorData( finalColor, teto, nuvem ); 
	}
	
	
}


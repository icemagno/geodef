package br.mil.defesa.sisgeodef.services;

import java.util.Locale;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.misc.PasswordQuality;
import me.gosimple.nbvcxz.Nbvcxz;
import me.gosimple.nbvcxz.resources.Configuration;
import me.gosimple.nbvcxz.resources.ConfigurationBuilder;
import me.gosimple.nbvcxz.scoring.Result;

@Service
public class PasswordService {
	private Configuration configuration;
	private Nbvcxz nbvcxz;
	private Logger logger = LoggerFactory.getLogger( PasswordService.class );

	
	@Value("${sisgeodef.passwordEntropy}")
	private Integer passwordEntropy;   	
	
	
	@PostConstruct
	public void startup() {
		/*
		List<Dictionary> dictionaryList = ConfigurationBuilder.getDefaultDictionaries();
		dictionaryList.add(new DictionaryBuilder()
		        .setDictionaryName("exclude")
		        .setExclusion(true)
		        .addWord(user.getFirstName(), 0)
		        .addWord(user.getLastName(), 0)
		        .addWord(user.getEmail(), 0)
		        .createDictionary());		
		*/
		configuration = new ConfigurationBuilder()
					.setLocale(Locale.forLanguageTag("pt"))
					//.setDictionaries( dictionaryList )
					.setMinimumEntropy( Double.valueOf( passwordEntropy )   )
					.createConfiguration();	
		nbvcxz = new Nbvcxz(configuration);
		
		logger.info("Validador de Senha Iniciado");
	}
	
	public PasswordQuality getScore( String password ) {
		Result rr = nbvcxz.estimate( password );
		int rv = rr.getBasicScore();
		return new PasswordQuality( rr.isMinimumEntropyMet(), rv );
	}

}

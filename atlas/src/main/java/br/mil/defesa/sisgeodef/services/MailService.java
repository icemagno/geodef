package br.mil.defesa.sisgeodef.services;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import br.mil.defesa.sisgeodef.dto.UserDTO;
import br.mil.defesa.sisgeodef.dto.UserLesserDTO;

@Service
public class MailService {

	@Value("${mailservice.origem}")
	private String fromMail;   	
	
	@Value("${mailservice.templateFolder}")
	private String templateFolder;   	

	
	@Autowired
	private JavaMailSender emailSender;	

	private File getFile( String name ) {
		File file = new File(templateFolder + "/" + name);
		return file;
	}
	
	
	public void sendConfirmacaoModificacao( UserLesserDTO user, UserLesserDTO author ) throws Exception {
		File textHtml =  getFile("modificacao.html");        
		InputStream inputStream = new FileInputStream( textHtml );
		String data = readFromInputStream( inputStream );
		String text = String.format(data, user.getFullName(), author.getFullName() );
		sendEmail( user.getEmail(), author.getEmail(), text );
	}
	
	
	public void sendConfirmacaoCadastro( UserLesserDTO user, UserLesserDTO author ) throws Exception {
		File textHtml =  getFile("cadastro.html");        
		InputStream inputStream = new FileInputStream( textHtml );
		String data = readFromInputStream( inputStream );
		String text = String.format(data, user.getFullName(), author.getFullName() );
		sendEmail( user.getEmail(), author.getEmail(), text );
	}
	
	
	
	public void testaEmail( String to ) throws Exception {
		File textHtml =  getFile("email.html");        
		InputStream inputStream = new FileInputStream( textHtml );
		String data = readFromInputStream( inputStream );
		String text = String.format(data, "Usuário de Teste" );
		sendEmail( to, "magno.mabreu@gmail.com", text );
	}

	
	private void sendEmail( String to, String from, String text ) throws Exception{
		
		/*
		 * 			EMAIL DA ORIGEM
		 */
		
		from = fromMail;
		
		MimeMessage message = emailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper( message, true );
		helper.setTo( to );
		helper.setFrom( from );
		helper.setSubject("Sistema de Geoinformação de Defesa");

		helper.setText( text , true);

		File logoDefesa = getFile("defesa-novo-hor.png");        
		helper.addInline("rightSideImage", logoDefesa );

		// Anexos
		//FileSystemResource file = new FileSystemResource( new File( pathToAttachment ) );
		//helper.addAttachment( "Invoice", file );		

		emailSender.send( message );
	}	


	private String readFromInputStream(InputStream inputStream)
			throws IOException {
		StringBuilder resultStringBuilder = new StringBuilder();
		try (BufferedReader br	= new BufferedReader(new InputStreamReader(inputStream))) {
			String line;
			while ((line = br.readLine()) != null) {
				resultStringBuilder.append(line).append("\n");
			}
		}
		return resultStringBuilder.toString();
	}


	public void sendPasswordReset( UserDTO user, String newPassword ) {
		try {
			File textHtml =  getFile("resetpassword.html");        
			InputStream inputStream = new FileInputStream( textHtml );
			String data = readFromInputStream( inputStream );
			String text = String.format(data, user.getFullName(), newPassword );
			sendEmail( user.getEmail(), user.getEmail(), text );
		} catch ( Exception e ) {
			e.printStackTrace();
		}
	}

}

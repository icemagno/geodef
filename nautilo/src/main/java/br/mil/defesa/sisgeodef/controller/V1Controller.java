package br.mil.defesa.sisgeodef.controller;

import br.mil.defesa.sisgeodef.misc.AreaMigracao;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.misc.FileImporter;
import br.mil.defesa.sisgeodef.misc.ImportObserver;
import br.mil.defesa.sisgeodef.model.ShapeFile;
import br.mil.defesa.sisgeodef.model.domain.Forma_Da_Boia;
import br.mil.defesa.sisgeodef.model.entity.Boia;
import br.mil.defesa.sisgeodef.model.entity.Boia_P;
import br.mil.defesa.sisgeodef.rabbit.JobInfoSender;
import br.mil.defesa.sisgeodef.repository.GenericRepository;
//import br.mil.defesa.sisgeodef.repository.GenericRepository;
import br.mil.defesa.sisgeodef.repository.ShapeFileRepository;
import java.util.List;
import java.util.Optional;
import java.util.logging.Level;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;

@RestController
@RequestMapping("/v1")
public class V1Controller {
	private static Logger log = LoggerFactory.getLogger( V1Controller.class );
	private String jobSerial;
	
	@Value("${nautilo.chartFolder}")
	private String chartFolder;	
        
        @Autowired
        ShapeFileRepository shapeFileRepository;
        
        @Autowired
        GenericRepository genericRepository;
	
	@Autowired
	JobInfoSender sender;	
        
        private ImportObserver observer;
	
	@RequestMapping(value = "/run", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public Boolean run( 
			@RequestParam(value="l", required = true) String l, 
			@RequestParam(value="r", required = true) String r, 
			@RequestParam(value="t", required = true) String t, 
			@RequestParam(value="b", required = true) String b,
			@RequestParam(value="jobSerial", required = true) String jobSerial ) {
		
            this.observer = new ImportObserver( jobSerial, sender );
            this.observer.notify("Iniciando o processo de migração dos dados do CHM.");
            
            AreaMigracao am = new AreaMigracao(l, r, t, b);  
            
            
            //log.info("Iniciando...");

            // Necessario criar uma forma de baixar os arquivos 
            // S-57 do CHM diretamente para a pasta 'chartFolder'
            // antes de importar os dados.
            // Atualmente os arquivos estao sendo colocados 'na mao'
            // na pasta compartilhada com a maquina host do 
            // Docker /srv/nautilo/gdal que vai cair na pasta /data do Nautilo

            this.jobSerial = jobSerial;
            System.out.println("JOB : " + jobSerial );


            try {
                FileImporter fd = new FileImporter( jobSerial, this.observer, this.chartFolder, this.shapeFileRepository );
                Thread thread = new Thread( fd );
                thread.start();


            } catch (Exception ex) {
                this.observer.notify("Erro ao iniciar o processo de migração dos dados do CHM.");
                java.util.logging.Logger.getLogger(V1Controller.class.getName()).log(Level.SEVERE, null, ex);

            }


            return true;
	}
	
	
		
	
	/*private void downloadList(  ) throws Exception {
		
		FileImporter fd = new FileImporter( this.chartFolder, this.observer, filesToProcess );
	    Thread thread = new Thread( fd );
	    thread.start();
	}	*/

	@RequestMapping(value = "/teste", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public Boolean insert( )  {
            Forma_Da_Boia f = new Forma_Da_Boia();
            f.setNome("Redonda");
            f.setDescricao("forma redonda");
            Integer id= 0;
            f.setId(id.longValue());
            
            
            
            Boia_P b = new Boia_P();
            b.setGeometriaAproximada(true);
            b.setFormaDaBoia(f);
            
            b.setGeometria("geometria");
            genericRepository.save(b);
            
            
            

            return true;
	}
	
	
	
}

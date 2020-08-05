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
import org.json.JSONObject;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.jdbc.core.JdbcTemplate;

@RestController
@RequestMapping("/v1/sistram")
public class V1SistramController {
	private static Logger log = LoggerFactory.getLogger(V1SistramController.class );
	private String jobSerial;
	
	@Autowired
	JdbcTemplate jdbcTemplate;	
        
	
	@RequestMapping(value = "/plataformas", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getPlataformas () {
            String query = "select json_build_object('data'::text, json_agg(row_to_json(p))) plataformas from sistram.plataformas p";
            
            String plataformas = jdbcTemplate.queryForObject(query, new Object[] {}, String.class);
            
            return plataformas;
	}
        
        
        @RequestMapping(value = "/scan-navios", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
	public String getSplataformas (@RequestParam("lat") String lat, @RequestParam("lon") String lon, @RequestParam("raio") String raio ) {
            
            String query = "" +
                        "SELECT \n" +
                        "	json_build_object('data'::text, json_agg(row_to_json(r))) navios\n" +
                        "FROM sistram.navios r\n" +
                        "WHERE ((ST_Distance(ST_MakePoint(lon::numeric, lat::numeric, 4326), \n" +
                        "ST_MakePoint("+lon+", "+lat+", 4326) \n" +
                        ")*100) * 0.539957) <= "+raio+"";
            
            System.out.println(query);
            
            String navios = jdbcTemplate.queryForObject(query, new Object[] {}, String.class);
            
            return navios;
	}
	
	
		
	
	
	
	
}

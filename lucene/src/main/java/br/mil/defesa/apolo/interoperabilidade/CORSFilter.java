package br.mil.defesa.apolo.interoperabilidade;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
public class CORSFilter extends OncePerRequestFilter {
    public final String HTTP_AUTH_TOKEN="SUvggMxMtfuWdW8NzHjB";
	//private AccessLogService accessLogService;

	
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

		/*
		if( accessLogService == null){
            ServletContext servletContext = req.getServletContext();
            WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContext);
            accessLogService = webApplicationContext.getBean(AccessLogService.class);
        }		
		
		AccessLogDTO rld = new AccessLogDTO( req );
		accessLogService.addAccessLog( rld );
		*/
        
    	response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Credentials", "true");
		response.setHeader("Access-Control-Allow-Methods", "POST, GET, PUT, OPTIONS, DELETE");
		response.setHeader("Access-Control-Max-Age", "3600");
                
        response.setHeader("Access-Control-Allow-Headers", "X-Requested-With, Content-Type, Authorization, Origin, Accept, Access-Control-Request-Method, Access-Control-Request-Headers");
        
        
        String auth = request.getHeader("auth-token");
    
        
        if(auth != null && auth.equals(HTTP_AUTH_TOKEN) ){
            filterChain.doFilter(request, response);
        } else{
            //response.sendError(405);
            filterChain.doFilter(request, response);
        }
        
        
        
	}	
	

}
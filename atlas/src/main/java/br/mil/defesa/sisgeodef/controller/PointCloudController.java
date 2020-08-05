package br.mil.defesa.sisgeodef.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import br.mil.defesa.sisgeodef.services.PointCloudService;

@RestController
public class PointCloudController {

	@Autowired
	PointCloudService pointCloudService; 
	
	// http://localhost:36215/pointcloud?l=-43.17423&t=-22.90506&r=-43.16921&b=-22.90928&count=100
	
	@RequestMapping(value = "/pointcloud", method = RequestMethod.GET, produces=MediaType.APPLICATION_JSON_UTF8_VALUE )
	public @ResponseBody String getCloud( @RequestParam(value="count",required=true) String count,
			@RequestParam(value="l",required=true) String l,
			@RequestParam(value="r",required=true) String r,
			@RequestParam(value="t",required=true) String t,
			@RequestParam(value="b",required=true) String b) {
		return pointCloudService.getCloud(count, l, r, t, b);
	}
	
}

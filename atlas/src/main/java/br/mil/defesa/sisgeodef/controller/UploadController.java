package br.mil.defesa.sisgeodef.controller;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import br.mil.defesa.sisgeodef.misc.StorageException;
import br.mil.defesa.sisgeodef.misc.UploadRequest;
import br.mil.defesa.sisgeodef.misc.UploadResponse;
import br.mil.defesa.sisgeodef.services.CsvImporterService;
import br.mil.defesa.sisgeodef.services.StorageService;

@RestController
@RequestMapping("/uploads")
public class UploadController {

	@Autowired
    private StorageService storageService;
	
	@Autowired
	private CsvImporterService csvImporterService;
	
    @CrossOrigin
    @PostMapping("/userdata")
    public ResponseEntity<UploadResponse> upload(
            @RequestParam("qqfile") MultipartFile file,
            @RequestParam("qquuid") String uuid,
            @RequestParam("qqfilename") String fileName,
            @RequestParam(value = "qqpartindex", required = false, defaultValue = "-1") int partIndex,
            @RequestParam(value = "qqtotalparts", required = false, defaultValue = "-1") int totalParts,
            @RequestParam(value = "qqtotalfilesize", required = false, defaultValue = "-1") long totalFileSize) {

        UploadRequest request = new UploadRequest(uuid, file);
        request.setFileName(fileName);
        request.setTotalFileSize(totalFileSize);
        request.setPartIndex(partIndex);
        request.setTotalParts(totalParts);

        String filePath = storageService.save(request);

        UploadResponse response = new UploadResponse( true );	
        response.setContent( csvImporterService.csvToJson( request, filePath ) );
        
        return ResponseEntity.ok().body( response );
    }    
    
    
    @ExceptionHandler(StorageException.class)
    public ResponseEntity<UploadResponse> handleException(StorageException ex) {
        UploadResponse response = new UploadResponse(false, ex.getMessage());
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
    }

    @CrossOrigin
    @DeleteMapping("/userdata/{uuid}")
    public ResponseEntity<Void> delete(@PathVariable("uuid") String uuid) {
        storageService.delete(uuid);
        return ResponseEntity.ok().build();
    }

    @CrossOrigin
    @PostMapping("/chunksdone")
    public ResponseEntity<Void> chunksDone(
            @RequestParam("qquuid") String uuid,
            @RequestParam("qqfilename") String fileName,
            @RequestParam(value = "qqtotalparts") int totalParts,
            @RequestParam(value = "qqtotalfilesize") long totalFileSize) {

        storageService.mergeChunks(uuid, fileName, totalParts, totalFileSize);

        return ResponseEntity.noContent().build();
    }
    
    
	
}

package br.mil.defesa.sisgeodef.services;

import br.mil.defesa.sisgeodef.misc.UploadRequest;

/**
 * Created by ovaldez on 11/13/16.
 */
public interface StorageService {
    String save(UploadRequest uploadRequest);
    void delete(String uuid);
    void mergeChunks(String uuid, String fileName, int totalParts, long totalFileSize);
}

package br.mil.defesa.sisgeodef.misc;

/**
 * Created by ovaldez on 11/13/16.
 */
public class StorageException extends RuntimeException {
	private static final long serialVersionUID = 1L;

	public StorageException(String message) {
        super(message);
    }

    public StorageException(String message, Throwable cause) {
        super(message, cause);
    }

}

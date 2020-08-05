package br.mil.defesa.sisgeodef.downloader;

public interface IDownloaderObserver {
	void notify( String message );
        void notify( String message, String detail );
}


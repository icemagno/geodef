package br.mil.defesa.sisgeodef.misc;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileImporter implements Runnable {
	private ImportObserver observer;
	private String chartFolder;
	private String l;
	private String r;
	private String t;
	private String b;

	public FileImporter( String l, String r, String t, String b,  String chartFolder, ImportObserver observer ) {

		this.observer = observer;
		this.chartFolder = chartFolder;
	}
	
	private void importCharts(  ) {
		observer.notify( "Importando ... " );
		
		try {			
        	List<String> args = new ArrayList<String>();
        	String ogr = chartFolder + "/ogr.sh";
        	args.add( ogr );
        	args.add( l );
        	args.add( r );
        	args.add( t );
        	args.add( b );

        	Process process = new ProcessBuilder( args ).directory( new File(chartFolder) ).start();
        	
			int returnCode = process.waitFor();
			observer.notify("Importacao retornou " + returnCode );
			
		} catch ( Exception e ) {
			observer.notify("Erro: " + e.getMessage() );
		}
			
		observer.notify("Fim da importacao.");
	}
	
	
	
	@Override
	public void run() {
		importCharts(  );
	}

}

package br.mil.defesa.sisgeodef.misc;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileImporter implements Runnable {
	private ImportObserver observer;
	private String demFiles;
	private List<File> filesToProcess;

	public FileImporter( String demFiles, ImportObserver observer, List<File> filesToProcess ) {
		this.filesToProcess = filesToProcess;
		this.observer = observer;
		this.demFiles = demFiles;
	}
	
	/*
	
		public class SaveQueryImage {
		  public static void main(String[] argv) {
		      System.out.println("Checking if Driver is registered with DriverManager.");
		
		      try {
		        //java.sql.DriverManager.registerDriver (new org.postgresql.Driver());
		        Class.forName("org.postgresql.Driver");
		      }
		      catch (ClassNotFoundException cnfe) {
		        System.out.println("Couldn't find the driver!");
		        cnfe.printStackTrace();
		        System.exit(1);
		      }
		
		      Connection conn = null;
		
		      try {
		        conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/mydb","myuser", "mypwd");
		        conn.setAutoCommit(false);
		
		        PreparedStatement sGetImg = conn.prepareStatement(argv[0]);
		
		        ResultSet rs = sGetImg.executeQuery();
		
				FileOutputStream fout;
				try
				{
					rs.next();
					fout = new FileOutputStream(new File(argv[1]) );
					fout.write(rs.getBytes(1));
					fout.close();
				}
				catch(Exception e)
				{
					System.out.println("Can't create file");
					e.printStackTrace();
				}
		
		        rs.close();
				sGetImg.close();
		        conn.close();
		      }
		      catch (SQLException se) {
		        System.out.println("Couldn't connect: print out a stack trace and exit.");
		        se.printStackTrace();
		        System.exit(1);
		      }
		  }
		}	
	*/
	private void importCharts(  ) {
		observer.notify("Importando arquivos...");
		
		// Para cada SHP encontrado, importa para o banco
		for ( File file : filesToProcess ) {
			observer.notify( file.getName() );
			
			try {			
	        	List<String> args = new ArrayList<String>();
	        	String ogr = demFiles + "/ogr.sh";
	        	args.add( ogr );
	        	args.add( file.getAbsolutePath() );

	        	observer.notify("Importando " + file.getName() );
	        	
	        	Process process = new ProcessBuilder( args ).directory( new File(demFiles) ).start();
	        	
				int returnCode = process.waitFor();
				observer.notify(" > Retornou: " + returnCode );
				
			} catch ( Exception e ) {
				observer.notify("Erro: " + e.getMessage() );
			}
			
			
		}
		observer.notify("Fim da importacao.");
	}
	
	
	
	@Override
	public void run() {
		importCharts(  );
	}

}

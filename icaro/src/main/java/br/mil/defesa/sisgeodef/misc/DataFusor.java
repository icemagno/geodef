package br.mil.defesa.sisgeodef.misc;

import org.json.JSONArray;
import org.json.JSONObject;

import br.mil.defesa.sisgeodef.controller.V1Controller;
import br.mil.defesa.sisgeodef.model.GeoAirport;
import br.mil.defesa.sisgeodef.repository.AerodromoRepository;

public class DataFusor implements Runnable {
	private V1Controller controller;
	private JSONObject featureCollection;
	private ImportObserver observer;
	private JSONObject featureCollectionHeli;
	private Cartas cartasList;
	private AerodromoRepository aerodromoRepository;
	
	public DataFusor( V1Controller controller, JSONObject featureCollection, JSONObject featureCollectionHeli, ImportObserver observer, 
			AerodromoRepository aerodromoRepository, Cartas cartasList) {
		this.controller = controller;
		this.featureCollection = featureCollection;
		this.observer = observer;
		this.featureCollectionHeli = featureCollectionHeli;
		this.aerodromoRepository = aerodromoRepository;
		this.cartasList = cartasList;
	}

	
	private ResultList parseFeatures( JSONArray features ) throws Exception {
		ResultList rl = new ResultList();
		for( int x=0; x < features.length(); x++   ) {
			
			JSONObject feature = features.getJSONObject( x );
			
			String coordinates = feature.getJSONObject("geometry").toString();  //.getString("coordinates");
			
			JSONObject properties = feature.getJSONObject("properties");
			GeoAirport gap = new GeoAirport( properties, coordinates );
			
			String icaoCode = gap.getLocalidadeId();
			String[] icaoCodes = icaoCode.split(",");
			icaoCode = icaoCodes[0];
			
			
			observer.notify("Processando " + icaoCode + " : " + gap.getNome() );

			// Adicionar as cartas deste aerodromo
			JSONArray cartas = cartasList.getCartas( icaoCode );
			gap.setCartas( cartas.toString() );
			
			// Ir no AIS WEB buscar complemento do aerodromo
			try {
				JSONObject aerodromo = controller.getDadosAerodromoAsJsonObject( icaoCode );
				gap.setAisAirport( aerodromo.toString() );
			} catch ( Exception e ) {
				observer.notify( " >  " + gap.getNome() + " nao foi encontrado na API do AIS WEB.");
			}

			
			try {
				JSONObject notam = controller.getNotamAsJsonObject( icaoCode );
				gap.setNotam( notam.toString() );
			} catch ( Exception e ) {
				observer.notify( " >  " + gap.getNome() + " nao foi encontrado na API do AIS WEB.");
			}
			
			
			rl.addAirport( gap );
			
			try {
				this.aerodromoRepository.save( gap );
			} catch ( Exception ex ) {
				observer.notify("Erro: " + ex.getMessage() );
			}
			
		}
		return rl;
		
	}
	
	private void execute() {
		
		try {
			ResultList aeroportos = parseFeatures( featureCollection.getJSONArray("features") );
			ResultList helipontos = parseFeatures( featureCollectionHeli.getJSONArray("features") ); 
			
			observer.notify("------------------ FIM ------------------");
			observer.notify("Total de " + aeroportos.getAirports().size() + " aeroportos e " + helipontos.getAirports().size() + " helipontos.");
			observer.notify("-----------------------------------------");
			
			// Funde helipontos com aeroportos
			aeroportos.addAll( helipontos );
			observer.notify("Total: " + aeroportos.getAirports().size() );
			
			// Fim! Agora voce tm um ResultList com todos os resultados e o banco de dados estah populado com eles.
			// ALERTA! Nao ha uma limpesa de banco antes da importacao !!!
			// Providenciar.
			
		} catch ( Exception e ) {
			observer.notify("Erro: " + e.getMessage() );
			e.printStackTrace();
		}
		
	}
	
	
	@Override
	public void run() {
		execute();
	}

}

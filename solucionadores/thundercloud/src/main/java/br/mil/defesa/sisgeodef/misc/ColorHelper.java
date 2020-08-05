package br.mil.defesa.sisgeodef.misc;

import java.util.ArrayList;
import java.util.List;

public class ColorHelper {
	private List<String> colors;

	public ColorHelper() {
		this.colors = new ArrayList<String>();
		this.colors.add("AZ");
		this.colors.add("VD");
		this.colors.add("AM");
		this.colors.add("AB");
		this.colors.add("VM");
	}

	private int getIndex( String color ) {
		return this.colors.indexOf(color);
	}
	
	public String pegaPior( String colorVisibilidade, String colorTeto ) {
		if( colorTeto == null ) return colorVisibilidade;
		int c1Indx = getIndex( colorVisibilidade );
		int c2Indx = getIndex( colorTeto );
		if( c1Indx < c2Indx ) return colorTeto;
		return colorVisibilidade;
	}
	
}

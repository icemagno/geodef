package br.com.cmabreu.external;

import com.sun.jna.Library;

public interface PrevisaoDLL extends Library {
	public void previsao_( String arq_const, String arq_prev, String tipo, String di, String mi, String ai, String df, String mf, String af, String nivel, String op, String sim, String data_relatorio );
	public void previsao_alturas_excel_( String arq_const, String arq_prev, String tipo, String di, String mi, String ai, String df, String mf, String af, String nivel, String op );
	public void previsao_maxmin_excel_( String arq_const, String arq_prev, String tipo, String di, String mi, String ai, String df, String mf, String af, String nivel, String op, String sim  );
	public void previsao_disquete_( String arq_const, String arq_prev_alt, String arq_prev_maxmin, String tipo, String di, String mi, String ai, String df, String mf, String af, String nivel, String op );
	public void tabua_( String arq_const, String arq_porto, String arq_tabua, String carta, String instituicao, String nome_porto, String ano_tabua );
	public void tabua_imp_( String arq_const, String arq_imp, String arq_temp, String carta, String instituicao, String nome_porto, String ano_tabua );
}

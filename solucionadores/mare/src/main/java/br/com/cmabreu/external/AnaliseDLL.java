package br.com.cmabreu.external;

import com.sun.jna.Library;

public interface AnaliseDLL extends Library {
	public void analise_( String arq_alt, String arq_const, String arq_reduc, String arq_relat, String arq_13_ciclos, String arq_9_ciclos, String klm1, String cons, String niveis, String del, String data_imp );
	public void nimed_( String arq_alt, String filtro, String listagem, String deleta, String grava, String arq_cotas, String dia_anter, String dia_poster, String arq_impre, String data_imp );
}

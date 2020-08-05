package br.mil.defesa.sisgeodef.misc;

import java.util.ArrayList;
import java.util.List;

public class ResultFileList {
	private List<ResultFile> files;
	private int size;
	
	public ResultFileList() {
		this.files = new ArrayList<ResultFile>();
	}
	
	public void addFile( ResultFile file ) {
		this.files.add(file);
		this.size = files.size();
	}

	public List<ResultFile> getList() {
		return this.files;
	}
	
	public int getSize() {
		return this.size;
	}
	
}

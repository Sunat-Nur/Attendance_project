package syst.code.service;

import java.sql.SQLException;
import java.util.List;

import syst.code.vo.CodeVO;

public interface CodeService {

	List<CodeVO> getAllCodeList();
	
	void updateCodes(List<CodeVO> codes) throws SQLException;
	
	boolean codeExists(Long code);
	
	void createCodes(List<CodeVO> codesToCreate) throws SQLException;

}

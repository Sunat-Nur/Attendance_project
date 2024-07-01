package syst.code.service.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ibatis.sqlmap.client.SqlMapClient;

import syst.code.dao.CodeDAO;
import syst.code.service.CodeService;
import syst.code.vo.CodeVO;



@Service("codeService")
public class CodeServiceImpl implements CodeService{

	@Autowired
	private CodeDAO codeDAO;

	@Autowired
	private SqlMapClient sqlMapClient;

	@Override
	public List<CodeVO> getAllCodeList() {
		return  codeDAO.getAllCodeList();
	}

	 public void updateCodes(List<CodeVO> codes) throws SQLException {
	        try {
	            sqlMapClient.startTransaction();
	            sqlMapClient.startBatch();

	            for (CodeVO code : codes) {
	                codeDAO.update(code);
	            }

	            sqlMapClient.executeBatch();
	            sqlMapClient.commitTransaction();
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            sqlMapClient.endTransaction();
	        }
	 }
	        

	@Override
	public boolean codeExists(Long code) {
	   // Assuming you have a method in your DAO to fetch a code by its identifier
	   CodeVO existingCode = codeDAO.selectCodeByCodeNumber(code);
	   return existingCode != null; // Returns true if the code exists, false otherwise
	}

	@Override
	public void createCodes(List<CodeVO> codesToCreate) throws SQLException {
        try {
            sqlMapClient.startTransaction();
            sqlMapClient.startBatch();

            for (CodeVO code : codesToCreate) {
                    codeDAO.insertCode(code);
            }

            sqlMapClient.executeBatch();
            sqlMapClient.commitTransaction();
        } catch (Exception e) {
        	e.printStackTrace();
        } finally {
            sqlMapClient.endTransaction();
        }
    }
}

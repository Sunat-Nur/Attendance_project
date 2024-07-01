package syst.code.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import syst.code.vo.CodeVO;

@Repository("codeDAO")
public class CodeDAO extends EgovAbstractDAO {

    // Retrieve all codes
    public List<CodeVO> getAllCodeList() {
        return (List<CodeVO>) list("code.getAllCodeList");
    }

    // Update a single code or multiple codes
    public void update(CodeVO updatedCode) {
        update("code.updateCode", updatedCode);
    }

    // Insert a new code
    public void insertCode(CodeVO newCode) {
        insert("code.createCode", newCode);
    }

    // Check if a code exists by its identifier
    public CodeVO selectCodeByCodeNumber(Long code) {
        return (CodeVO) select("code.selectCodeByCodeNumber", code);
    }
}

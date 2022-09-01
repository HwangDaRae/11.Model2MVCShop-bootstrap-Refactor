package com.model2.mvc.service.upload.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.upload.UploadDao;

@Repository("UploadDaoImpl")
public class UploadDaoImpl implements UploadDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public UploadDaoImpl() {
		System.out.println(getClass() + " default Constructor");
	}

	@Override
	public void addUpload(Upload upload) throws Exception {
		System.out.println(getClass() + ".addUpload(Upload upload) start...");
		sqlSession.insert("UploadMapper.addUpload", upload);
	}

	@Override
	public List<Upload> getUploadFile(String fileNo) throws Exception {
		System.out.println(getClass() + ".getUpload(String fileNo) start...");
		return sqlSession.selectList("UploadMapper.getUploadFile", fileNo);
	}

	@Override
	public void deleteUpload(String fileNo, String deleteFileName) throws Exception {
		System.out.println(getClass() + ".deleteUpload(String fileNo, String deleteFileName) start...");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("fileNo", fileNo);
		map.put("deleteFileName", deleteFileName);
		sqlSession.delete("UploadMapper.deleteUpload", map);
	}

}

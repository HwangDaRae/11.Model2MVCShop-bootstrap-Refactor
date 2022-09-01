package com.model2.mvc.service.upload.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.service.domain.Upload;
import com.model2.mvc.service.upload.UploadDao;
import com.model2.mvc.service.upload.UploadService;

@Service("uploadServiceImpl")
public class UploadServiceImpl implements UploadService {
	
	@Autowired
	@Qualifier("UploadDaoImpl")
	private UploadDao UploadDaoImpl;

	public UploadServiceImpl() {
		System.out.println(getClass() + " default Constructor");
	}

	//상품 추가, 수정 할 때 쓴다
	@Override
	public void addUpload(Upload upload) throws Exception {
		System.out.println(getClass() + ".addUpload(Upload upload) start...");
		UploadDaoImpl.addUpload(upload);
	}

	//list display 할 때 많이 사용된다
	@Override
	public List<Upload> getUploadFile(String fileNo) throws Exception {
		System.out.println(getClass() + ".getUploadFile(String fileNo) start...");
		return UploadDaoImpl.getUploadFile(fileNo);
	}

	//파일 업데이트 할 때 먼저 fileNo에 맞는 데이터를 전제 삭제한다
	@Override
	public void deleteUpload(String fileNo, String deleteFileName) throws Exception {
		System.out.println(getClass() + ".deleteUpload(String fileNo, String deleteFileName) start...");
		UploadDaoImpl.deleteUpload(fileNo, deleteFileName);
	}

}

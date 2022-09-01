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

	//��ǰ �߰�, ���� �� �� ����
	@Override
	public void addUpload(Upload upload) throws Exception {
		System.out.println(getClass() + ".addUpload(Upload upload) start...");
		UploadDaoImpl.addUpload(upload);
	}

	//list display �� �� ���� ���ȴ�
	@Override
	public List<Upload> getUploadFile(String fileNo) throws Exception {
		System.out.println(getClass() + ".getUploadFile(String fileNo) start...");
		return UploadDaoImpl.getUploadFile(fileNo);
	}

	//���� ������Ʈ �� �� ���� fileNo�� �´� �����͸� ���� �����Ѵ�
	@Override
	public void deleteUpload(String fileNo, String deleteFileName) throws Exception {
		System.out.println(getClass() + ".deleteUpload(String fileNo, String deleteFileName) start...");
		UploadDaoImpl.deleteUpload(fileNo, deleteFileName);
	}

}

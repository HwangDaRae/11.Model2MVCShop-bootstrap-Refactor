package com.model2.mvc.framework;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.util.HttpUtil;


public class ActionServlet extends HttpServlet {
	
	private RequestMapping mapper;

	@Override
	public void init() throws ServletException {
		super.init();
		String resources=getServletConfig().getInitParameter("resources");
		//web.xml�� �ִ� init �����͸� mapping�ؼ� map���� ������ �ִ� RequestMapping �ν��Ͻ��� �ްڴ�
		mapper=RequestMapping.getInstance(resources);
	}

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("[ActionServlet service() start...]");
		
		String url = request.getRequestURI();
		String contextPath = request.getContextPath();
		//URL => IP:��Ʈ��ȣ/context root/a folder/b folder/login.do
		//contextPath => /context root
		//path => /a folder/b folder/login.do
		String path = url.substring(contextPath.length());
		System.out.println(path);
		
		try{
			//path�� ���ε� Action�� �������ڴ�
			Action action = mapper.getAction(path);
			//�� Action�� GenericServlet �޼ҵ�� ServletContext�� ��� ������ �ְڴ�
			action.setServletContext(getServletContext());
			
			//�� Action�� ������������ �ִ� request, response�� �ְڴ�
			String resultPage=action.execute(request, response);
			String result=resultPage.substring(resultPage.indexOf(":")+1);
			
			//Navigation:/�̵��� ����
			if(resultPage.startsWith("forward:"))
				HttpUtil.forward(request, response, result);
			else
				HttpUtil.redirect(response, result);
			
		}catch(Exception ex){
			ex.printStackTrace();
		}
		System.out.println("[ActionServlet service() end...]");
	}
} 
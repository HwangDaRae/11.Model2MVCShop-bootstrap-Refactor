package com.model2.mvc.common.util;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

/*
 * FileName : MyBatisTestApp04.java
  */
public class SqlSessionFactoryBean {
	
	///main method
	public static SqlSession getSqlSession() throws IOException{
		
		//==> 1. xml metadata �д� Stream ����
		Reader reader = Resources.getResourceAsReader("config/mybatis-config01.xml");
		
		//==> 2. Reader ��ü�� �̿� xml metadata �� ������ ���� ������ ����, ��밡���� 
		//==>     SqlSession�� �����ϴ� SqlSessionFactory  instance ����
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		//==>3. SqlSessionFactory �� ���� autoCommit true �� SqlSession instance ����
		SqlSession sqlSession = sqlSessionFactory.openSession(true);
		
		return sqlSession;
	}//end of getSqlSession()
	
	public static void printList(List<Object> list) {
		for (int i = 0; i < list.size(); i++) {
			System.out.println("<" + ( i+1 ) + "> ��° ȸ�� : " + list.get(i).toString());
		}
		System.out.println("\n");
	}
}//end of class
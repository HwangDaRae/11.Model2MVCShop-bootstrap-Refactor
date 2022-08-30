package com.model2.mvc.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;

//XML�� ���������� aspect�� ����
public class LogAspectJ {
	
	public LogAspectJ() {
		System.out.println("::LogAspectJ Default Constructor");
	}
	
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable {
		System.out.println("\n==========================================================");
		System.out.println("[Around before]" + getClass() + ".invoke() start...");
		System.out.println("[Around before] Ÿ�� ��ü : " + joinPoint.getTarget().getClass().getName());
		System.out.println("[Around before] Ÿ�� ��ü�� ȣ�� �� method : " + joinPoint.getSignature().getName());
		if(joinPoint.getArgs().length != 0) {
			System.out.println("Around before] Ÿ�� ��ü�� ȣ���� method�� ���޵Ǵ� ���� : " + joinPoint.getArgs()[0]);
		}
		System.out.println("==========================================================");
		
		//Ÿ�� ��ü�� Method�� ȣ���ϴ� �κ�
		Object obj = joinPoint.proceed();

		System.out.println("==========================================================");
		System.out.println("[Around after] Ÿ�� ��ü�� ȣ�� �� return value : " + obj);
		System.out.println("[Around after]" + getClass() + ".invoke() end...");
		System.out.println("==========================================================\n");
		return obj;
	}

}

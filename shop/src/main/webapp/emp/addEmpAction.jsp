<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	//사원 추가 폼에서 입력 값 받아오기
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");
	
	//디버깅
	System.out.println(empId);
	System.out.println(empPw);
	System.out.println(empName);
	System.out.println(empJob);
	System.out.println(hireDate);

	
	//디비연결
	int row = EmpDAO.addEmp(empId, empPw, empName, empJob, hireDate);
	
	
	
	
	if(row  != 0){
		System.out.println("사원등록 성공");
		response.sendRedirect("./empList.jsp");
		//가입 성공시 grade = 0, active = OFF로 생성 -> 관리자가 active On해줘야 접속 가능
	}else{
		System.out.println("등록 실패 - 오류 발생");
	}
	
	
	
%>

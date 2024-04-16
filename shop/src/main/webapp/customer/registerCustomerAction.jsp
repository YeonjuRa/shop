<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>

<%
	//회원가입 폼에서 입력 값 받아오기
	String mailIdChecked = request.getParameter("mailIdChecked");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	//디버깅
	System.out.println(mailIdChecked);
	System.out.println(pw);
	System.out.println(name);
	System.out.println(birth);
	System.out.println(gender);

	
	//디비연결
	int row = CustomerDAO.registerCustomer(mailIdChecked, pw, name, birth, gender);
	
	if(row  != 0){
		System.out.println("회원가입 성공");
		response.sendRedirect("./mainCustomer.jsp");
	}else{
		System.out.println("회원가입 실패 - 오류 발생");
	}
	
	
	
%>
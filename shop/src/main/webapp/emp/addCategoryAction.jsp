<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="shop.dao.*" %>
<%

	//인정분기
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	
	//요청분석
	String category = request.getParameter("category");
	
	int row = CategoryDAO.addCategory(category);
	if(row != 0){
		System.out.println("카테고리 추가 성공");
		response.sendRedirect("./categoryList.jsp");
	}else{
		System.out.println("카테고리 추가 실패");
	}












%>
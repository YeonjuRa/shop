<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%

	String id = request.getParameter("id");
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
	

	int row = CustomerDAO.updatePw(id, oldPw, newPw);
	
	if(row != 0){
		System.out.println("비밀번호 변경 성공");
		response.sendRedirect("/shop/customer/customerOne.jsp?id="+id);
	}else{
		System.out.println("비밀번호 변경 실패");
		response.sendRedirect("/shop/customer/customerOne.jsp?id="+id);
	}




%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	session.invalidate(); //세션공간 초기화 (포맷)

	response.sendRedirect("./mainCustomer.jsp");


%>
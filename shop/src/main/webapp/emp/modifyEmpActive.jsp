<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>


<%
	
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	if(active.equals("OFF")){
		active="ON";
	}else{
		active="OFF";
	}
	
	int row = EmpDAO.modifyEmpActive(empId, active);
	
	if(row != 0){
		System.out.println("변경 성공");
		response.sendRedirect("./empList.jsp");
	}else{
		System.out.println("변경 실패");
		response.sendRedirect("./empList.jsp");
	}
	
	
	



%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	if(active.equals("OFF")){
		active="ON";
	}else{
		active="OFF";
	}

	PreparedStatement updateStmt = null;
	String updateSql = "update emp set active = ? where emp_id = ?";
	updateStmt = con.prepareStatement(updateSql);
	updateStmt.setString(1,active);
	updateStmt.setString(2, empId);
	System.out.println(updateStmt);
	
	int row = updateStmt.executeUpdate();
	if(row != 0){
		System.out.println("변경 성공");
		response.sendRedirect("./empList.jsp");
	}else{
		System.out.println("변경 실패");
		response.sendRedirect("./empList.jsp");
	}
	
	
	



%>

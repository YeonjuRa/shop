<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

	//인정분기
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	
	//요청분석
	String category = request.getParameter("category");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	PreparedStatement stmt = null;

	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "insert into category (category,create_date) values(?,now())";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,category);
	System.out.println(stmt);

	int row = stmt.executeUpdate();
	if(row != 0){
		System.out.println("카테고리 추가 성공");
		response.sendRedirect("./categoryList.jsp");
	}else{
		System.out.println("카테고리 추가 실패");
	}












%>
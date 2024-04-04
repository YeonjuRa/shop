<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>

<%

	//인정분기
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	
	//요청분석
	String category = request.getParameter("category");
	System.out.println(category);
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	PreparedStatement stmt = null;

	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "delete from category where category =?";
	//넘어온 카테고리명과 일치하는 행만 삭제
	stmt = con.prepareStatement(sql);
	stmt.setString(1,category);
	
	int row = stmt.executeUpdate();
	if(row != 0){
		System.out.println("카테고리 삭제 성공");
		response.sendRedirect("./categoryList.jsp");
	}else{
		System.out.println("카테고리 삭제 실패");
		response.sendRedirect("./categoryList.jsp");
	}
	
	
	//emp 테이블에서 아이디 비번 일치하는 지 확인 하고
	//일치하면 삭제 버튼 활성화-> 삭제하기
	




%>


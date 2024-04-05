<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%
	
	//아이디+비번 확인하기 + 상품 번호 받아오기
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	
	//요청분석
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "select emp_id empId, emp_name empName from emp where active = 'ON' and emp_id = ? and emp_pw= password(?)";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,empId);
	stmt.setString(2,empPw);
	rs = stmt.executeQuery();


	
	if(rs.next()){
		//읽어올 행이 있다 -> 아이디와 비번이 일치하는 직원이다 -> 삭제 가능 -> ck = T
		response.sendRedirect("/shop/emp/deleteGoodsForm.jsp?goodsNo="+goodsNo+"&ck=T");
	}else{
		//반대면 ck = F
		response.sendRedirect("/shop/emp/deleteGoodsForm.jsp?goodsNo="+goodsNo+"&ck=F");
	}

%>
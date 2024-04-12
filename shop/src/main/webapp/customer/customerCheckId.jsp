<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%

	
	//아이디 중복확인하기
	String mailId = request.getParameter("mailId");
	
	
	//요청분석
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "select mail  from customer where mail = ?";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,mailId);
	rs = stmt.executeQuery();


	
	if(rs.next()){
		//읽어올 행이 있다 -> 아이디가 중복되었다 -> 해당 아이디로 가입 불가능 -> check = F
		response.sendRedirect("/shop/customer/registerCustomerForm.jsp?id="+mailId+"&ck=F");
	}else{
		//반대면 해당 아이디로 가입 가능 -> check = T
		response.sendRedirect("/shop/customer/registerCustomerForm.jsp?id="+mailId+"&ck=T");
	}
	
//아이디 중복확인//
//1.회원가입 페이지에서 아이디값 받아오기 
//2.checkId 페이지에서 디비와 비교 후 중복확인 -> check=true or false 로 분기 -->//

%>









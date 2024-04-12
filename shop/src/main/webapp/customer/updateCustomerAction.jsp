<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>


<!-- update할 값 가져오기 -->
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));


%>
<!-- model Layer -->
<%	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	
	PreparedStatement stmt = null;
	
	String sql = "update customer set name=?,birth=?,gender=?, update_date=now() where mail=?";
	stmt = con.prepareStatement(sql);
	
	stmt.setString(1,name);
	stmt.setString(2,birth);
	stmt.setString(3,gender);
	stmt.setString(4,id);
	
	System.out.println(stmt +"stmt 확인 --> updateCustomerAction");
	
	int row = stmt.executeUpdate();
	if(row != 0){ 
		System.out.println("회원 정보 업데이트 완료");
		response.sendRedirect("/shop/customer/customerOne.jsp?id="+id);
	}else{
		System.out.println("회원 업데이트 실패");
		response.sendRedirect("/shop/customer/customerOne.jsp?id="+id);
	}
%>
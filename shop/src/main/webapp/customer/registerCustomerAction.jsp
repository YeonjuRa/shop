<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%
	//회원가입 폼에서 입력 값 받아오기
	String mailId = request.getParameter("mailId");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	//디버깅
	System.out.println(mailId);
	System.out.println(pw);
	System.out.println(name);
	System.out.println(birth);
	System.out.println(gender);

	
	//디비연결
	//sql -> insert into (customer mail,pw,name, birth,gender,update_date,create_date) values (?,?,?,?,?,now(),now())
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	PreparedStatement stmt = null;
	
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "insert into customer (mail,pw,name, birth,gender,update_date,create_date) values (?,password(?),?,?,?,now(),now())";
	stmt = con.prepareStatement(sql);
	
	stmt.setString(1, mailId);
	stmt.setString(2, pw);
	stmt.setString(3, name);
	stmt.setString(4, birth);
	stmt.setString(5, gender);
	
	int row = stmt.executeUpdate();
	if(row  != 0){
		System.out.println("회원가입 성공");
		response.sendRedirect("./mainCustomer.jsp");
	}else{
		System.out.println("회원가입 실패 - 오류 발생");
	}
	
	
	
%>
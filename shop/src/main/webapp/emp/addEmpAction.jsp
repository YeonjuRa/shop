<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%
	//사원 추가 폼에서 입력 값 받아오기
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	String name = request.getParameter("name");
	String dmt = request.getParameter("dmt");
	String hireDate = request.getParameter("hireDate");
	
	//디버깅
	System.out.println(empId);
	System.out.println(empPw);
	System.out.println(name);
	System.out.println(dmt);
	System.out.println(hireDate);

	
	//디비연결
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	PreparedStatement stmt = null;
	
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "insert into emp (emp_id,emp_pw,emp_name, emp_job,hire_date,update_date,create_date) values (?,password(?),?,?,?,now(),now())";
	stmt = con.prepareStatement(sql);
	
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	stmt.setString(3, name);
	stmt.setString(4, dmt);
	stmt.setString(5, hireDate);
	
	int row = stmt.executeUpdate();
	if(row  != 0){
		System.out.println("사원등록 성공");
		response.sendRedirect("./empList.jsp");
		//가입 성공시 grade = 0, active = OFF로 생성 -> 관리자가 active On해줘야 접속 가능
	}else{
		System.out.println("등록 실패 - 오류 발생");
	}
	
	
	
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
%>
<!-- update할 값 가져오기 -->
<%
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));
	
	
%>
<!-- model Layer -->
<%	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	String empId = request.getParameter("empId");
	String empName = request.getParameter("name");
	String dmt = request.getParameter("dmt");
	String hireDate = request.getParameter("hireDate");
	
	
	PreparedStatement stmt = null;
	
	String sql = "update emp set emp_name=?,emp_job=?,hire_date=?, update_date=now() where emp_id=?";
	stmt = con.prepareStatement(sql);
	
	stmt.setString(1,empName);
	stmt.setString(2,dmt);
	stmt.setString(3,hireDate);
	stmt.setString(4,empId);
	
	System.out.println(stmt +"stmt 확인 --> updateEmpAction");
	
	int row = stmt.executeUpdate();
	if(row != 0){ 
		System.out.println("사원 정보 업데이트 완료");
		response.sendRedirect("./empOne.jsp?empId="+empId);
	}else{
		System.out.println("사원 정보 업데이트 실패");
		response.sendRedirect("/shop/emp/updateEmpForm.jsp");
	}
%>
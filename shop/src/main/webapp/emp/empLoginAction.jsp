<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>

<%
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}

	//아이디, 비번 값 가져오기 -> 

	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	/* select emp_id empId from emp where active-'ON' and emp_id =? and emp_Pw = password(?);
	
	실패 /emp/empLoginForm.jsp
	성공 /emp/empList.jsp
	*/
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "select emp_id empId from emp where active = 'ON' and emp_id = ? and emp_pw= password(?)";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,empId);
	stmt.setString(2,empPw);
	rs = stmt.executeQuery();
	
	if(rs.next()){
		System.out.println("로그인 성공 아이디:" + rs.getString("empId"));
		session.setAttribute("loginEmp",rs.getString("empId"));
		response.sendRedirect("./empList.jsp");
	}else{
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg);
	}
	

%>

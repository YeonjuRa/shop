<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>
<%
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	//디비 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	//총 책임자 제외 전체목록 출력  --> 팀장관리자는 ON OFF안해줘도 되니깐
	String sql = "select * from emp where emp_id not in('admin')"; 
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();
	

	
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>사원목록</h1>
	<div>로그인 성공 확인</div>
	<table>
		<tr>
			<td>Active</td>
			<td>emp_id</td>
			<td>emp_name</td>
			<td>emp_job</td>
			<td>hire_date</td>
			<td>update_date</td>
			<td>create_date</td>	
		</tr>
		<tr>
			<%
				while(rs.next()){
			%>
				<td><a href="./modifyEmpActive.jsp?empId=<%=rs.getString("emp_id")%>&active=<%=rs.getString("active")%>"><%=rs.getString("active")%></a></td>
				<td><%=rs.getString("emp_id")%></td>
				<td><%=rs.getString("emp_name")%></td>
				<td><%=rs.getString("emp_job")%></td>
				<td><%=rs.getString("hire_date")%></td>
				<td><%=rs.getString("update_date")%></td>
				<td><%=rs.getString("create_date")%></td>
		</tr>
			<% 
				}
			
			
			%>
		
		
	</table>
</body>
</html>
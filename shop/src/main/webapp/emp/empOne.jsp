<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	

	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));


%>
<%
	//emp 테이블에서 가입시 입력한 정보 가져와서 채우기
	
	String empId = request.getParameter("empId");
	//id 기준
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select * from emp where emp_id = ?";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,empId);
	rs = stmt.executeQuery();
	
	//리스트에 넣기
		ArrayList<HashMap<String,Object>> empUpdateInfo = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> empInfo = new HashMap<String,Object>();
		
		empInfo.put("empId",rs.getString("emp_id"));
		empInfo.put("grade", rs.getInt("grade"));
		empInfo.put("empName", rs.getString("emp_name"));
		empInfo.put("empJob", rs.getString("emp_job"));
		empInfo.put("hireDate", rs.getString("hire_date"));
		empInfo.put("updateDate", rs.getString("update_date"));
		empInfo.put("createDate", rs.getString("create_date"));
		
		
		
		empUpdateInfo.add(empInfo);
		
	}
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 정보 보기</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	<h4>사원 정보 보기</h4>
	
	<table>
	<%
		for(HashMap c : empUpdateInfo){
	%>
		<tr>
			<td>ID : </td>
			<td><%=(String) c.get("empId")%></td>
		</tr>
		
		<tr>
			<td>grade : </td>
			<td><%=(Integer) c.get("grade")%></td>
		</tr>
		<tr>
			<td>Name :</td>
			<td><%=(String) c.get("empName")%></td>
		</tr>
		<tr>
			<td>Department :</td>
			<td><%=(String) c.get("empJob")%></td>
		</tr>
		<tr>
			<td>Hire Date :</td>
			<td><%=(String) c.get("hireDate")%></td>
		</tr>
		<tr>
			<td>update Date :</td>
			<td><%=(String) c.get("updateDate")%></td>
		</tr>
		<tr>
			<td>create Date :</td>
			<td><%=(String) c.get("createDate")%></td>
		</tr>
	
	
	<% 
		}
	
	%>
	</table> 
	
	<div><a href="./updateEmpForm.jsp?empId=<%=(String)loginMember.get("empId")%>">사원 정보 수정하기</a></div>
	&#127826
	
</body>
</html>
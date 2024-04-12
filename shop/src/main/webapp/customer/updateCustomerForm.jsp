<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
	//emp 테이블에서 가입시 입력한 정보 가져와서 채우기
	
	String id = request.getParameter("id");
	//id 기준
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select * from customer where mail = ?";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,id);
	rs = stmt.executeQuery();
	
	//리스트에 넣기
		ArrayList<HashMap<String,Object>> cusUpdateInfo = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> cusInfo = new HashMap<String,Object>();
		
		
		
		cusInfo.put("id", rs.getString("mail"));
		cusInfo.put("name", rs.getString("name"));
		cusInfo.put("birth", rs.getString("birth"));
		cusInfo.put("gender", rs.getString("gender"));
		cusInfo.put("updateDate", rs.getString("update_date"));
		cusInfo.put("createDate", rs.getString("create_date"));
		
		
		
		cusUpdateInfo.add(cusInfo);
		
	}
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보 수정</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/customer/customerMenu.jsp"></jsp:include>s
	<form method="post" action="/shop/customer/updateCustomerAction.jsp">
	<table>
	<%
		for(HashMap c : cusUpdateInfo){
	%>
		<tr>
			<td>ID (Mail) : </td>
			<td><input type="text" name="id" value="<%=(String) c.get("id")%>" readonly></td>
		</tr>
		
		<tr>
			<td>Name : </td>
			<td><input type="text" name="name" value="<%=(String) c.get("name")%>"></td>
		</tr>
		<tr>
			<td>Birth :</td>
			<td><input type="date" name="birth" value="<%=(String) c.get("birth")%>"></td>
		</tr>
		<tr>
			<td>gender :</td>
			<td>
				<select name="gender">
					<option value="<%=(String) c.get("gender")%>"><%=(String) c.get("gender")%></option>
					<option value="남">남</option>
					<option value="여">여</option>
					
				
				</select>
	
		</td>
		</tr>
	
	
	
	<% 
		}
	
	%>
	
	</table> 
	<div style="margin:10px"><button type="submit" class="btnn" >정보 수정하기</button></div>
	&#127826
	</form>
</body>
</html>
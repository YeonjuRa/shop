<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import ="shop.dao.*" %>

<%
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginCustomer.jsp");
		return;
	}
	
	String id = request.getParameter("id");
	
	HashMap<String,Object> c = CustomerDAO.cusInfo(id);

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
	<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	<form method="post" action="/shop/customer/updateCustomerAction.jsp">
	<table class="table table-hover">
	
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
	
	
	
	
	</table> 
	<div style="margin:10px"><button type="submit" class="btnn" >정보 수정하기</button></div>
	&#127826
	</form>
		<jsp:include page="/customer/footer.jsp"></jsp:include>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	
	String id = request.getParameter("id");

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	
	<form method="post" action="/shop/customer/editPwAction.jsp">
		아이디 : <input name="id" type="text" value="<%=id%>" readonly>
		현재 비밀번호 : <input type="password" name="oldPw">
		새로운 비밀번호 : <input type="password" name="newPw">
		<button type="submit">비밀번호 변경</button>
	</form>
	<div><a href="/shop/customer/customerOne.jsp?id=<%=id%>">돌아가기</a></div>
</body>
</html>
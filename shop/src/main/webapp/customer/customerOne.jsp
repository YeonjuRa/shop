<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="shop.dao.*" %>
<%@ page import="java.util.*" %>
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));


%>
<%
	//회원정보 상세보기 페이지
	
	String id = request.getParameter("id");
	
	HashMap<String,Object> c = CustomerDAO.cusInfo(id);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	
	<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	<hr>
	<div>
	<h4 style="text-align:center">회원정보 자세히 보기</h4>
	<table style="margin: auto;padding:auto;">
		<tr>
			<td>ID (Mail) : </td>
			<td><%=(String) c.get("id")%></td>
		</tr>
		
		<tr>
			<td>Name : </td>
			<td><%=(String) c.get("name")%></td>
		</tr>
		<tr>
			<td>Birth :</td>
			<td><%=(String) c.get("birth")%></td>
		</tr>
		<tr>
			<td>gender :</td>
			<td><%=(String) c.get("gender")%></td>
		</tr>
		<tr>
			<td>update Date :</td>
			<td><%=(String) c.get("updateDate")%></td>
		</tr>
		<tr>
			<td>create Date :</td>
			<td><%=(String) c.get("createDate")%></td>
		</tr>
	
	
	
	</table> 
	
	<div style="margin:10px;"class="d-flex justify-content-center"><a href="./updateCustomerForm.jsp?id=<%=id%>" style="background-color:#BFB4EA; padding:5px;">&#127826 정보 수정하기</a>
	<a href="./editPwForm.jsp?id=<%=id%>" style="background-color:#BFB4EA; padding:5px;margin-left:5px;" >비밀번호 변경 &#127826</a></div>
	
	</div>
		<jsp:include page="/customer/footer.jsp"></jsp:include>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//인증분기 -> 세션변수 이름 :loginEmp
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/mainCustomer.jsp");
		return;
	}



%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
<style>

	
	.inner{
	position: absolute;
 	top: 50%;
 	left: 50%;
  	transform: translate(-50%,-50%); 
  	background-color: #ffffff; 
  	width:700px;
  	height:300px;
  	border-radius:10px;
  	border: 2px dashed black;
	text-align:center;
	
	}
	.btnn{
	background-color:#a49bc6;
	color:white;
	border-radius:5px;

	}
	table{
		margin:auto;
		padding:auto;
	}
	input{
		border:1px solid #a58680;
		border-radius:4px;
	}
</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	
	
	<div class="inner">
	<h2 style="text-decoration:underline;">STOREMADE</h2>

	<h3 style="font-size:21px;"><b>회원 로그인</b></h3>
	<div style="color: #a58680; font-size:21px">are you ready for this spring season?</div>

	<div style="margin-top:10px;">
	<form method="post" action="/shop/customer/loginCustomerAction.jsp">
	<table>
	<tr>
		<td>ID(MAIL) : </td>
		<td><input type="email" name="mail"></td>
	</tr>
	<tr>
		<td>PW :</td>
		<td><input type="password" name="pw"></td>
	</tr>
	</table> 
	<div style="margin:10px"><button type="submit" class="btnn" >로그인</button></div>
	&#127826
	</form>
	<div><a href="./registerCustomerForm.jsp">회원가입</a></div>
	</div>
	</div>


	
	


</body>
</html>
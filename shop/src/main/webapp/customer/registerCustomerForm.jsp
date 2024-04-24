<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	String id = request.getParameter("id");
	String ck = request.getParameter("ck");
	if(ck == null){
		ck = "";
	}


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
<style>
	.inner{
	position: absolute;
 	top: 50%;
 	left: 50%;
  	transform: translate(-50%,-50%); 
  	background-color: #ffffff; 
  	width:700px;
  	height:500px;
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
	form{
	font-size:18px;
	}

</style>
</head>
<body>
<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	<div class="inner">

	<h3 style="font-size:21px;padding-top:30px;"><b>회원가입</b></h3>
	<form method="post" action="./customerCheckId.jsp">
		<table>
			<tr>
				<td>아이디(메일):</td>
				<td><input type="email" name="mailId"></td>

			</tr>
		</table>
		<br>
		<button class="btnn" type="submit">아이디 중복확인</button>
	</form>
	
	
	

	
	<%
		if(ck.equals("F")){
	%>
		<div>중복된 아이디 입니다. 새로운 아이디를 입력해 주세요.</div>
	
	<%
		}else if(ck.equals("T")){
	%>
		<br>
		<form method="post" action="./registerCustomerAction.jsp">
		<table>
			<tr>
				<td>아이디(메일):</td>
				<td><input type="email" name="mailIdChecked" readonly value="<%=id%>"></td>

			</tr>
			<tr>
				<td>비밀번호:</td>
				<td><input type="password" name="pw"></td>
			</tr>
				
			<tr>
				<td>이름:</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td>생일:</td>
				<td><input type="date" name="birth"></td>
			</tr>
			<tr>
				<td>성별:</td>
				<td><input type="radio" name="gender" id="male" value="남"><label for="male">남</label>
					<input type="radio" name="gender" id="female" value="여"><label for="female">여</label>
				</td>
			</tr>
		</table>
		<br>
			<button class="btnn" type="submit">가입하기</button>
	</form>
	
	
	<%
		}
	
	
	%>
	
	
	</div>
	
	
</body>
</html>
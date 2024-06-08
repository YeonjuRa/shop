<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//인증분기 -> 세션변수 이름 :loginEmp
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}

	





%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<style>
	@font-face {
    font-family: 'Ownglyph_Dailyokja-Rg';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/2403@1.0/Ownglyph_Dailyokja-Rg.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
	}
	*{
		font-family:'Ownglyph_Dailyokja-Rg';
	}
	.container{
		display: flex;
  		justify-content: center;
  		flex-direction:row;
  		align-items: center;
  
  	
	}
	.inner{
	position: absolute;
 	top: 50%;
 	left: 50%;
  	transform: translate(-50%,-50%); 
  	background-color: #e8ddcb; 
  	width:400px;
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
</head>
<body style="background-color:#f8faca;">
	
	
	<div class="container">
	<div class="inner">
	<h2 style="text-decoration:underline;">STOREMADE</h2>

	<h3 style="font-size:23px;">직원 로그인</h3>
	<div style="color: #a58680; font-size:21px">are you ready for this spring season?</div>

	<div style="margin-top:10px;">
	<form method="post" action="/shop/emp/empLoginAction.jsp">
	<table>
	<tr>
		<td>ID : </td>
		<td><input type="text" name="empId"></td>
	</tr>
	<tr>
		<td>PW :</td>
		<td><input type="password" name="empPw"></td>
	</tr>
	</table> 
	<div style="margin:10px"><button type="submit" class="btnn" >로그인</button></div>
	&#127826
	</form>
	</div>
	<div><a href="./addEmpForm.jsp">사원가입</a></div>
	</div>
	</div>

	
	


</body>
</html>
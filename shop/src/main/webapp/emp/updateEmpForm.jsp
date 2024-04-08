<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	//emp 테이블에서 가입시 입력한 정보 가져와서 채우기


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<form method="post" action="/shop/emp/addEmpAction.jsp">
	<table>
	<tr>
		<td>ID : </td>
		<td><input type="text" name="empId"></td>
	</tr>
	<tr>
		<td>PW :</td>
		<td><input type="password" name="empPw"></td>
	</tr>
	<tr>
		<td>grade : </td>
		<td><input type="text" name="empId" readonly></td>
	</tr>
	<tr>
		<td>Name :</td>
		<td><input type="text" name="name"></td>
	</tr>
	<tr>
		<td>Department :</td>
		<td>
			<select name="dmt">
				<option value="">선택</option>
				<option value="인사">인사</option>
				<option value="개발">개발</option>
				<option value="마케팅">마케팅</option>
				<option value="영업">영업</option>
			
			</select>

	</td>
	</tr>
	<tr>
		<td>Hire Date :</td>
		<td><input type="date" name="hireDate"></td>
	</tr>
	</table> 
	<div style="margin:10px"><button type="submit" class="btnn" >가입하기</button></div>
	&#127826
	</form>
</body>
</html>
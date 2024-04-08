<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div>
	<form method="post" action="./registerCustomerAction.jsp">
		<table>
			<tr>
				<td>아이디(메일):</td>
				<td><input type="email" name="mailId"></td>
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
			<button type="submit">가입하기</button>
	</form>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="shop.dao.*" %>
<%@ page import="java.util.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	
	
	
%>
<%
	//emp 테이블에서 가입시 입력한 정보 가져와서 채우기
	
	String empId = request.getParameter("empId");
	
	//리스트에 넣기
		ArrayList<HashMap<String,Object>> empUpdateInfo = EmpDAO.updateEmpForm(empId);

	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 정보 수정</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	<form method="post" action="/shop/emp/updateEmpAction.jsp">
	<table>
	<%
		for(HashMap c : empUpdateInfo){
	%>
		<tr>
			<td>ID : </td>
			<td><input type="text" name="empId" value="<%=(String) c.get("empId")%>" readonly></td>
		</tr>
		
		<tr>
			<td>grade : </td>
			<td><input type="text" name="grade" readonly value="<%=(Integer) c.get("grade")%>"></td>
		</tr>
		<tr>
			<td>Name :</td>
			<td><input type="text" name="name" value="<%=(String) c.get("empName")%>"></td>
		</tr>
		<tr>
			<td>Department :</td>
			<td>
				<select name="empJob">
					<option value="<%=(String) c.get("empJob")%>"><%=(String) c.get("empJob")%></option>
					<option value="인사">인사</option>
					<option value="개발">개발</option>
					<option value="마케팅">마케팅</option>
					<option value="영업">영업</option>
				
				</select>
	
		</td>
		</tr>
		<tr>
			<td>Hire Date :</td>
			<td><input type="date" name="hireDate" value="<%=(String) c.get("hireDate")%>"></td>
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
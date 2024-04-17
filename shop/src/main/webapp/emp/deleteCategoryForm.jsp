<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>
<!-- 부분 파일 -->
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));
	//아이디 값 가져와서 value로 넣어주기
	
%>
<%
	String category = request.getParameter("category");
	
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
</head>
<body>
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
<div>
	<h4>본인확인을 위해 비밀번호를 다시 한번 입력해주세요. 이미 삭제한 카테고리는 되돌릴 수 없습니다!</h4>
	<%
		if(ck == ""){
			
	%>
		<form method="post" action="./checkEmpId.jsp">
		<table>
		<tr>
			<td>삭제할 카테고리</td>
			<td><input type="text" name="category" value="<%=category%>" readonly></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="empId" value="<%=(String)loginMember.get("empId")%>" readonly></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="empPw"></td>
		</tr>	
		</table>
		<button type="submit">사원 확인</button>
		</form>
	
	<% 
		}else if(ck.equals("T")){
	%>		
		<form method="post" action="./deleteCategoryAction.jsp">
		<table>
		<tr>
			<td>삭제할 카테고리</td>
			<td><input type="text" name="category" value="<%=category%>" readonly></td>
		</tr>
		<tr>
			<td>사원 아이디</td>
			<td><input type="text" name="empId" value="<%=(String)loginMember.get("empId")%>" readonly></td>
		</tr>	
		</table>
		<button type="submit">삭제하기</button>
		</form>
	<%		
	
		}else{
	%>
			<div>비밀번호가 일치하지 않습니다. 다시 시도해주세요.</div>
			<a href="./deleteCategoryForm.jsp?category=<%=category%>">돌아가기</a>
			
	<% 
		}
	
	
	%>
	
</div>
</body>
</html>
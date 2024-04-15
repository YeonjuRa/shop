<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	//System.out.println(session.getAttribute("loginEmp"));
	
	//요청분석
	
	ArrayList<HashMap<String, Object>> categoryList = CategoryDAO.selectCategoryList();
	



%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<!-- Latest compiled JavaScript -->	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">


<link href="./stylesheet.css" rel="stylesheet">
<style>
	table{
		width:100%;
		height:100%;
	}
	body{
	font-size:17px;
	}

</style>
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
<!-- 카테고리 리스트ㅡ 뿌리기 -->
	<div class="container text-center">
	<h4 class="mt-5"><b>카테고리 관리</b></h4>
	<div class="text-center mt-5">
	<table style="margin:auto;padding:auto;" class="table table-hover">
		<tr>
			<th>추가 날짜</th>
			<th>카테고리명</th>
			<th>카테고리 삭제</th>
	
		</tr>
		
		
		<%
			for(HashMap m:categoryList){
		%>	<tr>
			<td><%=(String)(m.get("createDate")) %></td>
			<td><%=(String)(m.get("category")) %></td>
			<td><a href="./deleteCategoryForm.jsp?category=<%=(String)(m.get("category"))%>">삭제</a></td>
		
		<% 
			}
		
		
		%>
		</tr>
	
	</table>
	<div style="float:right;margin-top:10px;"><a href="./addCategoryForm.jsp">카테고리 추가하기</a></div>
	</div>
	</div>
</body>
</html>
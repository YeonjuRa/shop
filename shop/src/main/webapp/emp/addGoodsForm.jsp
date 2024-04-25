<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>

<%

	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	

%>
<!--ㅡMOdell Layer  -->
<%
	
	
	ArrayList<String> categoryList = CategoryDAO.categoryList();

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
@import url('https://fonts.googleapis.com/css2?family=Gaegu&family=Jost:ital,wght@0,100..900;1,100..900&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&display=swap');
</style>
</head>
<body>
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<h1>상품등록</h1>
	<form method="post" action="/shop/emp/addGoodsAction.jsp" enctype="multipart/form-data">
	<div>
		<select name="category">
			<option value="">선택</option>
			<%
			for(String c : categoryList){
			%>	
			<option value="<%=c%>"><%=c%></option>
			
			<% 
			}
			
			
			%>
		</select>
	</div>
	<!--emp id값은 현재 로그인 되있는 세션변수에서 바인딩 -> action페이지  -->
	<div>
		goods price:
		<input type="text" name="goodsPrice">
	</div>
	<div>
		goods amount:
		<input type="text" name="goodsAmount">
	</div>
	<div>
		goods image:
		<input type="file" name="goodsImg">
	</div>
	<div>
		goodsTitle:
		<input type="text" name="goodsTitle">
	</div>
	<div>
		goods content:
		<textarea cols="30" rows="4" name="goodsContent">설명입력</textarea>
	</div>
	<button type="submit">등록하기</button>
	</form>
</body>
</html>
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
	
	//요청분석
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	
	//리스트에 넣기
	ArrayList<HashMap<String,Object>> updateGoodsForm = GoodsDAO.updateGoodsForm(goodsNo);
		
	//수정 가능한 카테고리 값 불러오기 
	ArrayList<String> categoryList = CategoryDAO.categoryList();
	
		


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="./stylesheet.css" rel="stylesheet">
</head>
<body>
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<h1>상품등록</h1>
	<form method="post" action="/shop/emp/updateGoodsAction.jsp?goodsNo=<%=goodsNo%>" enctype="multipart/form-data">
		<%
			for(HashMap gpc: updateGoodsForm){
		%>
		<select name="category">
			<option value="<%=(String)(gpc.get("category")) %>"><%=(String)(gpc.get("category")) %></option>
			
		<%
			for(String c : categoryList){
				
			%>		
			<option value="<%=c%>"><%=c%></option>
			<% 
			
			}
			%>
			</select>
			<div>
			goods price:
				<input type="text" name="goodsPrice" value="<%=(Integer)(gpc.get("goodsPrice")) %>">
			</div>
			<div>
			goods amount:
				<input type="text" name="goodsAmount" value="<%=(Integer)(gpc.get("goodsAmount")) %>">
			</div>
			<div>
			goods image:
			<img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200">
			<input type="file" name="goodsImg" value="<%=(String)(gpc.get("fileName"))%>">
			</div>
			<div>
			goodsTitle:
			<input type="text" name="goodsTitle" value="<%=(String)(gpc.get("goodsTitle")) %>">
			</div>
			<div>
			goods content:
			<textarea cols="30" rows="4" name="goodsContent"><%=(String)(gpc.get("goodsContent")) %></textarea>
			</div>
			<% 
				}
			%>
	
		<button type="submit">등록하기</button>
	</form>
</body>
</html>
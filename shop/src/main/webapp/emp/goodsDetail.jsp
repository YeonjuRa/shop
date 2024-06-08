<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	

	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	
	// 상품 하나 ->HashMap
	HashMap<String,Object> gpc = GoodsDAO.updateGoodsForm(goodsNo);
		

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
<div class="container-fluid">	

	
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>


	
	<div class="text-center">
		<h3>상품 상세 보기</h3>
	
		
		<div><img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200"></div>
		<div>카테고리 : <%=(String)(gpc.get("category"))%></div>
		<div>등록 아이디 : <%=(String)(gpc.get("empId")) %></div>
		<div>상품명 : <%=(String)(gpc.get("goodsTitle")) %></div>
		
		<div>설명:<br> <%=(String)(gpc.get("goodsContent")) %></div>
		<hr>
		<div>가격: <%=(Integer)(gpc.get("goodsPrice")) %></div>
		<div>수량 :<%=(Integer)(gpc.get("goodsAmount")) %></div>	
		<div>등록일: <%=(String)(gpc.get("createDate")) %></div>	
		
	
	<div>
	<!-- 상품번호 값 넘겨주기 -->
	<hr>
	<a href="./updateGoodsForm.jsp?goodsNo=<%=goodsNo%>" style="background-color:#BFB4EA; padding:5px;">수정하기</a>
	<a href="./deleteGoodsForm.jsp?goodsNo=<%=goodsNo%>"style="background-color:#BFB4EA; padding:5px;">삭제하기</a>
	</div>
	
	</div>
	</div>
	
	
	
	
	
	
</body>
</html>
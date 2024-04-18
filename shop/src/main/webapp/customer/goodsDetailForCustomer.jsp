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
	
	
	//리스트에 넣기
	ArrayList<HashMap<String,Object>> goodsPerCategory = GoodsDAO.updateGoodsForm(goodsNo);
		

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
	<div class="row">
	<!--  서브메뉴 -->
	<div class="col-2 text-center">
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>

	
	</div>
	
	<div class="col-10">
		<h1>상품 상세 보기</h1>
	
		<%
		for(HashMap gpc : goodsPerCategory){
			
		%>	
		<div><img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200"></div>
		<div>카테고리 : <%=(String)(gpc.get("category"))%></div>
		<div>등록 아이디 : <%=(String)(gpc.get("empId")) %></div>
		<div>상품명 : <%=(String)(gpc.get("goodsTitle")) %></div>
		
		<div>설명: <%=(String)(gpc.get("goodsContent")) %></div>
		<div>가격: <%=(Integer)(gpc.get("goodsPrice")) %></div>
		<div>수량 :<%=(Integer)(gpc.get("goodsAmount")) %></div>	
		<div>등록일: <%=(String)(gpc.get("createDate")) %></div>	
		<%
		
		
		}
		
		%>

	
	<div>
	<!-- 주문하기 -->
	<form>
	
	</form>
	<a href="*">주문하기</a>
	<a href=>삭제하기</a>
	</div>
	
	</div>
	</div>
	</div>
	
	
	
	
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	

	
	//리스트에 넣기
	ArrayList<HashMap<String,Object>> goodsPerCategory = GoodsDAO.updateGoodsForm(goodsNo);
	/* 
	int goodsAmount = 0;
	if(request.getParameter("goodsAmount") == null || request.getParameter("goodsAmount").equals("null")){
		goodsAmount = 0;
	}
	System.out.println(goodsAmount); */
	

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

<link href="../emp/stylesheet.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
<div class="container-fluid">	
	<div class="row">
	<!--  서브메뉴 -->
	<div class="col-2 text-center">
	

	
	</div>
	
	<div class="col-10">
		<h1>상품 상세 보기</h1>
	
		<%
		for(HashMap gpc : goodsPerCategory){
			
		%>	
		<div><img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200"></div>
		<div>카테고리 : <%=(String)(gpc.get("category"))%></div>
		<div>상품명 : <%=(String)(gpc.get("goodsTitle")) %></div>
		
		<div>설명: <%=(String)(gpc.get("goodsContent")) %></div>
		<div>가격: <%=(Integer)(gpc.get("goodsPrice")) %></div>
		
		<%
			if(session.getAttribute("loginCustomer") == null){
		%>
			<form method="post" action="/shop/customer/loginCustomer.jsp">
			수량: <input type="number" name="totalAmount">
			<%-- 총 금액: <input type="text" name="totalPrice" readonly value="<%=goodsAmount*(Integer)(gpc.get("goodsPrice"))%>"> --%>
			<button>주문하기</button>
		</form>
		<% 
			}else{
		%>		
			<form method="post" action="/shop/customer/addOrderForm.jsp?goodsNo=<%=goodsNo%>">
			수량: <input type="number" name="totalAmount">
			<%-- 총 금액: <input type="text" name="totalPrice" readonly value="<%=goodsAmount*(Integer)(gpc.get("goodsPrice"))%>"> --%>
			<button>주문하기</button>
		</form>
		
		
		
		<%
			}
		
		}
		
		%>

	
	<div>
	
	
	</div>
	
	</div>
	</div>
	</div>
	
	
	
	
	
</body>
</html>
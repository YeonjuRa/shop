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
		<div style="width:50%;">
		<img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="50%" height="400">
		<div style="width:50%;float:right;text-align:center">
		 Category <%=(String)(gpc.get("category"))%>
		<br>
		<%=(String)(gpc.get("goodsTitle")) %>
		<br>
		<%=(Integer)(gpc.get("goodsPrice")) %>원
		
		<br>
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
			<form method="post">
			수량: <input type="number" name="totalAmount">
			<%-- 총 금액: <input type="text" name="totalPrice" readonly value="<%=goodsAmount*(Integer)(gpc.get("goodsPrice"))%>"> --%>
			<button type="submit" formaction="/shop/customer/addOrderForm.jsp?goodsNo=<%=goodsNo%>">장바구니에 추가</button>
			<button type="submit" formaction="/shop/customer/addOrderForm.jsp?goodsNo=<%=goodsNo%>">주문하기</button>
			<!-- form태그 하나에 두개의 button넣기 1) html 5에서만 제공하는 formaction으로 분기 2) value 값으로 action페이지에서 분기  -->
		</form>
		
		</div>
		
		<%
			}
		%>
		
		</div>
		<div style="width:50%">
		<div style="width:50%"><b>About Product</b> <br><%=(String)(gpc.get("goodsContent")) %></div>
		</div>
		
		<%
		}
		
		%>

	
	
	
	</div>
	
	</div>
	</div>
	
	
	
	
	<jsp:include page="/customer/footer.jsp"></jsp:include>
</body>
</html>
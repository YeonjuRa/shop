<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%

	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginCustomer.jsp");
		return;
	}
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
   

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    String mail = (String)loginMember.get("mail");
    int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
    
   HashMap<String,Object> goodsPerCategory = GoodsDAO.updateGoodsForm(goodsNo);
    int pricePerGoods = 0;
   
    pricePerGoods = (Integer)(goodsPerCategory.get("goodsPrice"));
   
	int totalPrice = pricePerGoods*totalAmount;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
<style>

input {
  border-width: 0 0 1px;
}


</style>
</head>
<body>
<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
<hr>
<h2 class="text-center">배송 정보 입력 폼</h2><br>
<div class="d-flex justify-content-center">
	<form method="post" action="/shop/orders/addOrdersAction.jsp">
		회원 아이디: <input type="text" name="mail" value="<%=mail%>" readonly><br>
	
		상품 번호: <input type="text" name="goodsNo" value="<%=goodsNo%>" readonly><br>
		주문 수량 : <input type="text" name="totalAmount" value="<%=totalAmount%>" readonly><br>
		주문 금액 :<input type="text" name="totalPrice" value="<%=totalPrice%>" readonly><br>
		
		
		주소: <input type="text" name="address"><br>
		<button type="submit">최종 주문하기</button>
	</form>
</div>
<jsp:include page="/customer/footer.jsp"></jsp:include>
</body>
</html>
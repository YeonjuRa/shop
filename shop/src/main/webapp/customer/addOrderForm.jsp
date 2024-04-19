<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
   

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    String mail = (String)loginMember.get("mail");
    int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
    
    ArrayList<HashMap<String,Object>> goodsPerCategory = GoodsDAO.updateGoodsForm(goodsNo);
    int pricePerGoods = 0;
    for(HashMap gpc : goodsPerCategory){
    	pricePerGoods = (Integer)(gpc.get("goodsPrice"));
    }
	int totalPrice = pricePerGoods*totalAmount;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>배송 정보 입력 폼</h2>
	<form method="post" action="/shop/orders/addOrdersAction.jsp">
		<input type="text" name="mail" value="<%=mail%>" readonly>
		<input type="text" name="goodsNo" value="<%=goodsNo%>" readonly>
		<input type="text" name="totalAmount" value="<%=totalAmount%>" readonly>
		<input type="text" name="totalPrice" value="<%=totalPrice%>" readonly>
		<input type="text" name="address">
		<button type="submit">최종 주문하기</button>
	</form>
</body>
</html>
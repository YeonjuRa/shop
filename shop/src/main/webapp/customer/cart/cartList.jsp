<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>
<%
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginCustomer.jsp");
		return;
	}
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	String userId = (String) loginMember.get("mail");
	
	ArrayList<HashMap<String,Object>> selectCartList = CartDAO.selectCartList(userId);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	<%
		if(selectCartList.size() == 0){
	%>
	
		<div>장바구니가 비어 있습니다.</div>
	
	<% 
		}else{
	%>
		<table class="table table-hover">
		<tr>
			<th>상품 번호</th>
			<th>상품 명</th>
			<th>이미지 </th>
			<th>수량 </th>
			<th>총 금액 </th>
			<th>장바구니 삭제 </th>
		
		</tr>
		
		<%
			for(HashMap<String,Object> m : selectCartList){
				
				
		%>
		<tr>
			<td><%=(Integer)m.get("goodsNo")%></td>
			<td><%=(String)m.get("goodsTitle")%></td>
			<td><img src="/shop/upload/<%=(String)m.get("filename") %>" width="200" height="200"></td>
			<td><%=(Integer)m.get("numbers")%></td>
			<td><%=(Integer)m.get("numbers")*(Integer)m.get("totalPrice")%></td>
			<td><a href="/shop/customer/cart/deleteCartAction.jsp">삭제</a></td>
		
		</tr>
		
		<%
			}
		
		
		
		
		%>
		
		
	
	</table>
	
	
	<% 
		}
	
	%>
	
	
	
	<a href="/shop/customer/orderFormCart.jsp">장바구니 상품 주문하기 </a>
</body>
</html>
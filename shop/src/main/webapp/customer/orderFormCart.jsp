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
	
	ArrayList<HashMap<String,Object>> list = CartDAO.selectCartList(userId);
	
	//장바구니 번호를 values 로 받아서그걸로 카트리스트에 반복문으로가져와서 -> 주문DAO 반복
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body> 
<form method="post" action="/shop/customer/cart/orderCartGoods.jsp">
<table class="table table-hover">
		<tr>
			<th>카트 번호 (hidden 주)</th>
			<th>상품 번호</th>
			<th>상품 명</th>
			<th>이미지 </th>
			<th>수량 </th>
			<th>총 금액 </th>
		
		</tr>
		
		<%
			for(HashMap<String,Object> m : list){
				
				
		%>
		<tr>
			<td><input name="cartId" value="<%=(Integer)m.get("cartId")%>" readonly></td>
			<td><%=(Integer)m.get("goodsNo")%></td>
			<td><%=(String)m.get("goodsTitle")%></td>
			<td><img src="/shop/upload/<%=(String)m.get("filename") %>" width="200" height="200"></td>
			<td><%=(Integer)m.get("numbers")%></td>
			<td><%=(Integer)m.get("numbers")*(Integer)m.get("totalPrice")%></td>

		
		</tr>
		
		<%
			}
		
		
		
		
		%>
		
		
	
	</table>
	주소 : <input name="address" placeholder="배송지 주소를 입력해주세요.">
	
	<button type="submit">최종 주문하기 </button>
	</form>
	

</body>
</html>
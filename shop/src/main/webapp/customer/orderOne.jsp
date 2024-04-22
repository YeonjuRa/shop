<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="shop.dao.*" %>
<%@ page import ="java.util.*" %>
<%
	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginCustomer.jsp");
		return;
	}
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	String mail = (String)loginMember.get("mail");

		int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
		
	ArrayList<HashMap<String,Object>> orderOne = OrderDAO.selectOrderOne(ordersNo);
	
	


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보 자세히 보기 </title>
</head>
<body>
	<table>
	<%
		for(HashMap<String,Object> m : orderOne){
	%>
		<tr>
			<td>주문번호 </td>
			<td><%=m.get("ordersNo") %></td>
		</tr>
		<tr>
			<td>상품 번호  </td>
			<td><%=m.get("goodsNo") %></td>
		</tr>
		<tr>
			<td>상품 이름  </td>
			<td><%=m.get("goodsTitle") %></td>
		</tr>
		<tr>
			<td>상품 사진  </td>
			<td><img src="/shop/upload/<%=(String)(m.get("filename")) %>" width="200" height="200"></td>
		</tr>
		<tr>
			<td>총 구매 갯수  </td>
			<td><%=m.get("totalAmount") %></td>
		</tr>
		<tr>
			<td>총 구매 금액  </td>
			<td><%=m.get("totalPrice") %></td>
		</tr>
		<tr>
			<td>주문 상황   </td>
			<td><%=m.get("state") %></td>
		</tr>
		<tr>
			<td>주문 일시   </td>
			<td><%=m.get("createDate") %></td>
		</tr>
		
	<%
		}
	
	
	%>
		
	
	</table>
	<a href="/shop/customer/cancelOrdersAction.jsp">주문 취소하기 </a>
</body>
</html>
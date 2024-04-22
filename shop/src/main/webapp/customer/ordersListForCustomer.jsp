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

	ArrayList<HashMap<String,Object>> selectOrderList = OrderDAO.selectOrdersList(mail);
	
	


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	<table class="table table-hover text-center">
		<tr>
			<th>ORDERS NO.</th>
			<th>GOODS TITLE</th>
			<th>TOTAL AMOUNT</th>
			<th>TOTAL PRICE</th>
			<th>STATE</th>
			<th>주문 일시</th>
			<th>상세보기</th>
			<th>후기</th>
				
		</tr>
		
			<%
				for(HashMap<String,Object> m: selectOrderList){
			%>
			<tr>

				
				<td><%=(Integer)(m.get("ordersNo"))%></td>
				<td><%=(String)(m.get("goodsTitle"))%></td>
				<td><%=(Integer)(m.get("totalAmount"))%></td>
				<td><%=(Integer)(m.get("totalPrice"))%></td>
				<td><%=(String)(m.get("state"))%></td>
				<td><%=(String)(m.get("createDate"))%></td>
				<td><a href="/shop/customer/orderOne.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>">주문 상세보기</a></td>
				<%
				int ordersNo = (Integer)(m.get("ordersNo"));
				boolean checkComment = CommentDAO.checkCommentAction(ordersNo);
					if(checkComment == true){
				%>
						<td>후기 작성 완료</td>
				<%
					}else{
						
					
					if(((String)(m.get("state"))).equals("배송 완료")){
				%>
						<td><a href="/shop/customer/insertCommentForm.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>">
						후기 작성하기</a></td>
				<%
					}else{
				%>
						<td>후기 작성 불가</td>
				<%
					}
				}
				%>
				
			</tr>
			<% 
				}
			
			
			
			
			%>
		
		
	</table>
</body>
</html>
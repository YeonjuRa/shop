<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="shop.dao.*" %>
<%@ page import ="java.util.*" %>
<%

	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));
	
	ArrayList<HashMap<String,Object>> selectOrderList = OrderDAO.selectOrdersListAll();

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

<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
<h4 class="text-center">주문 상세보기</h4>
	<table class="table table-hover text-center">
		<tr>
			<th>ORDERS NO.</th>
			<th>GOODS TITLE</th>
			<th>TOTAL AMOUNT</th>
			<th>TOTAL PRICE</th>
			<th>주문 일시</th>
			<th>상세보기</th>
			<th>STATE</th>
				
		</tr>
		
			<%
				for(HashMap<String,Object> m: selectOrderList){
			%>
			<tr>

				
				<td><%=(Integer)(m.get("ordersNo"))%></td>
				<td><%=(String)(m.get("goodsTitle"))%></td>
				<td><%=(Integer)(m.get("totalAmount"))%></td>
				<td><%=(Integer)(m.get("totalPrice"))%></td>
				<td><%=(String)(m.get("createDate"))%></td>
				<td><a href=#>주문 상세보기</a></td>
				<td>
				<form method="post" action="/shop/emp/updateStateAction.jsp?ordersNo=<%=(Integer)(m.get("ordersNo"))%>">
				
				<select name="state">
					<option value="<%=(String)(m.get("state"))%>"><%=(String)(m.get("state"))%></option>
					<option value="결제 완료">결제 완료</option>
					<option value="배송 중">배송 중</option>
					<option value="배송 완료">배송 완료</option>
				</select>
				<button type="submit">상태 변경하기</button>
				
				</form>
				
			</tr>
			<% 
				}
			
			
			
			
			%>
		
		
	</table>
</body>
</html>
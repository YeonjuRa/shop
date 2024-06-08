<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	

	
	//리스트에 넣기
	HashMap<String,Object> gpc = GoodsDAO.updateGoodsForm(goodsNo);
	/* 
	int goodsAmount = 0;
	if(request.getParameter("goodsAmount") == null || request.getParameter("goodsAmount").equals("null")){
		goodsAmount = 0;
	}
	System.out.println(goodsAmount); */
	ArrayList<HashMap<String,Object>> selectCommentPerGoods = CommentDAO.selectCommentPerGoods(goodsNo);
	

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>

<style>
.rate{
width: 121px;height: 20px;position: relative;}

.rate span{
position: absolute;
background: url(https://aldo814.github.io/jobcloud/html/images/user/star02.png);
width: auto;height: 20px;}

</style>
<!-- Latest compiled JavaScript -->	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="../emp/stylesheet.css" rel="stylesheet">
</head>

<body>
<jsp:include page="/customer/customerMenu.jsp"></jsp:include>

<div class="container-fluid">	
		<div class="d-flex justify-content-center">
		
	
		<div style="width:80%;">
		 <b>> Category : <%=(String)(gpc.get("category"))%></b><br><br>
		<img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="35%" height="500">
		<div style="width:50%;height:500px;float:right;text-align:center;font-size:20px;background-color:#EDD39B;padding:10px;border-radius:5px;">
		
		<br>
		<span style="font-size:30px">==<b><%=(String)(gpc.get("goodsTitle"))%></b>==</span>
		<br>
		<b> #About Product </b> <br>
		<%=(String)(gpc.get("goodsContent")) %>
		<br>
		<b><%=(Integer)(gpc.get("goodsPrice")) %>원</b>
		
		<br>
		<%
			if(session.getAttribute("loginCustomer") == null){
		%>
			<form method="post" action="/shop/customer/loginCustomer.jsp">
			수량: <input type="number" name="totalAmount">
			
			<button>주문하기</button>
			<button>주문하기</button>
		</form>
		<% 
			}else{
		%>		
			<form method="post" action="/shop/customer/addOrderForm.jsp?goodsNo=<%=goodsNo%>">
			수량: <input type="number" name="totalAmount">
			
			<button type="submit" formaction="/shop/customer/cart/insertIntoCart.jsp?goodsNo=<%=goodsNo%>">장바구니에 추가</button>
			<button type="submit">주문하기</button>
		</form>
		
		</div>
		
		<%
			}
		%>
		
		</div>
		</div>
		<hr>
		<h3 class="text-center">REVIEWS</h3>
		<br>
		
		
		<%
			if(selectCommentPerGoods.size() == 0){
		
		%>
			<div class="text-center">작성된 후기가 존재하지 않습니다.</div>
		
		<%
			}else{
		%>		
				
		<div>
		<table class="table table-hover">
			<tr>
				<td>주문 번호</td>
				<td>별점</td>
				<td>한줄 평</td>
				<td>구매자</td>
				<td>구매 날짜</td>
			</tr>
			<%		
				for(HashMap<String,Object> m :selectCommentPerGoods){
			%>
				<tr>
					<td><%=(Integer)m.get("ordersNo") %></td>
					<td>
					<div class="rate">
					<%
						switch((Integer)(m.get("score"))){
						case 1:
					%>
							
	        				<span style="width: 10%"></span>
	    					
	    			<% 
	    				break;
						case 2:
					%>
					
	        				<span style="width: 20%"></span>
	    					
					<% 
						break;
						case 3:
					%>		
					
	        				<span style="width: 30%"></span>
	    					
					<% 
						break;
						case 4:
					%>
					
	        				<span style="width: 40%"></span>
	    				
					<% 	
						break;
						case 5:
					%>		
					
	        				<span style="width: 50%"></span>
	    					
					<% 
						break;
						case 6:
					%>
					
	        				<span style="width: 60%"></span>
	    				
					<% 
						break;
						case 7:
					%>
					
	        				<span style="width: 70%"></span>
	    				
					<% 
						break;
						case 8:
					%>
					
	        				<span style="width: 80%"></span>
	    			
					<% 
						break;
						case 9:
					%>
					
	        				<span style="width: 90%"></span>
	    					
					<% 
						break;
						case 10:
					%>
					
	        				<span style="width: 100%"></span>
	    			</div>
					<% 
					break;
						}
					
					%>
					
					</td>

					<td><%=(String)m.get("content") %></td>
					<td><%=(String)m.get("mail") %></td>
					<td><%=(String)m.get("createDate") %></td>

				</tr>
				
				
			<% 	
				}
			%>	
			
			
			<%		
				}
			%>
			</table>
			</div>
	
	</div>
	


	<jsp:include page="/customer/footer.jsp"></jsp:include>
</body>
</html>
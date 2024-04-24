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
	String mail = (String)loginMember.get("mail");
	ArrayList<HashMap<String,Object>> list = CommentDAO.selectCommentList(mail);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 후기 보기!</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
<style>
.rate{
width: 121px;height: 20px;position: relative;}

.rate span{
position: absolute;
background: url(https://aldo814.github.io/jobcloud/html/images/user/star02.png);
width: auto;height: 20px;}

</style>
</head>
<body>
	<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	<table class="table table-hover text-center">
		<tr>
			<th>주문 번호</th>
			<th>상품 번호</th>
			<th>평점</th>
			<th>내용</th>
			<th>작성 일시</th>
				
		</tr>
		
			<%
				for(HashMap<String,Object> m: list){
			%>
			<tr>

				
				<td><%=(Integer)(m.get("ordersNo"))%></td>
				<td><%=(Integer)(m.get("goodsNo"))%></td>
				<td><div class="rate">
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
    					</div>
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
				<td><%=(String)(m.get("content"))%></td>
				<td><%=(String)(m.get("createDate"))%></td>
			<% 
				}

			%>
			</tr>
			
			</table>
				<jsp:include page="/customer/footer.jsp"></jsp:include>
</body>
</html>
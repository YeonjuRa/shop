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
<style>
#layer_popup{
    display: none;
}
#layer_popup + label {
    display: inline-block;
    padding: 7px 14px;
    background: #000;
    color: #fff;
}
#layer_bg{
    display: none;
    position: absolute; /* 시작 지점을 버튼 위, 0픽셀부터 시작하려고 주는 것*/
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5)}
#popup{
    position: absolute;
    padding: 15px;
    box-sizing: border-box;
    border-radius: 15px;
    width: 600px;
    height: 400px;
    background: #fff;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    box-shadow: 7px 7px 5px rgba(0, 0, 0, 0.2); /*x y 번짐 색상*/
    }
#popup > h2{
    margin-bottom: 25px;
}

#popup > h2 > label{
    float: right;
}
#layer_popup:checked + label + #layer_bg{

    display: block;
}
</style>
<!-- Latest compiled JavaScript -->	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="../emp/stylesheet.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	<table class="table table-hover">
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
			<td><img src="/shop/upload/<%=m.get("filename") %>" width="200" height="200"></td>
		</tr>
		<tr>
			<td>총 구매 갯수  </td>
			<td><%=m.get("totalAmount") %></td>
		</tr>
		<tr>
			<td>총 구매 금액  </td>
			<td><%=m.get("totalPrice") %>원</td>
		</tr>
		<tr>
			<td>주문 상황   </td>
			<td><%=m.get("state") %></td>
		</tr>
		<tr>
			<td>주문 일시   </td>
			<td><%=m.get("createDate") %></td>
		</tr>
		</table>
	<%
		
		if((m.get("state").equals("결제 완료"))){
	%>
			<input type="checkbox" id="layer_popup">
			<label for="layer_popup">
			주문 취소하기
			</label>
			<div id="layer_bg"> <!-- /*전체배경(기존 페이지를 안보이게 가려주거나 불투명하게 보이게함)*/ -->
		        <div id="popup"> <!-- /*팝업뜰창*/ -->
		            <h2>
		                주문 취소   <!-- /*제목*/ -->
		                <label for="layer_popup">X</label>
		            </h2>
		           해당 주문을 취소 하시겠습니까?
		           (취소하신 상품은 다시 되돌릴 수 없습니다.)
		           <div>주문번호: <%=m.get("ordersNo") %></div>
		           <div>환불 예정 금액: <%=m.get("totalPrice") %>원</div>
		           <a href="/shop/orders/cancelOrdersAction.jsp?ordersNo=<%=ordersNo%>" style="background-color:#BFB4EA; padding:5px;">주문 취소하기</a>
		        </div>
		        
		    </div>
	<%
		}
	}
	
	
	%>
		
	
	
	
</body>
</html>
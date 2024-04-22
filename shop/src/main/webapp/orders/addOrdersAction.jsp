<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
   

	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
    String mail = (String)loginMember.get("mail");
    int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
    
   
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
	String address = request.getParameter("address");
	
	int row = OrderDAO.addOrderAction(mail, goodsNo, totalAmount, totalPrice, address);
	
	if(row != 0){
		System.out.println("상품 주문 완료");
		GoodsDAO.updateGoodsAmount(totalAmount, goodsNo);
		response.sendRedirect("/shop/customer/ordersListForCustomer.jsp?id="+mail);
	}else{
		System.out.println("상품 주문 실패");
	}
    
    
    
    
    
%>

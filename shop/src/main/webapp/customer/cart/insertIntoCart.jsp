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
	

	String userId = (String)loginMember.get("mail");
	String goodsNo = request.getParameter("goodsNo");
	int totalAmount = Integer.parseInt(request.getParameter("totalAmount"));
	
	int row = CartDAO.insertIntoCart(userId, goodsNo, totalAmount);
	
	if(row != 0){
		System.out.println("장바구니에 추가 완료");
		response.sendRedirect("/shop/customer/cart/cartList.jsp?id="+userId);
	}else{
		System.out.println("장바구니에 추가 실패");
		response.sendRedirect("/shop/customer/cart/cartList.jsp?id="+userId);
	}




%>



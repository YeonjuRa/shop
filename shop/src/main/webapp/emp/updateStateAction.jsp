<%@page import="shop.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String state = request.getParameter("state");
	int row = OrderDAO.updateStateAction(state, ordersNo);
	if(row != 0){
		System.out.println("state 변경 완료");
		response.sendRedirect("/shop/emp/OrdersListForEmp.jsp");
	}else{
		System.out.println("state 변경 실패");
	}


%>
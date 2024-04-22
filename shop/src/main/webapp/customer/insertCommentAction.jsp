<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>
<%

	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	String mail = (String)loginMember.get("mail");
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int score = Integer.parseInt(request.getParameter("score"));
	String content = request.getParameter("content");


	int row = CommentDAO.insertCommentAction(ordersNo, score, content);
	if(row != 0){
		System.out.println("후기 작성 완료");
		response.sendRedirect("/shop/customer/ordersListForCustomer.jsp?id="+mail);
	}else{
		System.out.println("후기 작성 실패");
		response.sendRedirect("/shop/customer/ordersListForCustomer.jsp?id="+mail);
	}



%>

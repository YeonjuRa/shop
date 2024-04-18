<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>


<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));


%>
<!-- model Layer -->
<%	
	
	
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	
	int row = CustomerDAO.updateCustomerAction(name, birth, gender, id);

	
	if(row != 0){ 
		System.out.println("회원 정보 업데이트 완료");
		response.sendRedirect("/shop/customer/customerOne.jsp?id="+id);
	}else{
		System.out.println("회원 업데이트 실패");
		response.sendRedirect("/shop/customer/customerOne.jsp?id="+id);
	}
%>
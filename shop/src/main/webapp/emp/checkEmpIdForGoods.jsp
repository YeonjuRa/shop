<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.net.*" %>
<%
	
	//아이디+비번 확인하기 + 상품 번호 받아오기
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	
	
	//요청분석
	
	int row = EmpDAO.checkEmpId(empId, empPw);


	
	if(row ==1){
		//읽어올 행이 있다 -> 아이디와 비번이 일치하는 직원이다 -> 삭제 가능 -> ck = T
		response.sendRedirect("/shop/emp/deleteGoodsForm.jsp?goodsNo="+goodsNo+"&ck=T");
	}else{
		//반대면 ck = F
		response.sendRedirect("/shop/emp/deleteGoodsForm.jsp?goodsNo="+goodsNo+"&ck=F");
	}

%>
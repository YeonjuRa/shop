<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>

<%
	//인정분기 : 세션변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/mainCustomer.jsp");
		return;
	}

	//아이디, 비번 값 가져오기 -> 

	String mail = request.getParameter("mail");
	String pw = request.getParameter("pw");
	
	/* select mail,pw,name from customer where mail =? and pw = password(?);
	
	*/
	
	HashMap<String,String> map = CustomerDAO.login(mail, pw);
	
	System.out.println(map);
	
	if(map != null){
		System.out.println("로그인 성공");
		
		session.setAttribute("loginCustomer",map);
		

		response.sendRedirect("./mainCustomer.jsp");
	}else{
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
		response.sendRedirect("/shop/customer/loginCustomer.jsp?errMsg="+errMsg);
	}
	

%>

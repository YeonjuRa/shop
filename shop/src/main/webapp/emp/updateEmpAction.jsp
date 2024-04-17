<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
%>

<%
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));
	
	
%>
<!-- model Layer -->
<%	
	//update할 값 가져오기
	String empId = request.getParameter("empId");
	String empName = request.getParameter("name");
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");
	
	int row = EmpDAO.updateEmpAction(empId, empName, empJob, hireDate);
	
	if(row != 0){ 
		System.out.println("사원 정보 업데이트 완료");
		response.sendRedirect("./empOne.jsp?empId="+empId);
	}else{
		System.out.println("사원 정보 업데이트 실패");
		response.sendRedirect("/shop/emp/updateEmpForm.jsp");
	}
%>
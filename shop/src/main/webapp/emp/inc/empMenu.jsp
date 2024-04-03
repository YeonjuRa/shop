<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- 부분 파일 -->
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));


%>
<div>
	<a href="/shop/emp/empList.jsp">사원관리</a>
	<!-- category CRUD -->
	<a href="/shop/emp/categoryList.jsp">카테고리 관리</a>
	<a href="/shop/emp/goodsList.jsp">상품관리</a>
	<a href="">other</a>
	<!-- 회원정보 수정 -->
	<br>
	<a href=""><%=(String)loginMember.get("empId")%></a>님 안녕하세요 :)
</div>
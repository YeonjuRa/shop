<%@page import="shop.dao.CustomerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	System.out.println(session.getAttribute("loginEmp"));
%>

<%
	//페이징
	//요청분석
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	//페이징 -> 페이징은 jsp에서 구현
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 15;
	int startRow = (currentPage-1) * rowPerPage;
	
	//lastPage 구하기
	String pageSql = "select count(*) from customer";
	
	PreparedStatement pageStmt = null;
	ResultSet pageRs = null;
	pageStmt = con.prepareStatement(pageSql);
	pageRs = pageStmt.executeQuery();
	
	int totalRow = 0;
	if(pageRs.next()){
		totalRow = pageRs.getInt("count(*)");
	}
	int lastPage = totalRow/rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage = lastPage +1;
	}

		

%>
<%

	ArrayList<HashMap<String, Object>> list = CustomerDAO.selectCustomerListByPage(startRow, rowPerPage);


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 리스트</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="./stylesheet.css" rel="stylesheet">
</head>
<body>
<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>

<div class="container">	


		<div><h2 class="mt-5 text-center">회원 목록</h2></div>
	
	<table class="table table-hover text-center">
		<tr>
			<th>회원 아이디</th>
			<th>회원 이름</th>
			<th>생년월일</th>
			<th>성별</th>
			<th>가입일</th>
				
		</tr>
			<tr>
			<%
				for(HashMap<String,Object> m: list){
			%>
				
				<td><%=(String)(m.get("mail"))%></td>
				<td><%=(String)(m.get("name"))%></td>
				<td><%=(String)(m.get("birth"))%></td>
				<td><%=(String)(m.get("gender"))%></td>
				<td><%=(String)(m.get("createDate"))%></td>
			</tr>
			<% 
				}
			
			
			%>
		
		
	</table>
	
	
	
		<!-- 페이징 -->
		<div class="text-center mt-2"><%=currentPage%></div>
	
		<div style="height:40px;display: table;margin-left: auto; margin-right: auto;">
				
				<ul class="text-center">
				
				
				<%
					if(currentPage != 1){
			
				%>
					<li ><a href="./customerListForEmp.jsp?currentPage=1">&nbsp; << 처음 페이지 </a></li>
					<li><a href="./customerListForEmp.jsp?currentPage=<%=currentPage-1%>">&nbsp; < 이전 </a></li>
				<%
		
					}
					if(currentPage<lastPage){
				%>
					<li><a href="./customerListForEmp.jsp?currentPage=<%=currentPage+1%>">&nbsp;| 다음 > &nbsp;</a></li>
					<li><a href="./customerListForEmp.jsp?currentPage=<%=lastPage%>"> 마지막 페이지 >>&nbsp;</a></li>
				<%
					
					}
				
				%>
				</ul>
			</div>
				
	
	</div>
</body>
</html>
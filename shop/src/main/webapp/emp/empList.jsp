<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>
<%@ page import="java.sql.*"%>

<!-- Controller Layer -->
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
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = (currentPage-1) * rowPerPage;
	
	//lastPage 구하기
	int lastPage = EmpDAO.getLastPageEmp();

%>

<%
	
	/* //총 책임자 제외 전체목록 출력  --> 
	String sql = "select * from emp where emp_id not in('admin')"; 
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery(); */
	
%>
<!-- model Layer -->
<% 	


	 ArrayList<HashMap<String,Object>> list = EmpDAO.empList(startRow, rowPerPage);


%>
<!-- View Layer  : 모델 (ArrayList<HashMap<String,Object>>) 출력-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="./stylesheet.css" rel="stylesheet">
<style>
	ul{
		display: table;
 	 	margin-left: auto;
 	 	margin-right: auto;
	}

</style>
</head>
<body>
<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
<!-- include로 메뉴 출력, empMenu.jsp include : 주체가 server -->
<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/...시작하지 않는다... -->
<div class="container">	


		<div><h2 class="mt-5 text-center">사원목록</h2></div>
	
	<table class="table table-hover text-center">
		<tr>
			<th>ACTIVE</th>
			<th>EMP ID</th>
			<th>EMP NAME</th>
			<th>EMP JOB</th>
			<th>HIRE DATE</th>
				
		</tr>
		
			<%
				for(HashMap<String,Object> m: list){
			%>
			<tr>
			<%
			HashMap<String,Object> n = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
			//grade 가 0 이상만 a태그 링크로 active값 변경 가능.
				if( (Integer)(n.get("grade")) > 0){
			%>
			
			<td><a href="./modifyEmpActive.jsp?empId=<%=(String)(m.get("empId"))%>&active=<%=(String)(m.get("active"))%>"><%=(String)(m.get("active"))%></a></td>		
			<% 
				}else{
			%>
					<td><%=(String)(m.get("active"))%></td>
			<% 	
				}
			
			%>
				
				<td><%=(String)(m.get("empId"))%></td>
				<td><%=(String)(m.get("empName"))%></td>
				<td><%=(String)(m.get("empJob"))%></td>
				<td><%=(String)(m.get("hireDate"))%></td>
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
					<li ><a href="./empList.jsp?currentPage=1">&nbsp; << 처음 페이지 </a></li>
					<li><a href="./empList.jsp?currentPage=<%=currentPage-1%>">&nbsp; < 이전 </a></li>
				<%
			
					}
					if(currentPage<lastPage){
				%>
					<li><a href="./empList.jsp?currentPage=<%=currentPage+1%>">&nbsp;| 다음 > &nbsp;</a></li>
					<li><a href="./empList.jsp?currentPage=<%=lastPage%>"> 마지막 페이지 >>&nbsp;</a></li>
				<%
				
				
					}
				
				%>
				</ul>
			</div>
				
	
	</div>
	
</body>
</html>
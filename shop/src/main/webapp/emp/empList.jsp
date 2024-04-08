<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>

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

	//디비 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 8;
	int startRow = (currentPage-1) * rowPerPage;
	
	//lastPage 구하기
	
	String pageSql = "select count(*) from emp";
	
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
	
	/* //총 책임자 제외 전체목록 출력  --> 
	String sql = "select * from emp where emp_id not in('admin')"; 
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery(); */
	
%>
<!-- model Layer -->
<% 	
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	//모델 값(특수한 형태의 자료구조 - RDBMS : mariadb) ->  
	//API사용하여(JDBC API) 자료구조(ResultSet) 취득 -> 
	
	//일반화된 자료구조로 변경(ArrayList<HashMap>) ->모델 취득	
	String sql ="select emp_id empId,emp_name empName, emp_job empJob,hire_date hireDate,active from emp order by hire_date desc limit ?,?";
	stmt = con.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	rs = stmt.executeQuery();
	
	//일반화된 자료구조로 변경하기 - arraylist
	 ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	//ResultSet ->ArrayList<HashMap<String,Object>>
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("empId", rs.getString("empId"));   //--> 아이디 값이 들어감
		m.put("empName",rs.getString("empName"));
		m.put("empJob",rs.getString("empJob"));
		m.put("hireDate",rs.getString("hireDate"));
		m.put("active",rs.getString("active"));
		list.add(m);
		//rs행의 수만큼 리스트가 채워진다.
	}
	
	//커넥션 닫아도 이미 리스트에 다 담았기때문에 자원해지 해도 됨.
	
	//JDBC API 사용이 끝났다면 디비자원을 닫아도 상관없다.
	

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
					if(currentPage > 1){
			
				%>
					<li ><a href="./empList.jsp?currentPage=1">&nbsp; << 처음 페이지 </a></li>
					<li><a href="./empList.jsp?currentPage=<%=currentPage-1%>">&nbsp; < 이전 </a></li>
				<%
					}else{
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
					}else{
						
				%>
					<li><a href="./empList.jsp?currentPage=<%=currentPage+1%>"> 다음 >&nbsp;</a></li>
					<li><a href="./empList.jsp?currentPage=<%=lastPage%>"> 마지막 페이지 >>&nbsp;</a></li>
				
				<% 
					}
				
				%>
				</ul>
			</div>
				
	
	</div>
	
</body>
</html>
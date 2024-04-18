<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>
<%@ page import="shop.dao.*" %>

<!-- Controller Layer -->
<%
	
	
	//요청분석
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	//페이징
	
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int rowPerPage = 15;
		int startRow = (currentPage-1) * rowPerPage;
		
		//lastPage 구하기
		
		String pageSql = null;
		String category = request.getParameter("category");
		//category가 null일경우 제거
		PreparedStatement pageStmt = null;
		ResultSet pageRs = null;
		if(category == null){
			category = "";
		}
		//전체 상품갯수 // 카테고리별 상품갯수 분기하기
		if(category == ""){
			pageSql = "select count(*) from goods";
			pageStmt = con.prepareStatement(pageSql);
		}else{
			pageSql = "select count(*) from goods where category =?";
			pageStmt = con.prepareStatement(pageSql);
			pageStmt.setString(1,category);
		}
		
		
		pageRs = pageStmt.executeQuery();
		
		int totalRow = 0;
		if(pageRs.next()){
			totalRow = pageRs.getInt("count(*)");
		}
		int lastPage = totalRow/rowPerPage;
		if(totalRow%rowPerPage != 0){
			lastPage = lastPage +1;
		}
	
	/*
	category가 null이면
	select * from goods
	null이 아니면 
	select * from goods where category =?
	*/
	
	
	
	
%>
<!--ㅡMOdell Layer  -->
<%
	
	

	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.selectCategoryList();
			

	
	
	//Arraylist에 넣기 goodslist
	ArrayList<HashMap<String,Object>> goodsPerCategory = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
	
	//디버깅
	System.out.println(categoryList);
	System.out.println(goodsPerCategory);
	 


%>
<!--view Layer  -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
<!-- Latest compiled JavaScript -->	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="../emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	
	
	<div class="container-fluid">
	<div class="row">
	<!--  서브메뉴 -->
	<div class="col-2 text-center mt-2 " style="font-size:17px;background-color:#ffffff;border-radius:10px;">
		<br>
		<a href="/shop/customer/customerGoodsList.jsp"><b>전체</b></a>
		<hr>
		<%
			for(HashMap m : categoryList){
				
		%>
			
			<a href="/shop/customer/customerGoodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
			</a>
	
			<hr>
		<% 

			}

		%>
		
	</div>

	
	<div class="col-10 d-flex align-items-center justify-content-center">
		<div style="text-align:center;">
	
	<h3 class="mt-5">OUR PRODUCTS</h3>
		<!-- 페이징 버튼 -->
		<div class="align-items-center" style="display: table;margin-left: auto; margin-right: auto;">
				
				<ul style="text-align:center;">
				
				
				<%
					if(currentPage > 1){
			
				%>
					<li><a href="./customerGoodsList.jsp?currentPage=1&category=<%=category%>"> << 처음 페이지&nbsp; </a></li>
					<li><a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">&nbsp; < 이전 </a></li>
				<%
					}else{
				%>	
					<li><a href="./customerGoodsList.jsp?currentPage=1&category=<%=category%>"> << 처음 페이지&nbsp; </a></li>
					<li><a href="./customerGoodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>"> &nbsp;< 이전 </a></li>
					
				<%	
					}
					if(currentPage<lastPage){
				%>
					<li><a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">&nbsp;| 다음 > </a></li>
					<li><a href="./customerGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>"> &nbsp;마지막 페이지 >></a></li>
				<%
					}else{
						
				%>
					<li><a href="./customerGoodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>"> &nbsp;다음 ></a></li>
					<li><a href="./customerGoodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>"> &nbsp;마지막 페이지 >></a></li>
				
				<% 
					}
				
				%>
				</ul>
				
			</div>
	
	<div>
	
	
		<%
			//6번째 박스마다 줄바꿈위해clear both 속성 추가해주
			int floatBoxCnt = 0;
			for(HashMap gpc: goodsPerCategory){
				if(category == "" | category.equals(category)){
					if(floatBoxCnt%5 == 0){
		%>	
		
			<a href="./goodsDetailForCustomer.jsp?goodsNo=<%=(Integer)(gpc.get("goodsNo"))%>" style="float:left; clear:both;">
					
					<img src="../upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200">
					
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%>원</div>
			</a>
			
		<%			
					}else{
		%>			
			<a href="./goodsDetailForCustomer.jsp?goodsNo=<%=(Integer)(gpc.get("goodsNo"))%>" style="float:left;margin-left:10px;">
					<img src="../upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200">
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%>원</div>
			</a>
			
		<% 		
					}
				}
	
				floatBoxCnt += 1;
						}
				
				
		%>
			
		
		
		<% 
			
			//System.out.println(floatBoxCnt);
			
		
		
		%>
		</div>
		</div>
		</div>
		
	
	
	
	</div>
	</div>
	

	
			
</body>
</html>
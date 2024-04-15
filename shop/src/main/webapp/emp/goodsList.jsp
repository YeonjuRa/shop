<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*"%>
<%@ page import="shop.dao.*"%>

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

	
		int currentPage = 1;
		if(request.getParameter("currentPage") != null){
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int rowPerPage = 15;
		int startRow = (currentPage-1) * rowPerPage;

%>
<!--ㅡMOdell Layer  -->
<%
	String category = request.getParameter("category");
	if(category == null){
		category = "";
	}
	//페이징
	int lastPage = GoodsDAO.page(category);
	//카테고리 리스트 출력
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.selectCategoryList();
	
	//Arraylist에 넣기
	ArrayList<HashMap<String,Object>> goodsList = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);
	
	
	//디버깅
	System.out.println(categoryList);
	
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

<link href="./stylesheet.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	<!-- include로 메뉴 출력, empMenu.jsp include : 주체가 server -->
	<!-- 주체가 서버이기에 include할때는 절대주소가 /shop/...시작하지 않는다... -->
	<div class="container-fluid">
	<div class="row">
	<!--  서브메뉴 -->
	<div class="col-2 text-center mt-2 " style="font-size:20px;background-color:#d9c1e3;border-radius:10px;">
		<br>
		<a href="/shop/emp/goodsList.jsp"><b>전체</b></a>
		<hr>
		<%
			for(HashMap m : categoryList){
				
		%>
			
			<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
			</a>
	
			<hr>
		<% 

			}

		%>

	
		<div style="font-weight:bold;">
			<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
		</div>
		
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
					<li ><a href="./goodsList.jsp?currentPage=1&category=<%=category%>"> << 처음 페이지&nbsp; </a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>">&nbsp; < 이전 </a></li>
				<%
					}else{
				%>	
					<li ><a href="./goodsList.jsp?currentPage=1&category=<%=category%>"> << 처음 페이지&nbsp; </a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>"> &nbsp;< 이전 </a></li>
					
				<%	
					}
					if(currentPage<lastPage){
				%>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">&nbsp;| 다음 > </a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>"> &nbsp;마지막 페이지 >></a></li>
				<%
					}else{
						
				%>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>"> &nbsp;다음 ></a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>"> &nbsp;마지막 페이지 >></a></li>
				
				<% 
					}
				
				%>
				</ul>
				
			</div>
	
	<div>
	
	
		<%
			//6번째 박스마다 줄바꿈위해clear both 속성 추가해주
			int floatBoxCnt = 0;
			for(HashMap gpc: goodsList){
				if(category == "" | category.equals(category)){
					if(floatBoxCnt%5 == 0){
		%>	
		
			<a href="./goodsDetail.jsp?goodsNo=<%=(Integer)(gpc.get("goodsNo"))%>" style="float:left; clear:both;">
					
					<img src="../upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200">
					
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%>원</div>
			</a>
			
		<%			
					}else{
		%>			
			<a href="./goodsDetail.jsp?goodsNo=<%=(Integer)(gpc.get("goodsNo"))%>" style="float:left;margin-left:10px;">
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
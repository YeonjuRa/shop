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
	
	
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "select category, count(*) cnt from goods group by category order by category asc";
	stmt1 = con.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
	while(rs1.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("category", rs1.getString("category"));
		m.put("cnt", rs1.getInt("cnt"));
		categoryList.add(m);
	}

	
	
	ResultSet rs2 = null;
	String sql2 = null;
	PreparedStatement stmt2 = null;
	//전체상품출력과 선택목록 출력 분
	if(category == ""){
		sql2 = "select * from goods limit ?,?";
		stmt2 = con.prepareStatement(sql2);
		stmt2.setInt(1, startRow);
		stmt2.setInt(2, rowPerPage);
	}else{
		sql2 = "select * from goods where category=? limit ?,?";
		stmt2 = con.prepareStatement(sql2);
		stmt2.setString(1,category);
		stmt2.setInt(2, startRow);
		stmt2.setInt(3, rowPerPage);
	}
	
	
	rs2 = stmt2.executeQuery();
	
	//Arraylist에 넣기
	ArrayList<HashMap<String,Object>> goodsPerCategory = new ArrayList<HashMap<String,Object>>();
	
	while(rs2.next()){
		HashMap<String,Object> gpc = new HashMap<String,Object>();
		gpc.put("category", rs2.getInt("goods_no"));
		
		gpc.put("goodsTitle", rs2.getString("goods_title"));
		
		gpc.put("goodsPrice", rs2.getInt("goods_price"));
		
		goodsPerCategory.add(gpc);
		
		
	}
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
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link href="./stylesheet.css" rel="stylesheet">
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand ps-5" href="#">Storemade</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">상품관리</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Dropdown
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#">Disabled</a>
      </li>
    
    </ul>
   
  	</div>
	</nav>
	
	</header>
	<div style="jusify-content:center;">
	
	
	<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<!-- 리스트 출력 -->
	<div style="justify-content:center;text-align:center;">
	
	<h3>OUR PRODUCTS</h3>
	
	<!-- 메뉴 사이드 출력  -->
	<div>
	<div style="float:left; width:200px; height:500px;  margin-left:30px; margin-top:5px; margin-right:20px;" class="sidemenu">
		<div>
		<a href="/shop/emp/goodsList.jsp" class="mt-2">전체</a>
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
	
		</div>
	
		<div style="font-weight:bold;">
			<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
		</div>
		
	</div>
	
	<div class="goods" style="width:80%; float:right; margin-left:10px;">
	
	
		<%
			//6번째 박스마다 줄바꿈위해clear both 속성 추가해주
			int floatBoxCnt = 0;
			for(HashMap gpc: goodsPerCategory){
				if(category == "" | category.equals(category)){
					if(floatBoxCnt%5 == 0){
		%>	
		
			<a href="#" style="float:left; clear:both;">
					<img src="./reference1.png" width="150" height="150">
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%>원</div>
			</a>
			
		<%			
					}else{
		%>			
			<a href="#" style="float:left;">
					<img src="./reference1.png" width="150" height="150">
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

		<!-- 페이징 버튼 -->
		<div style="clear:both;height:40px;display: grid;place-items: center;" class="mt-5">
				
				<ul class="paging" style="text-align:center;">
				
				
				<%
					if(currentPage > 1){
			
				%>
					<li ><a href="./goodsList.jsp?currentPage=1&category=<%=category%>"> << 처음 페이지 </a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>"> < 이전 </a></li>
				<%
					}else{
				%>	
					<li ><a href="./goodsList.jsp?currentPage=1&category=<%=category%>"> << 처음 페이지 </a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>"> < 이전 </a></li>
					
				<%	
					}
					if(currentPage<lastPage){
				%>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>">&nbsp; 다음 > </a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>"> 마지막 페이지 >></a></li>
				<%
					}else{
						
				%>
					<li><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>"> 다음 ></a></li>
					<li><a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>"> 마지막 페이지 >></a></li>
				
				<% 
					}
				
				%>
				</ul>
				
			</div>
			
</body>
</html>
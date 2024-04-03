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
		
		int rowPerPage = 10;
		int startRow = (currentPage-1) * rowPerPage;
		
		//lastPage 구하기
		
		String pageSql = "select count(*) from goods";
		
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
	
	/*
	category가 null이면
	select * from goods
	null이 아니면 
	select * from goods where category =?
	*/
	
	String category = request.getParameter("category");
	if(category == null){
		category = "";
	}
	
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
	<div style="jusify-content:center;">
	
	<div style="text-align:center;">
	<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
	</div>
	
	<!-- 서브메뉴 : 카테고리별 상폼리스트-->
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList){
				
		%>
			<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
					<%=(String)(m.get("category"))%>
					(<%=(Integer)(m.get("cnt"))%>)
				</a>

		<% 
			}
		
		
		%>
	
	</div>
	</div>
	<!-- 리스트 출력 -->
	<div style="justify-content:center;text-align:center;">
	<h3>OUR PRODUCTS</h3>
	<div style="margin-left: 80px;">
		<%
			for(HashMap gpc: goodsPerCategory){
				if(category == ""){
		%>			
			<a href="#" style="float:left; margin:10px;">
					<img src="./reference1.png" width="150" height="150">
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%></div>
			</a>
		<%	
				}else if(category.equals("가방")){
					
		%>			
				<a href="#" style="float:left;margin:10px;">
					<img src="./referencebag.png" width="150" height="150">
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%></div>
				</a>
		
		<%
				}else if(category.equals("상의")){
					
		%>			
				<a href="#" style="float:left;margin:10px;">
					<img src="./referenceshirts.png" width="150" height="150">
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%></div>
				</a>
				
			
		<%
				}else if(category.equals("액세서리")){
				
		%>			
				<a href="#" style="float:left;margin:10px;">
					<img src="./referenceac.png" width="150" height="150">
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%></div>
				
				</a>
	<% 		
				}else if(category.equals("원피스")){
			
	%>			
				<a href="#" style="float:left;margin:10px;">
					<img src="./reference1.png"  width="150" height="150">
					<div><%=(String)(gpc.get("goodsTitle"))%></div>
					<div><%=(Integer)(gpc.get("goodsPrice"))%></div>
				
				</a>
	<% 		
			}		
		
		%>
			
		
		
		<% 
			}
		
		
		%>
	</div>
	</div> 
	</div>
		<!-- 페이징 버튼 -->
		<div style="clear:both">
				<nav>
				<ul class="pagination justify-content-center">
				
				
				<%
					if(currentPage > 1){
				//1페이지보다 작을때 이전페이지로 이동을 못함
				//페이지번호가 1보다 클 때만 이전페이지 버튼 출력 + 다음페이지 버튼은 고정;
				%>
					<li class="page-item"><a href="./goodsList.jsp?currentPage=1&category=<%=category%>" class="page-link">처음 페이지</a></li>
					<li class="page-item"><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" class="page-link">이전</a></li>
				<%
					}else{
				%>	
					<li class="page-item disabled"><a href="./goodsList.jsp?currentPage=1&category=<%=category%>" class="page-link">처음 페이지</a></li>
					<li class="page-item disabled"><a href="./goodsList.jsp?currentPage=<%=currentPage-1%>&category=<%=category%>" class="page-link">이전</a></li>
					
				<%	
					}
					if(currentPage<lastPage){
				%>
					<li class="page-item"><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" class="page-link">다음</a></li>
					<li class="page-item"><a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>" class="page-link">마지막 페이지</a></li>
				<%
					}else{
						
				%>
					<li class="page-item disabled"><a href="./goodsList.jsp?currentPage=<%=currentPage+1%>&category=<%=category%>" class="page-link">다음</a></li>
					<li class="page-item disabled"><a href="./goodsList.jsp?currentPage=<%=lastPage%>&category=<%=category%>" class="page-link">마지막 페이지</a></li>
				
				<% 
					}
				
				%>
				</ul>
				</nav>
			</div>
			
</body>
</html>
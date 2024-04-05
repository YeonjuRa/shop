<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	

	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	
	//요청분석
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt= null;
	ResultSet rs = null;
	//sql -> 상품번호로 상품 상세보기 페이지로 넘어오기
	String sql = "select * from goods where goods_no = ?";
	stmt = con.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	rs = stmt.executeQuery();
	
	//리스트에 넣기
	ArrayList<HashMap<String,Object>> goodsPerCategory = new ArrayList<HashMap<String,Object>>();
		
	while(rs.next()){
			HashMap<String,Object> gpc = new HashMap<String,Object>();
		
			gpc.put("goodsNo",rs.getInt("goods_no"));
			gpc.put("category", rs.getString("category"));
			gpc.put("empId", rs.getString("emp_id"));
			gpc.put("goodsTitle", rs.getString("goods_title"));
			gpc.put("fileName", rs.getString("filename"));
			gpc.put("goodsContent", rs.getString("goods_content"));
			gpc.put("goodsPrice", rs.getInt("goods_price"));
			gpc.put("goodsAmount", rs.getInt("goods_amount"));
			gpc.put("createDate", rs.getString("create_date"));
			
			goodsPerCategory.add(gpc);
			
			
		
	}
	
		
	
	System.out.println(goodsPerCategory +"<--goodsPerCategory 디버깅");
	
		


%>
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
</head>
<body>
<div class="container-fluid">	
	<div class="row">
	<!--  서브메뉴 -->
	<div class="col-2 text-center">
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>

	
	</div>
	
	<div class="col-10">
		<h1>상품 상세 보기</h1>
	
		<%
		for(HashMap gpc : goodsPerCategory){
			
		%>	
		<div><img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200"></div>
		<div>카테고리 : <%=(String)(gpc.get("category"))%></div>
		<div>등록 아이디 : <%=(String)(gpc.get("empId")) %></div>
		<div>상품명 : <%=(String)(gpc.get("goodsTitle")) %></div>
		
		<div>설명: <%=(String)(gpc.get("goodsContent")) %></div>
		<div>가격: <%=(Integer)(gpc.get("goodsPrice")) %></div>
		<div>수량 :<%=(Integer)(gpc.get("goodsAmount")) %></div>	
		<div>등록일: <%=(String)(gpc.get("createDate")) %></div>	
		<%
		
		
		}
		
		%>

	
	<div>
	<!-- 상품번호 값 넘겨주기 -->
	<a href="./updateGoodsForm.jsp?goodsNo=<%=goodsNo%>">수정하기</a>
	<a href="./deleteGoodsForm.jsp?goodsNo=<%=goodsNo%>">삭제하기</a>
	</div>
	
	</div>
	</div>
	</div>
	
	
	
	
	
</body>
</html>
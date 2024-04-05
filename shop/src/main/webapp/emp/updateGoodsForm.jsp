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
			
			
			goodsPerCategory.add(gpc);
			
			
		
	}
	//수정 가능한 카테고리 값 불러오기 
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "select category from category";
	stmt1 = con.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	ArrayList<String> categoryList = new ArrayList<String>();
	while(rs1.next()){
		categoryList.add(rs1.getString("category"));
	}
		System.out.println(goodsPerCategory);
	
		


%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	<h1>상품등록</h1>
	<form method="post" action="/shop/emp/updateGoodsAction.jsp?goodsNo=<%=goodsNo%>" enctype="multipart/form-data">
		<%
			for(HashMap gpc: goodsPerCategory){
		%>
		<select name="category">
			<option value="<%=(String)(gpc.get("category")) %>"><%=(String)(gpc.get("category")) %></option>
			
		<%
			for(String c : categoryList){
				
			%>		
			<option value="<%=c%>"><%=c%></option>
			<% 
			
			}
			%>
			</select>
			<div>
			goods price:
				<input type="text" name="goodsPrice" value="<%=(Integer)(gpc.get("goodsPrice")) %>">
			</div>
			<div>
			goods amount:
				<input type="text" name="goodsAmount" value="<%=(Integer)(gpc.get("goodsAmount")) %>">
			</div>
			<div>
			goods image:
			<img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200">
			<input type="file" name="goodsImg" value="<%=(String)(gpc.get("fileName"))%>">
			</div>
			<div>
			goodsTitle:
			<input type="text" name="goodsTitle" value="<%=(String)(gpc.get("goodsTitle")) %>">
			</div>
			<div>
			goods content:
			<textarea cols="30" rows="4" name="goodsContent"><%=(String)(gpc.get("goodsContent")) %></textarea>
			</div>
			<% 
				}
			%>
	
		<button type="submit">등록하기</button>
	</form>
</body>
</html>
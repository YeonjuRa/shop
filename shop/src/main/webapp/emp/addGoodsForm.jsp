<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%

	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	

%>
<!--ㅡMOdell Layer  -->
<%
	//디비 연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "select category from category";
	stmt1 = con.prepareStatement(sql1);
	rs1 = stmt1.executeQuery();
	
	ArrayList<String> categoryList = new ArrayList<String>();
	while(rs1.next()){
		categoryList.add(rs1.getString("category"));
	}

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
	<form method="post" action="/shop/emp/addGoodsAction.jsp">
	<div>
		<select name="category">
			<option value="">선택</option>
			<%
			for(String c : categoryList){
			%>	
			<option value="<%=c%>"><%=c%></option>
			
			<% 
			}
			
			
			%>
		</select>
	</div>
	<!--emp id값은 현재 로그인 되있는 세션변수에서 바인딩 -> action페이지  -->
	<div>
		goods price:
		<input type="text" name="goodsPrice">
	</div>
	<div>
		goods amount:
		<input type="text" name="goodsAmount">
	</div>
	<div>
		goodsTitle:
		<input type="text" name="goodsTitle">
	</div>
	<div>
		goods content:
		<textarea cols="30" rows="4" name="goodsContent">설명입력</textarea>
	</div>
	<button type="submit">등록하기</button>
	</form>
</body>
</html>
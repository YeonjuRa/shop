<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

	//System.out.println(session.getAttribute("loginEmp"));
	
	//요청분석
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "select category, create_date from category";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = con.prepareStatement(sql);
	rs = stmt.executeQuery();
	//hashmap으로 옮기기
	ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("category",rs.getString("category"));
		m.put("createDate",rs.getString("create_date"));
		categoryList.add(m);
	}



%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<!-- 카테고리 리스트ㅡ 뿌리기 -->
	<table style="text-align:center">
		<tr>
			<td>카테고리명</td>
			<td>추가 날짜</td>
			<td>카테고리 삭제</td>
		</tr>
		
		<%
			for(HashMap m:categoryList){
		%>	<tr>
			<td><%=(String)(m.get("category")) %></td>
			<td><%=(String)(m.get("createDate")) %></td>
			<td><a href="./deleteCategoryForm.jsp?category=<%=(String)(m.get("category"))%>">삭제</a></td>
		
		<% 
			}
		
		
		%>
		</tr>
	
	
	</table>
	<div><a href="./addCategoryForm.jsp">카테고리 추가하기</a></div>
</body>
</html>
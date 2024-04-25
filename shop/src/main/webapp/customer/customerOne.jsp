<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));


%>
<%
	//회원정보 상세보기 페이지
	
	String id = request.getParameter("id");
	//id 기준
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select * from customer where mail = ?";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,id);
	rs = stmt.executeQuery();
	
	//리스트에 넣기
		ArrayList<HashMap<String,Object>> cusUpdateInfo = new ArrayList<HashMap<String,Object>>();
	while(rs.next()){
		HashMap<String,Object> cusInfo = new HashMap<String,Object>();
		
		
		
		cusInfo.put("id", rs.getString("mail"));
		cusInfo.put("name", rs.getString("name"));
		cusInfo.put("birth", rs.getString("birth"));
		cusInfo.put("gender", rs.getString("gender"));
		cusInfo.put("updateDate", rs.getString("update_date"));
		cusInfo.put("createDate", rs.getString("create_date"));
		
		
		
		cusUpdateInfo.add(cusInfo);
		
	}
	System.out.println(loginMember);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원 정보</title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
</head>
<body>
	
	<jsp:include page="/customer/customerMenu.jsp"></jsp:include>
	<div>
	<h4 style="text-align:center">회원정보 자세히 보기</h4>
	<table style="margin: auto;padding:auto;">
	<%
		for(HashMap c : cusUpdateInfo){
	%>
		<tr>
			<td>ID (Mail) : </td>
			<td><%=(String) c.get("id")%></td>
		</tr>
		
		<tr>
			<td>Name : </td>
			<td><%=(String) c.get("name")%></td>
		</tr>
		<tr>
			<td>Birth :</td>
			<td><%=(String) c.get("birth")%></td>
		</tr>
		<tr>
			<td>gender :</td>
			<td><%=(String) c.get("gender")%></td>
		</tr>
		<tr>
			<td>update Date :</td>
			<td><%=(String) c.get("updateDate")%></td>
		</tr>
		<tr>
			<td>create Date :</td>
			<td><%=(String) c.get("createDate")%></td>
		</tr>
	
	
	
	<% 
		}
	
	%>
	
	</table> 
	
	<div style="margin:10px"><a href="./updateCustomerForm.jsp?id=<%=id%>" >정보 수정하기</a></div>
	<div style="margin:10px"><a href="./editPwForm.jsp?id=<%=id%>" >비밀번호 변경</a></div>
	&#127826
	</div>
		<jsp:include page="/customer/footer.jsp"></jsp:include>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>
<!-- 부분 파일 -->
<%

	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

%>
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));
	//아이디 값 가져와서 value로 넣어주기
	
%>
<%
	
	
	String ck = request.getParameter("ck");
	if(ck == null){
		ck = "";
	}
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	

	
	//삭제할 상품 정보 확인을 위해 값 넣어주기 -> 상품번호,상품카테고리, 상품명, 이미지,가격
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	PreparedStatement stmt= null;
	ResultSet rs = null;
	
	String sql = "select * from goods where goods_no = ?";
	stmt = con.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	rs = stmt.executeQuery();
	
	//리스트에 넣기
	ArrayList<HashMap<String,Object>> goodsPerCategory = new ArrayList<HashMap<String,Object>>();
		
	while(rs.next()){
			HashMap<String,Object> gpc = new HashMap<String,Object>();
		
			gpc.put("category", rs.getString("category"));
			gpc.put("goodsTitle", rs.getString("goods_title"));
			gpc.put("fileName", rs.getString("filename"));
			gpc.put("goodsPrice", rs.getInt("goods_price"));
			
			goodsPerCategory.add(gpc);

	}
	System.out.println(goodsPerCategory+ "<--goodsPerCategory 디버깅 : deleteGoodsForm");

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
<div>
	<h4>본인확인을 위해 비밀번호를 다시 한번 입력해주세요. 이미 삭제한 상품은 되돌릴 수 없습니다</h4>
	<h4>삭제할 상품 정보</h4>
	<%
		if(ck == ""){
			
	%>
		<form method="post" action="./checkEmpIdForGoods.jsp">
		<table>
		<tr>
			<td>상품 번호 </td>
			<td><input type="text" name="goodsNo" value="<%=goodsNo%>" readonly></td>
		</tr>
		<tr>
		<%
			for(HashMap gpc : goodsPerCategory){
		%>
		
			<td>카테고리 </td>
			<td><input type="text" name="category" value="<%=(String)(gpc.get("category"))%>" readonly></td>
		</tr>
		<tr>
			<td>상품명 </td>
			<td><input type="text" name="goodsTitle" value="<%=(String)(gpc.get("goodsTitle"))%>" readonly></td>
		</tr>
		<tr>
			<td>상품 이미지 </td>
			<td><img src="/shop/upload/<%=(String)(gpc.get("fileName"))%>" width="200" height="200"></td>
		</tr>
		<tr>
			<td>가격 </td>
			<td><input type="text" name="goodsPrice" value="<%=(Integer)(gpc.get("goodsPrice"))%>" readonly></td>
		</tr>
		
		<% 
			}
		
		%>
		
		<tr>
			<td>아이디</td>
			<td><input type="text" name="empId" value="<%=(String)loginMember.get("empId")%>" readonly></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="empPw"></td>
		</tr>	
		</table>
		<button type="submit">사원 확인</button>
		</form>
	
	<% 
		}else if(ck.equals("T")){
	%>		
		<form method="post" action="./deleteGoodsAction.jsp">
		<table>
		<tr>
			<td>삭제할 상품 번호</td>
			<td><input type="text" name="goodsNo" value="<%=goodsNo%>" readonly></td>
		</tr>
		<tr>
			<td>사원 아이디</td>
			<td><input type="text" name="empId" value="<%=(String)loginMember.get("empId")%>" readonly></td>
		</tr>	
		</table>
		<button type="submit">삭제하기</button>
		</form>
	<%		
	
		}else{
	%>
			<div>비밀번호가 일치하지 않습니다. 다시 시도해주세요.</div>
			<a href="./deleteGoodsForm.jsp?goodsNo=<%=goodsNo%>">돌아가기</a>
			
	<% 
		}
	
	
	%>
	
</div>
</body>
</html>
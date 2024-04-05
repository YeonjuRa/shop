<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!-- Controller Layer -->
<%
	request.setCharacterEncoding("UTF-8");
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
	

%>
<!-- session 설정값 입력시 로그인 emp 의 emp id 값이 필요하다 -->
<%
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
%>
<!-- model Layer -->
<%	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	//파일 삭제하기 위해 디비에서 파일이름 가져오기
	String sql = "select filename from goods where goods_no = ?";
	stmt = con.prepareStatement(sql);
	stmt.setInt(1,goodsNo);
	
	System.out.println(stmt +"stmt 확인 :deleteGoodsAction");
	
	rs = stmt.executeQuery();
	
	String filename = null;
	while(rs.next()){ //파일 먼저 삭제하기
		filename = rs.getString("filename");
	
	}
	//파일 지우기
	String filePath = request.getServletContext().getRealPath("upload");
	File df = new File(filePath,filename);
	df.delete(); 
	System.out.println("파일삭제 완료");
	
	//데이터 베이스 에서 행 지우기
	PreparedStatement stmt2 =  null;
	String deleteSql = "delete from goods where goods_no = ?";
	stmt2 = con.prepareStatement(deleteSql);
	stmt2.setInt(1,goodsNo);
	int row = stmt2.executeUpdate();
	if(row != 0){
		System.out.println("해당 상품 삭제 성공");
		response.sendRedirect("./goodsList.jsp");
	}
	

%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

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
	
%>
<!-- model Layer -->
<%	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String category = request.getParameter("category");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount= Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	
	PreparedStatement stmt = null;
	String sql = "insert into goods (category,emp_id,goods_price,goods_amount,goods_title, goods_content,update_date,create_date) values(?,?,?,?,?,?,now(),now())";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,category);
	stmt.setString(2,(String)(loginMember.get("empId")));
	stmt.setInt(3,goodsPrice);
	stmt.setInt(4,goodsAmount);
	stmt.setString(5,goodsTitle);
	stmt.setString(6,goodsContent);
	System.out.println(stmt);
	
	int row = stmt.executeUpdate();
	if(row != 0){
		System.out.println("상품 등록 성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}else{
		System.out.println("상품 등록 실패");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}
	

%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>

<%
	//인정분기 : 세션변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") != null){
		response.sendRedirect("/shop/customer/mainCustomer.jsp");
		return;
	}

	//아이디, 비번 값 가져오기 -> 

	String cusId = request.getParameter("cusId");
	String cusPw = request.getParameter("cusPw");
	
	/* select mail,pw,name from customer where mail =? and pw = password(?);
	
	*/
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	con = DriverManager.getConnection(
			"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "select mail,pw,name from customer where mail =? and pw = password(?)";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,cusId);
	stmt.setString(2,cusPw);
	rs = stmt.executeQuery();
	
	if(rs.next()){
		System.out.println("로그인 성공");
		//하나의 세션변수 안에 여러개의 값을 넣기 -  이름 아이디 --> hasmap타입을 사용
		HashMap<String,Object> logincustomer = new HashMap<String,Object>();
		logincustomer.put("cusId",rs.getString("mail"));
		logincustomer.put("name",rs.getString("name"));
		session.setAttribute("loginCustomer",logincustomer);
		
		//디버깅
		HashMap<String,Object> m = (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("cusId")));
		System.out.println((String)(m.get("name")));

		response.sendRedirect("./mainCustomer.jsp");
	}else{
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
		response.sendRedirect("/shop/customer/loginCustomerForm.jsp?errMsg="+errMsg);
	}
	

%>
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
<!-- update할 값 가져오기 -->
<%
	HashMap<String,Object> loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));
	
	
%>
<!-- model Layer -->
<%	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = null;
	con = DriverManager.getConnection(
		"jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String category = request.getParameter("category");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount= Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	Part part = request.getPart("goodsImg");
	
	String originalName = part.getSubmittedFileName();
	
	//원본 이름에서 확장자만 분리
	int dotIndex = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIndex); //.png
	System.out.println(ext);
		
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString().replace("-","");
	filename = filename +ext;
	
	
	System.out.println(filename + "<--파일이름 디버깅 :updateGoodsAct");	
	
	PreparedStatement stmt = null;
	
	String sql = "update goods set category=?,emp_id=?,goods_price=?,goods_amount=?,goods_title=?,filename=?, goods_content=?,update_date=now() where goods_no=?";
	stmt = con.prepareStatement(sql);
	stmt.setString(1,category);
	stmt.setString(2,(String)(loginMember.get("empId")));
	stmt.setInt(3,goodsPrice);
	stmt.setInt(4,goodsAmount);
	stmt.setString(5,goodsTitle);
	stmt.setString(6,filename);
	stmt.setString(7,goodsContent);
	stmt.setInt(8,goodsNo);
	System.out.println(stmt +"stmt 확인 --> updateGoodsAction");
	
	int row = stmt.executeUpdate();
	if(row != 0){ //파일 업로드 part ->is -> os-> 빈 파일
		//1번
		InputStream is = part.getInputStream();
		//3+2번
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath,filename); //빈 파일
		//객체 생성 없이 불러서 - static
		OutputStream os = Files.newOutputStream(f.toPath()); //os+file
		is.transferTo(os);
		System.out.println("상품 업데이트 성공"); 
		response.sendRedirect("/shop/emp/goodsList.jsp");
		
		os.close();
		is.close();
	}else{
		System.out.println("상품 업데이트 실패");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="shop.dao.*"%>

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
	
	int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));
	String empId = (String)loginMember.get("empId");
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
	//updateGoods 쿼리 날리기
	int row = GoodsDAO.updateGoodsList(goodsNo, empId, category, goodsPrice, goodsAmount, goodsTitle, goodsContent, filename);

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
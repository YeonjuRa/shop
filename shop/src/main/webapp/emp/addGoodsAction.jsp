<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

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
	
	String category = request.getParameter("category");
	String empId = (String)loginMember.get("empId");
	int goodsPrice = Integer.parseInt(request.getParameter("goodsPrice"));
	int goodsAmount= Integer.parseInt(request.getParameter("goodsAmount"));
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsContent = request.getParameter("goodsContent");
	Part part = request.getPart("goodsImg");
	
	
	
	String originalName = part.getSubmittedFileName();
	String filename = null;
	
	if(originalName.length() == 0){
		filename = "default.jpg";
		
	}else{
		
		//원본 이름에서 확장자만 분리
		int dotIndex = originalName.lastIndexOf(".");
		String ext = originalName.substring(dotIndex); //.png
		System.out.println(ext);
		
		UUID uuid = UUID.randomUUID();
		filename = uuid.toString().replace("-","");
		filename = filename +ext;
	
	}
	
	

	int row = GoodsDAO.addGoodsAction(category, empId, goodsPrice, goodsAmount, goodsTitle, goodsContent, filename);
	
	if(row != 0){ //파일 업로드 part ->is -> os-> 빈 파일
		//1번
		InputStream is = part.getInputStream();
		//3+2번
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath,filename); //빈 파일
		//객체 생성 없이 불러서 - static
		OutputStream os = Files.newOutputStream(f.toPath()); //os+file
		is.transferTo(os);
		System.out.println("상품 등록 성공"); 
		response.sendRedirect("/shop/emp/goodsList.jsp");
		
		os.close();
		is.close();
	}else{
		System.out.println("상품 등록 실패");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}
	//지우기
	
	/* 
	File df = new File(filePath,rs.getString("filename"));
	df.delete(); */

%>
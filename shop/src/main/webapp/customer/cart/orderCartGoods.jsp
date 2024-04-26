<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import="java.util.*"%>
<%

	if(session.getAttribute("loginCustomer") == null){
		response.sendRedirect("/shop/customer/loginCustomer.jsp");
		return;
	}
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	String userId = (String) loginMember.get("mail");
	
	ArrayList<HashMap<String,Integer>> list = CartDAO.cntCartGoods(userId);
	
	//장바구니 행 개수 구하기 ->배열 돌릴 횟
	int cntCart = 0;
	for(HashMap<String,Integer> m : list){
		cntCart = (Integer)m.get("cntCart");
	}
	System.out.println(cntCart);
	
	//String mail,int goodsNo,int totalAmount,int totalPrice,String address
	String [] cartId = request.getParameterValues("cartId");
	int [] cartIds = new int[cntCart];
	
	
	//Values 받은 거  int 로 변환  
	for (int i = 0; i < cartIds.length; i++) {
		cartIds[i] = Integer.parseInt(cartId[i]); 
		
	}	
	
	for(int i=0; i<cartIds.length; i++){
		cartIds[i]
	}
	
	
	
	
	
	
	for(int i=1;i<=cntCart;i=i+1){
		OrderDAO.addOrderAction(mail, goodsNo, totalAmount, totalPrice, address);
		System.out.println("상품 주문 성공");
	}
	


%>


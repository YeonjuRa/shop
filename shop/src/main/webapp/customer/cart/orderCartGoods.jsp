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
	
	//ArrayList<HashMap<String,Integer>> list = CartDAO.cntCartGoods(userId);
	//회원 당 장바구니 행 개수 구하기 ->배열 돌릴 횟
	//int cntCart = 0;
	//for(HashMap<String,Integer> m : list){
	//cntCart = (Integer)m.get("cntCart");
	//}
	//System.out.println(cntCart);
	
	//String mail,int goodsNo,int totalAmount,int totalPrice,String address
	String [] cartId = request.getParameterValues("cartId");
	
	System.out.println(cartId.length + "String배열 cartId.length 디버깅");
	int [] cartIds = new int[cartId.length];
	
	
	//Values 받은 거  int 로 변환  --> values 를 받아야 카트 번호에 맞는 카트테이블 행을 가져올 수 있
	for (int i = 0; i < cartId.length; i++) {
		cartIds [i] = Integer.parseInt(cartId[i]); 
		System.out.println(cartIds[i] + "int배열 cartId.length 디버깅");
	}	
	//디버깅
	System.out.println(cartIds.length + " <--cartsIds length 디버깅");
	
	//주문DAO에 들어갈 파라미터값들
	ArrayList<HashMap<String,Object>> orderFromCart = new ArrayList<HashMap<String,Object>>();
	String mail = (String) loginMember.get("mail");
	int goodsNo = 0;
	int totalAmount = 0;
	int totalPrice = 0;
	String address = request.getParameter("address");
	
	int row= 0;
	int row1 = 0;
	
	for(int i=0; i<cartIds.length; i++){
		System.out.println(cartIds[i]);
		orderFromCart = CartDAO.selectGoodsPerCartId(cartIds[i]);
		for(HashMap<String,Object> m:orderFromCart){
			goodsNo = (Integer)(m.get("goodsNo"));
			totalAmount = (Integer)(m.get("totalAmount"));
			totalPrice = (Integer)(m.get("totalPrice"));
		}
		row = OrderDAO.addOrderAction(mail, goodsNo, totalAmount, totalPrice, address);
		row1 = CartDAO.deleteFromCart(cartIds[i]);
		
		
	}
	
	if(row != 0 && row1 != 0){
			System.out.println("장바구니 상품 주문 성공 및 장바구니 비워짐");
			
			response.sendRedirect("/shop/customer/ordersListForCustomer.jsp?id="+mail);
		}else{
			System.out.println("장바구니 상품 주문 실패 ");
			response.sendRedirect("/shop/customer/cart/cartList.jsp?id="+mail);
		}
	
	//반복해야한 거 -> 주문DAO 반복 횟수 - 위에받아온 cartIds 배열 길이 만큼 즉.length
	//주문 테이블에 넣기 전에 우선카트 번호로 +  카트안에 있는mail,goodsNo, totalAmout  값 가져오기//
	//장바구니에있는 상품들이 주문으로 넘어가면 장바구니 테이블에서는 삭제......복구 안됨...delete from cart where cart_id=?
	// 우선 전제 주문 -> 전체 장바구니에서 삭제 
	//오류 응답이 이미 커밋된 후에는, sendRedirect()를 호출할 수 없습니다.


%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%@ page import="java.util.*"%>
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	String mail = (String)loginMember.get("mail");
    int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
    //고객이 취소하기 버튼을 누르면 -> '결제완료' 인 주문만 취소가능 , 배송 중이거나 완료된 건은 취소 불가
    // ->delete from orders where orderNo = ? and state='결제 완료'
    
    //parameter totalAmount,goodsNo 구하기
    int totalAmount = 0;
    int goodsNo = 0;
    ArrayList<HashMap<String,Object>> list = OrderDAO.selectOrderOne(ordersNo);
    for(HashMap<String,Object> m : list){
    	 totalAmount = (Integer)(m.get("totalAmount"));
    	goodsNo = (Integer)(m.get("goodsNo"));
    }
    int row = OrderDAO.cancelOrderActoin(ordersNo);
    //실행시 결제완료 -> 취소완료 로 state값 변경
    
    if(row != 0){
    	System.out.println("상품 주문 취소 완료" +"<--cancelOrderAction.jsp");
    	// 구매했던 상품 주문 취소시 수량 되돌리기
    	// update goods set goods_amount = goods_amount +1 where goods_no
    	GoodsDAO.cancelGoodsAmount(totalAmount, goodsNo);
    	System.out.println("주문 재고 업데이트 완료");
    	response.sendRedirect("/shop/customer/ordersListForCustomer.jsp?id="+mail);
    }else{
    	System.out.println("상품 주문 취소 실패");
    	response.sendRedirect("/shop/customer/ordersListForCustomer.jsp?id="+mail);
    }
    
    
    
%>

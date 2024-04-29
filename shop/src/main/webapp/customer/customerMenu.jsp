<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- 부분 파일 -->
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));


%>
<style>
	header{
	font-size:20px;
	
	
	}
	ul{display: table;margin-left: auto; margin-right: auto;}
	li{
		padding-left:40px;
	}
	.headermenu{
	background-color:#EDD39B;
	height:60px;
	text-align:right;
	border-style:none;
	padding-right:30px;
	padding-top:20px;
	}
</style>

<header>
	
<%
	if(session.getAttribute("loginCustomer") == null){
%>
	<div style="background-color:#EDD39B;height:60px;text-align:right;border-style:none;">
		<div style="margin-right:50px;padding-top:20px">
		<a href="/shop/customer/cart/cartList.jsp">shopping cart | </a>
  		<a href="/shop/customer/loginCustomer.jsp">login</a>
 		</div>
	</div>



<%
		
	}else{
		
%>
	<div class="headermenu">
	<a href="/shop/customer/customerOne.jsp?id=<%=(String)loginMember.get("mail")%>"><%=(String)loginMember.get("name")%></a>
  		님 | 
  	<a href="/shop/customer/cart/cartList.jsp?id=<%=(String)loginMember.get("mail")%>"> shopping cart | </a>
  	<a href="/shop/customer/ordersListForCustomer.jsp?id=<%=(String)loginMember.get("mail")%>">내 주문 |</a>
  	<a href="/shop/customer/commentListForCustomer.jsp?id=<%=(String)loginMember.get("mail")%>"> 내 후기 </a>
  
    	
    	</div>



<%
	}
%>
	<div class="text-center bg-white pt-3"><a href="/shop/customer/mainCustomer.jsp">&#127826<br>STOREMADE</a></div>
	
		

		<nav class="navbar navbar-expand-lg navbar-white">

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/shop/customer/customerGoodsList.jsp">Shop all <span class="sr-only"></span></a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="/shop/customer/customerGoodsList.jsp?category=가방">bags</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="/shop/customer/customerGoodsList.jsp?category=원피스">dress</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/shop/customer/customerGoodsList.jsp?category=액세서리">accessories</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/shop/customer/customerGoodsList.jsp?category=상의">shirts</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/shop/customer/customerGoodsList.jsp?category=기프트 카드">gift card</a>
      </li>
      
    </ul>
   	
  	</div>
  
  	
  	
	</nav>
	
	</header>

	

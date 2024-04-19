<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- 부분 파일 -->
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));


%>
<style>
	header{
	font-size:20px;
	
	border-bottom:1px solid;
	}
	ul{display: table;margin-left: auto; margin-right: auto;}
	
</style>

<header>
	<div class="text-center bg-white pt-3"><a href="./mainCustomer.jsp">&#127826<br>STOREMADE</a></div>
	
		<%
  		if(session.getAttribute("loginCustomer") == null){
  	%>
  		<div class="text-end pe-5 bg-white">
  		<a href="./loginCustomer.jsp">로그인 |</a>
  		<a href="./registerCustomerForm.jsp"> 회원가입</a>
  		<br>
  		<!-- <a href="../emp/empLoginForm.jsp">관리자 로그인 |</a>
  		<a href="../emp/addEmpForm.jsp"> 사원 추가</a> -->
  		</div>
  		
  	<%
  		}else{
  	%>		
  		<div class="text-end bg-white"><a href="./customerOne.jsp?id=<%=(String)loginMember.get("mail")%>"><%=(String)loginMember.get("name")%></a>
  		님 안녕하세요 :)
  		<div><a href="/shop/customer/ordersListForCustomer.jsp?id=<%=(String)loginMember.get("mail")%>">내 주문 목록으로 이동하기</a></div>
    	<a class=" float-right ms-5 me-5" href="./logoutCustomer.jsp"><img src="../emp/logoutIcon.png" style="width:30px; height:30px; border:0px;">
    	</a></div>
  	
  	<% 
  		}
  	%>
  	
  
  	


		<nav class="navbar navbar-expand-lg navbar-white" style="background-color:#e2c1f5">

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="./customerGoodsList.jsp">Shop all <span class="sr-only"></span></a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="./customerGoodsList.jsp?category=가방">bags</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="./customerGoodsList.jsp?category=원피스">dress</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./customerGoodsList.jsp?category=액세서리">accessories</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./customerGoodsList.jsp?category=상의">shirts</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">gift card</a>
      </li>
      
    </ul>
   	
  	</div>
  
  	
  	
	</nav>
	
	</header>

	

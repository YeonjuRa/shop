<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));
	
	ArrayList<HashMap<String, Object>> NewProductsList = GoodsDAO.NewProductsList();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="/shop/emp/stylesheet.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gaegu&family=Jost:ital,wght@0,100..900;1,100..900&family=Roboto+Condensed:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
<style>
*{
	font-family: "Gaegu", sans-serif;
  font-weight: 400;
  font-style: normal;
	}

/* 슬라이더 애니메시션 참고 -// 
https://velog.io/@wswy17/CSS-animation-%ED%99%9C%EC%9A%A9%ED%95%B4-slider-%EB%A7%8C%EB%93%A4%EA%B8%B0 */
	.slider {
  overflow: hidden;
  width: 100vw;
  height: 100vh;
  position: relative;

}

.slider .slide {
  position: absolute;
  top: 0;
  left: 0;
  width: 700px;
  height: 900px;
  background-size: cover;
  background-position: center;
  animation: slide 15s infinite;
}

.slider .slide:nth-child(1) {
  background-image: url('/shop/img_source/photo_0.JPG');
 	
  animation-delay: -0;
  
}

.slider .slide:nth-child(2) {
  background-image: url('/shop/img_source/photo_2.JPG');
  animation-delay: -5s;
  
  
}
  
.slider .slide:nth-child(3) {
  background-image: url('/shop/img_source/photo_3.JPG');
  animation-delay: -10s;
  
  
}
  

@keyframes slide {
  		0% {
    transform: translateX(0);
  }

  26% {
    transform: translateX(0);
  }
  33% {
    transform: translateX(-100%);
    animation-timing-function: step-end;
  }
  93% {
    transform: translateX(100%);
  }

  100% {
    transform: translateX(0);
  }

}
.btnToGoods {
     background-color: #BFB4EA;
     color: maroon;
     padding: 15px 25px;
     text-align: center;
     text-decoration: none;
     display: inline-block;
     font-size:15px;
     
}



</style>
</head>
<body>

<!-- 사이드 메뉴창  -->

<jsp:include page="/customer/customerMenu.jsp"></jsp:include>


<div class="container-fluid">

		<!-- 메인 페이지 블록 1 +이미지 -->
	<div>
		<div  class="slider">
			<div class="slide"></div>
			<div class="slide"></div>
			<div class="slide"></div>
		<div style="float:right;position:relative;">
			<img src="/shop/img_source/Home.jpg" width="600" height="900">
			<img src="/shop/img_source/photo_6.JPG" width="600" height="900">
		</div>
		</div>
		</div>
		</div>
		
		
	
		<div style="padding:10px"></div>
		
		<div style="background-color:#EDD39B;height:500px;text-align:center;padding-top:50px">
		
		<img src="/shop/img_source/photo_4.JPG" width="600" height="400" style="float:left">
		<img src="/shop/img_source/photo_5.JPG" width="600" height="400" style="float:right">
		<h3>
		<b>Start Your Adventure in Style! <br>
		Explore a World of New Fashion!</b>
		</h3>
		<br>
		<br>
		<br>
		<br>
		<a class="btnToGoods" href="/shop/customer/customerGoodsList.jsp"><b>Shop All Right Now!</b></a>

		</div>
	
<jsp:include page="/customer/footer.jsp"></jsp:include>



</body>
</html>
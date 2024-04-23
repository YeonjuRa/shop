<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginCustomer"));


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
<style>

/* 슬라이더 애니메시션 참고 - 
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
  width: 100%;
  height: 600px;
  background-size: cover;
  background-position: center;
  animation: slide 15s infinite;
}

.slider .slide:nth-child(1) {
  background-image: url('./main.png');
 
  animation-delay: -0;
}

.slider .slide:nth-child(2) {
  background-image: url('./main2.avif');
  animation-delay: -5s;
  
}
  
.slider .slide:nth-child(3) {
  background-image: url('./main3.avif');
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
	
</style>
</head>
<body>
<!-- 사이드 메뉴창  -->

<jsp:include page="/customer/customerMenu.jsp"></jsp:include>


<div class="container-fluid">
	<div class="row">
		<div class="col-10" style="postition:relative;">
		<!-- 메인 페이지 블록 1 +이미지 -->
		<div>
		<div  class="slider">
			<div class="slide"></div>
			<div class="slide"></div>
			<div class="slide"></div>
		</div>
		<h3 class="text-center ">ㅁㄴㅇㄻㄴㅇㄹ</h3>
		</div>
	</div>
	<div class="col-2">
	<div style="height:600px;position: absolute; background-color:#ebe7a9;border-radius:5px;">
		<div style="padding:5px;">
		Lorem ipsum dolor sit amet, consectetur 
		adipiscing elit, 
		 
		
		</div>
	
	</div>
	</div>



</div>
</div>
<hr>
<footer>
	<div>2024 Goodee Aca.</div>
</footer>
</body>
</html>
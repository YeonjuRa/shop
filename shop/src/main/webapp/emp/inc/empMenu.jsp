<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!-- 부분 파일 -->
<%
	HashMap<String,Object>  loginMember = (HashMap<String,Object>) (session.getAttribute("loginEmp"));


%>
<style>
	header{
	font-size:20px;
	border-bottom:1px solid;
	}
	ul{display: table;margin-left: auto; margin-right: auto;}
	
</style>

<header>
		<nav class="navbar navbar-expand-lg navbar-white bg-white">
  <a class="navbar-brand" style="padding-left:5%;"href="#">Storemade</a>
  

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only"></span></a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="./goodsList.jsp">상품 관리</a>
      </li>
       <li class="nav-item">
        <a class="nav-link" href="./empList.jsp">사원 관리</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="./categoryList.jsp">카테고리 관리</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Other</a>
      </li>
      
    </ul>
   	
  	</div>
  		<a href="./empOne.jsp?empId=<%=(String)loginMember.get("empId")%>" ><%=(String)loginMember.get("empName")%></a>님 안녕하세요 :)
    	<a class="nav-link float-right ms-5 me-5" href="./empLogoutAction.jsp"><img src="./logoutIcon.png" style="width:30px; height:30px; border:0px;"></a>
	</nav>
	
	</header>

	

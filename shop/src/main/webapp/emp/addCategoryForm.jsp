<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	//인정분기
	if(session.getAttribute("loginEmp") == null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<div>
	<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
</div>
<div>
<h4>카테고리 추가하기</h4>
<form method="post" action="./addCategoryAction.jsp">
	<table>
		<tr>
			<td>추가할 카테고리 이름:</td>
			<td><input type="text" name="category"></td>
		</tr>
	</table>
	<button type="submit">추가하기</button>
	</form>
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*"%>

<%
	//인정분기 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}

	//아이디, 비번 값 가져오기 -> 요청 분석
	//1)controller
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	/* select emp_id empId from emp where active-'ON' and emp_id =? and emp_Pw = password(?);
	
	실패 /emp/empLoginForm.jsp
	성공 /emp/empList.jsp
	*/
	
	//2)model layer -->DAO 추가로 model layer는 사라짐
		/*String sql = "select emp_id empId, emp_name empName, grade from emp where active = 'ON' and emp_id = ? and emp_pw= password(?)";
		stmt = con.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		rs = stmt.executeQuery(); */
	//DAO로 변경 ->모델을 호출하는 코드
	HashMap<String,Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	
		
	//1)controller
	if(loginEmp == null){  //-->loginEmp 안에 resultMap 값이 들어가서 만약 null이면 -> 로그인 실패
		System.out.println("로그인 실패");
		//하나의 세션변수 안에 여러개의 값을 넣기 - 등급 이름 아이디 --> hasmap타입을 사용
		String errMsg = URLEncoder.encode("아이디와 비밀번호를 확인 해주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg);
	
	}else{
		System.out.println("로그인 성공");
		session.setAttribute("loginEmp",loginEmp);
		response.sendRedirect("./empList.jsp");
	}
	

%>

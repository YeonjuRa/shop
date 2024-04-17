package shop.dao;
import java.util.*;
import java.sql.*;

//emp 테이블 CRUD 하는  Static 메서드 컨데이너
public class EmpDAO {
	
	public static int addEmp(String empId,String empPw,String empName,String empJob,String hireDate) throws Exception {
		int row = 0;
		//디비 접근
		Connection con = DBHelper.getConnection();
		
		String sql = "insert into emp (emp_id,emp_pw,emp_name, emp_job,hire_date,update_date,create_date) values (?,password(?),?,?,?,now(),now())";
		PreparedStatement stmt = con.prepareStatement(sql);
		
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		stmt.setString(5, hireDate);
		
		row = stmt.executeUpdate();
		System.out.println(row);
		
		con.close();
		return row;
		
	}
	//반환 타입 , HashMap <String,Object> : null이면 로그인 실패,아니면 성공
	//String empId,String empPw : 로그인 폼에서 사용자가 입력한 id/pw
	//호출코드 HashMap<String,Object> m = EmpDAO.empLogin("admin","1234")
	public static HashMap<String,Object> empLogin(String empId,String empPw) throws Exception{
		HashMap<String,Object> resultMap = null;
		
		//DB 접근
		//예외처리
		Connection con = DBHelper.getConnection();
	
		String sql = "select emp_id empId, emp_name empName, grade from emp where active = 'ON' and emp_id = ? and emp_pw= password(?)";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			//결과물이 있으면 resultMap에 채우기
			resultMap = new HashMap<String,Object> ();
			resultMap.put("empId",rs.getString("empId"));
			resultMap.put("empName",rs.getString("empName"));
			resultMap.put("grade",rs.getInt("grade"));
		}
		con.close(); //--> 이거 안하면 디비 서버가 다운될 수도 있음
		return resultMap; //-->읽어올 값이 없으면 null
	}
	//호출 -> updateEmpForm.jsp  , empOne.jsp
	//param -> string empId ->아이디로 분기
	//return ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> updateEmpForm(String empId) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>> ();
		Connection con = DBHelper.getConnection();
		String sql = "select * from emp where emp_id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, empId);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			
			
			m.put("grade", rs.getInt("grade"));
			m.put("empId", rs.getString("emp_id"));
			m.put("empName", rs.getString("emp_name"));
			m.put("empJob", rs.getString("emp_job"));
			m.put("hireDate", rs.getString("hire_date"));
			m.put("updateDate", rs.getString("update_date"));
			m.put("createDate", rs.getString("create_date"));
			
			
			
			list.add(m);
			
		}
		
		con.close();
		return list;
	}
	//호출 -> updateEmpAction.jsp
	//param : empId, empName,dmt,hireDate
	//return : int row
	public static int updateEmpAction(String empId,String empName,String empJob,String hireDate) throws Exception{
		int row = 0;
		Connection con = DBHelper.getConnection();
		String sql = "update emp set emp_name=?,emp_job=?,hire_date=?, update_date=now() where emp_id=?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, empName);
		stmt.setString(2, empJob);
		stmt.setString(3, hireDate);
		stmt.setString(4, empId);
		
		row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	//호출 modifyEmpActive.jsp
	//param : String empId, String active
	//return : int row
	public static int modifyEmpActive(String empId,String active) throws Exception{
		int row =0;
		Connection con = DBHelper.getConnection();
		
		String sql = "update emp set active = ? where emp_id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,active);
		stmt.setString(2, empId);

		
		row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	
	//호출 -> empList.jsp
	//parmam : startRow, rowPerPage
	public static ArrayList<HashMap<String,Object>> empList (int startRow,int rowPerPage) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql ="select emp_id empId,emp_name empName, emp_job empJob,hire_date hireDate,active from emp order by hire_date desc limit ?,?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("empId", rs.getString("empId"));   //--> 아이디 값이 들어감
			m.put("empName",rs.getString("empName"));
			m.put("empJob",rs.getString("empJob"));
			m.put("hireDate",rs.getString("hireDate"));
			m.put("active",rs.getString("active"));
			list.add(m);
			//rs행의 수만큼 리스트가 채워진다.
		}
		con.close();
		return list;
	}
	//호출 ->checkEmpIdForGoods, checkEmpId(category).jsp
	public static int checkEmpId (String empId,String empPw) throws Exception{
		int row = 0;
		Connection con = DBHelper.getConnection();
		String sql = "select emp_id empId, emp_name empName from emp where active = 'ON' and emp_id = ? and emp_pw= password(?)";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = 1;
		}else {
			row =0;
		}
		con.close();
		return row;
	}
}

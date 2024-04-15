package shop.dao;
import java.util.HashMap;
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

}

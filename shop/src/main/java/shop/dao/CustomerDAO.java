package shop.dao;

import java.sql.*;
import java.util.*;


public class CustomerDAO {
		//회원가입 시 아이디 중복확인하기
		//customerCheckId
		//param : String 
		//return: boolean -사용할 수 있으면 사용가능하면 true , 불가면 false)
		public static boolean checkMail(String mail) throws Exception{
			boolean result = false;
			
			Connection con = DBHelper.getConnection();
			String sql = "select mail from customer where mail = ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1,mail);
			ResultSet rs = stmt.executeQuery();
			if(!rs.next()) { //사용불가
				result = true;
			}
			con.close();
			return result;
		}
		//회원 가입 액션 ->호출 : addCustomerAction.jsp , 
		//param : customer....
		//return : int row -> 1이면 입력 성공  -> 0 입력실패
		public static int registerCustomer (String mail,String pw, String name,String birth,String gender) throws Exception{
			int row = 0;
			Connection con = DBHelper.getConnection();
			String sql = "insert into customer (mail,pw,name,birth,gender,create_date,update_date) values (?,password(?),?,?,?,now(),now())";
			PreparedStatement stmt = con.prepareStatement (sql);
			stmt.setString(1, mail);
			stmt.setString(2, pw);
			stmt.setString(3, name);
			stmt.setString(4, birth);
			stmt.setString(5, gender);
			row = stmt.executeUpdate();
			
			con.close();
			return row;
			
		}
		
		//로그인 메서드
		//호출: loginAction.jsp
		//param : String (mail), String(pw)
		//return: HashMap (메일, 이름);
		public static HashMap<String,String> login(String mail,String pw) throws Exception{
			HashMap<String,String> map = null;
			
			Connection con = DBHelper.getConnection();
			String sql = "select mail,name from customer where mail =? and pw =password(?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, mail);
			stmt.setString(2, pw);
			
			
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				map = new HashMap<String,String>();
				map.put("mail", rs.getString("mail"));
				map.put("name", rs.getString("name"));
			} 
			con.close();
			return map;
		}
		
		
		//회원 탈퇴
		//호출 -> deleteCustomerAction.jsp
		//param: String(세션안의 mail),String(pw)
		//return: int row -> 1 이면 탈퇴, 0이면 탈퇴 실패
		public static int deleteCustomer (String mail, String pw) throws Exception{
			int row = 0;
			Connection con = DBHelper.getConnection();
			
			String sql ="delete from customer where mail=? and pw=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, mail);
			stmt.setString(2, pw);
			row = stmt.executeUpdate();
			
			con.close();
			return row;
			
			
		}
		//비밀번호 수정
		//호출 : editPwAction.jsp
		//param: String mail, String 수정전 pw, String 수정 후 pw;
		//return : int row (1성공, 0 실패);
		public static int updatePw(String mail, String oldPw, String newPw) throws Exception{
			int row = 0;
			Connection con = DBHelper.getConnection();
			
			String sql ="update customer set pw=password(?) where mail=? and pw=password(?)";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, newPw);
			stmt.setString(2, mail);
			stmt.setString(3, oldPw);
			row = stmt.executeUpdate();
			
			con.close();
			return row;
		}
		//회원정보 수정
		//호출: editPwAction.jsp
		//param: String name,String birth, gender, update_date,String mail
		public static int updateCustomerAction (String name,String birth,String gender,String id) throws Exception{
			int row = 0;
			Connection con = DBHelper.getConnection();
			String sql = "update customer set name=?,birth=?,gender=?, update_date=now() where mail=?";
			PreparedStatement stmt = con.prepareStatement(sql);
			
			stmt.setString(1,name);
			stmt.setString(2,birth);
			stmt.setString(3,gender);
			stmt.setString(4,id);
			
			row = stmt.executeUpdate();
			
			con.close();
			return row;
			
		}
		
}

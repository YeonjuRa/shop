package shop.dao;
import java.sql.*;
import java.util.*;
public class CategoryDAO {
	public static ArrayList<String> categoryList () throws Exception{
		ArrayList<String> categoryList = new ArrayList<String>();
		Connection con = DBHelper.getConnection();
		
		
		String sql = "select category from category";
		PreparedStatement stmt = con.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		
		while(rs.next()){
			categoryList.add(rs.getString("category"));
		}
		con.close();
		return categoryList;
	}
	public static ArrayList<HashMap<String, Object>> selectCategoryList () throws Exception {
		ArrayList<HashMap<String, Object>> categoryList =
				new ArrayList<HashMap<String, Object>>();
		Connection con = DBHelper.getConnection();
		
		
		String sql = "select category, create_date from category";
		
		PreparedStatement stmt = con.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		//hashmap으로 옮기기

		while(rs.next()){
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("category",rs.getString("category"));
			m.put("createDate",rs.getString("create_date"));
			categoryList.add(m);
		}
		con.close();
		return categoryList;
	}
	public static int addCategory (String category) throws Exception{
		Connection con = DBHelper.getConnection();
		
		
		String sql = "insert into category (category,create_date) values(?,now())";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,category);
		System.out.println(stmt);

		int row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
}

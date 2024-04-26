package shop.dao;

import java.sql.*;

public class CartDAO {
	//호출 : insertIntoCart.jsp
	//param: user_id, goods_id, numbers(수량)
	//return int row
	public static int insertIntoCart (String userId, String goodsNo, int numbers) throws Exception{
		Connection con = DBHelper.getConnection();
		String sql ="INSERT INTO cart (user_id,goods_no,numbers) VALUES (?,?,?)";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, userId);
		stmt.setString(2, goodsNo);
		stmt.setInt(3,numbers);
		
		int row = stmt.executeUpdate();
		
		con.close();
		return row;
	}
	//호출: selectCartList.jsp
	//param: String userId
	//return ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectCartList () throws Exception{
		
	}
}

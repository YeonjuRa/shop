package shop.dao;

import java.sql.*;
import java.util.*;

public class CartDAO {
	//호출 : insertIntoCart.jsp
	//param: user_id, goods_id, numbers(수량)
	//return int row
	public static int insertIntoCart (String userId, int goodsNo, int numbers) throws Exception{
		Connection con = DBHelper.getConnection();
		String sql ="insert into cart (user_id,goods_no,numbers) VALUES (?,?,?)";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, userId);
		stmt.setInt(2, goodsNo);
		stmt.setInt(3,numbers);
		
		int row = stmt.executeUpdate();
		con.close();
		return row;
	}
	//호출: selectCartList.jsp
	//param: String userId
	//return ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectCartList (String userId) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql = "select c.*, g.goods_title ,g.filename,goods_price from cart c inner join goods g on c.goods_no = g.goods_no where c.user_id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1, userId);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			m.put("cartId", rs.getInt("cart_id"));
			m.put("userId", rs.getString("user_id"));
			m.put("goodsNo", rs.getInt("goods_no"));
			m.put("numbers", rs.getInt("numbers"));
			m.put("goodsTitle", rs.getString("goods_title"));
			m.put("filename", rs.getString("filename"));
			m.put("totalPrice", rs.getInt("goods_price"));
			list.add(m);
		}
		con.close();
		return list;
		
	
	}
	//호출 orderCartGoods.jsp
	//param: int cartId
	//return: ArrayList<HashMap<String,Object>>
	public static ArrayList<HashMap<String,Object>> selectGoodsPerCartId(int cartId) throws Exception{
		ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		Connection con = DBHelper.getConnection();
		String sql = "select c.*,g.goods_price*c.numbers totalPrice from cart c inner join goods g on c.goods_no = g.goods_no where c.cart_id = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setInt(1, cartId);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<>();
			
			m.put("goodsNo", rs.getInt("goods_no"));
			m.put("totalAmount", rs.getInt("numbers"));
			m.put("totalPrice", rs.getInt("totalPrice"));
			
			
			list.add(m);
		}
		con.close();
		return list;
	}
	//호출 orderCartGoods.jsp
		//param: String userId
		//return: ArrayList<HashMap<String,Integer>>
		public static ArrayList<HashMap<String,Integer>> cntCartGoods(String userId) throws Exception{
			ArrayList<HashMap<String,Integer>> list = new ArrayList<HashMap<String,Integer>>();
			Connection con = DBHelper.getConnection();
			String sql = "select count(*) cntCart from cart where user_id =?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, userId);
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String,Integer> m = new HashMap<>();
				m.put("cntCart", rs.getInt("cntCart"));
				
				
				list.add(m);
			}
			con.close();
			return list;
		}
		//호출 deleteFromCart.jsp
		//param: String user_id
		//return int row
		public static int deleteFromCart (String userId) throws Exception{
			int row = 0;
			Connection con = DBHelper.getConnection();
			String sql = "delete from cart where user_id = ?";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, userId);
			row = stmt.executeUpdate();
			
			con.close();
			return row;
		}

}
